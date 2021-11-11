module Workspace
  module Commands
    class Service < Thor
      include Thor::Actions
      include Workspace::Docker

      desc 'start SERVICE', 'Starts up the specified service'
      option :build, type: :boolean
      def start(service)
        root = service_root(service)
        environments = Workspace.configuration.services.dig(service, 'environments')

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
