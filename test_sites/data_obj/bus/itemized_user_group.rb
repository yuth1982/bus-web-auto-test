module Bus
  module DataObj
    # This class contains attributes for user group
    class ItemizedUserGroup
      attr_accessor :name,
                    :desktop_storage_type, :desktop_assigned, :desktop_max, :desktop_device,
                    :server_storage_type, :server_assigned, :server_max, :server_device,
                    :enable_stash

      def initialize
        @name = "#{Forgery::Name.company_name} Group"
      end
    end
  end
end
