module Bus
  module DataObj
    # This class contains attributes for user
    class User
      attr_accessor :name, :email, :num_server_licenses, :server_quota, :num_desktop_licenses, :desktop_quota

      def initialize
        first_name = Forgery::Name.first_name
        last_name = Forgery::Name.last_name
        @name = "#{first_name} #{last_name}"
        @email = "#{Bus::EMAIL_PREFIX}+#{first_name}+#{last_name}+#{Time.now.strftime("%H%M")}@mozy.com".downcase
        @num_server_licenses = 0
        @server_quota = 0
        @num_desktop_licenses = 0
        @desktop_quota = 0
      end
    end
  end
end
