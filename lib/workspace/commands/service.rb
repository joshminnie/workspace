module Workspace
  module Commands
    class Service < Thor
      include Thor::Actions
      include Workspace::Docker

      # Gives the Thor commands a root directory to operate from.
      def self.source_root
        File.dirname(File.expand_path('../../../workspace', __dir__))
      end

      desc 'new SERVICE', 'Create a new service from template'
      option :image, type: :string, required: true, aliases: :i, desc: 'base image for the container'
      option :ignore, type: :boolean, desc: 'ignore this new service; do not include it as tracked files'
      def new(service)
        root = service_root(service)

        empty_directory("#{root}")
        empty_directory("#{root}/data")
        create_file("#{root}/data/.gitkeep")
        template('lib/generators/services/Dockerfile', "#{root}/Dockerfile", image: options[:image])
        template('lib/generators/services/docker-compose.yml', "#{root}/docker-compose.yml", service: service)
        copy_file('lib/generators/services/.dockerignore', "#{root}/.dockerignore")
        insert_into_file('workspace.json', "\n    \"#{service}\": { \"environments\": [] },", after: '"services": {')

        unless options[:ignore]
          insert_into_file('.gitignore', "\n!#{root}", after: '# BEGIN allowlisting services')
          insert_into_file('workspace.sample.json', "\n    \"#{service}\": { \"environments\": [] },", after: '"services": {')
        end
      end

      desc 'start SERVICE', 'Starts up the specified service'
      option :build, type: :boolean
      def start(service)
        root = service_root(service)
        environments = Workspace.configuration.services.dig(service, 'environments') || []

        create_file("#{root}/.env")
        environments.each do |env|
          append_file("#{root}/.env", File.read("environments/#{env}"))
        end

        docker("compose --file #{root}/docker-compose.yml up #{options[:build] ? '--build' : nil}")
      end

      desc 'clean SERVICE', 'Cleans the service container back to defaults'
      def clean(service)
        return unless ask("Are you sure you want to remove all data for the #{service} container?")

        root = service_root(service)

        remove_file("#{root}/.env")
        remove_dir("#{root}/data")
        empty_directory("#{root}/data")
        create_file("#{root}/data/.gitkeep")
      end

      no_commands do
        # Gets the path to the root directory of the specified service.
        # @param service [String] The service identifier.
        def service_root(service)
          "services/#{service}"
        end
      end
    end
  end
end
