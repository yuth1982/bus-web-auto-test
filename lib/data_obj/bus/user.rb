module Bus
  module DataObj
    # This class contains attributes for user
    class User
      attr_accessor :name, :email, :user_group, :server_licenses, :server_quota, :desktop_licenses, :desktop_quota

      def initialize
        first_name = Forgery::Name.first_name
        last_name = Forgery::Name.last_name
        @name = "#{first_name} #{last_name}"
        @email = "#{Bus::EMAIL_PREFIX}+#{first_name}+#{last_name}+#{Time.now.strftime("%H%M")}@mozy.com".downcase
        @user_group = ""
        @server_licenses = 0
        @server_quota = 0
        @desktop_licenses = 0
        @desktop_quota = 0
      end
    end
  end
end
