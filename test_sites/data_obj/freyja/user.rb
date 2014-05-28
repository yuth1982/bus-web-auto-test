module Freyja
  module DataObj
    # This class contains attributes for user
    class User
      attr_accessor :partnerType, :username,:password,:new_password, :deviceTab, :sync_machineID, :sync_file, :sync_folder, :backup_machineID, :backup_file, :backup_folder, :sync_file_versions, :backup_file_versions, :device_Radio_preference, :restore_queue

      def initialize
        super
        @partnerType = ""
        @username = ""
        @password = ""
        @deviceTab = ""
        @sync_machineID = ""
        @sync_file = ""
        @sync_folder = ""
        @backup_machineID = ""
        @backup_file = ""
        @backup_folder = ""
        @new_password = ""
        @sync_file_versions = ""
        @backup_file_versions = ""
        @device_Radio_preference = ""
        @restore_queue = ""
      end

      def to_s
        %{#{super}
        partnerType: #@partnerType
        username: #@username
        password: #@password
        deviceTab: #@deviceTab
        sync_machineID: #@sync_machineID
        sync_file: #@sync_file
        sync_folder: #@sync_folder
        new_password: #@new_password
        sync_file_versions: #@sync_file_versions
        backup_file_versions: #@backup_file_versions
        device_Radio_preference: #@device_Radio_preference
        restore_queue: #@restore_queue
        }
      end

    end
  end
end
