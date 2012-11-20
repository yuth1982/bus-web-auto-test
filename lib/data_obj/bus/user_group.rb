module Bus
  module DataObj
    # This class contains attributes for user group
    class UserGroup
      attr_accessor :name, :billing_code, :server_quota, :desktop_quota, :stash_quota
      def initialize
        @name = Forgery::Name.first_name
        @billing_code = ""
        @server_quota = 0
        @desktop_quota = 0
        @stash_quota = 0
      end
    end
  end
end
