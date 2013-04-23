module Bus
  module DataObj
    # This class contains attributes for user group
    class BundledUserGroup
      attr_accessor :name,
                    :storage_type, :assigned_quota, :max_quota, :server_support,
                    :enable_stash

      def initialize
        @name = "#{Forgery::Name.company_name} Group"
      end
    end
  end
end
