module Workspace
  class Configuration
    # Returns the name of the configured docker network.
    # @return [String]
    attr_reader :network

    # Returns the list of services.
    attr_reader :services

    def initialize
      file = File.expand_path('../../workspace.json', __dir__)
      raise ArgumentError, 'configuration file, workspace.json, does not exist' unless File.exists?(file)
      configuration = ::JSON.parse(File.read(file))

      @network = configuration['network']
      @services = configuration['services']
    end
  end

  # @return [Clearance::Configuration] Clearance's current configuration
  def self.configuration
    @configuration ||= Configuration.new
  end
end
