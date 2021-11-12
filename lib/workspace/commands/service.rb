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
      option :platform, type: :string, aliases: :p, desc: 'platform for the container'
      option :ignore, type: :boolean, desc: 'ignore this new service; do not include it as tracked files'
      def new(service)
        root = service_root(service)

        empty_directory("#{root}")
        empty_directory("#{root}/data")
        create_file("#{root}/data/.gitkeep")
        template('lib/generators/services/Dockerfile', "#{root}/Dockerfile", image: options[:image])
        props = { service: service }
        props.merge!(platform: options[:platform]) if options[:platform]
        template('lib/generators/services/docker-compose.yml', "#{root}/docker-compose.yml", **props)
        copy_file('lib/generators/services/.dockerignore', "#{root}/.dockerignore")
        insert_into_file('workspace.json', "\n    \"#{service}\": { \"environments\": [] },", after: '"services": {')

        unless options[:ignore]
          insert_into_file('.gitignore', "\n!#{root}", after: '# BEGIN allowlisting services')
          insert_into_file('workspace.sample.json', "\n    \"#{service}\": { \"environments\": [] },", after: '"services": {')
        end
      end

      # Starts up the specified service.
      # @example Start the mysql57 service container
      #   workspace service start mysql57
      desc 'start SERVICE', 'Starts up the specified service'
      option :build, type: :boolean
      option :detach, type: :boolean, aliases: :d, desc: 'Detach from the container after start up'
      def start(service)
        root = service_root(service)

        if !File.exists?("#{root}/.env") || options[:build]
          environments = Workspace.configuration.services.dig(service, 'environments') || []

          create_file("#{root}/.env")
          environments.each do |env|
            append_file("#{root}/.env", File.read("environments/#{env}"))
          end
        end

        docker("compose --file #{root}/docker-compose.yml up #{options[:detach] ? '-d' : nil} #{options[:build] ? '--build' : nil}")
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
