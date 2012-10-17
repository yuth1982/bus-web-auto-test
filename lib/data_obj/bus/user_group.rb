module Bus
  module DataObj
    # This class contains attributes for user
    class UserGroup
      attr_accessor :name, :billing_code, :default_server_quota, :default_desktop_quota

      def initialize
        @name = Forgery::Name.first_name
        @billing_code = ""
        @default_server_quota = 2
        @default_desktop_quota = 2
      end
    end
  end
end
