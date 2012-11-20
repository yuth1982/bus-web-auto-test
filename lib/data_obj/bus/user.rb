module Bus
  module DataObj
    # This class contains attributes for user
    class User
      attr_accessor :name, :email, :user_group, :server_licenses, :server_quota, :desktop_licenses, :desktop_quota,
                    :enable_stash, :stash_quota, :send_stash_invite

      def initialize
        @name = Forgery::Name.first_name
        @email = "#{CONFIGS['global']['email_prefix']}+#{name}+#{Time.now.strftime("%H%M")}@mozy.com".downcase
        @user_group = ""
        @server_licenses = 0
        @server_quota = 0
        @desktop_licenses = 0
        @desktop_quota = 0
        @enable_stash = false
        @stash_quota = 0
        @send_stash_invite = false
      end
    end
  end
end
