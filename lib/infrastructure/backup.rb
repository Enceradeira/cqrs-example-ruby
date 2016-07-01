require_relative '../application/registry'
require_relative '../../lib/infrastructure/resources'

module Infrastructure
  class Backup
    class << self
      def backup_and_restore
        commands = Application::Registry.command_backup.commands

        Resources.init

        bus = Application::Registry.command_bus
        commands.each do |cmd|
          bus.send_cmd(cmd)
        end
      end
    end
  end
end