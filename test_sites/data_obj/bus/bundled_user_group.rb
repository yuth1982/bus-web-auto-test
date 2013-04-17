module Bus
  module DataObj
    # This class contains attributes for user group
    class BundledUserGroup
      attr_accessor :name,
                    :generic_storage_type, :generic_assigned, :generic_max, :generic_server_support,
                    :enable_stash

      def initialize
        @name = "#{Forgery::Name.company_name} Group"
      end
    end
  end
end
