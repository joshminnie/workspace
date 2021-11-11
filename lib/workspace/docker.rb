module Workspace
  module Docker
    def docker(command)
      say_status('docker', command)
      system("docker #{command}")
    end
  end
end
