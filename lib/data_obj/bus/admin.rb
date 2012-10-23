module Bus
  module DataObj
    # This class contains attributes for add new admin
    class Admin
      attr_accessor :name, :email, :parent, :user_group, :num_desktop_licenses, :desktop_quota

      def initialize
        first_name = Forgery::Name.first_name
        last_name = Forgery::Name.last_name
        @name = "#{first_name} #{last_name}"
        @email = "#{CONFIGS['global']['email_prefix']}+#{first_name}+#{last_name}+#{Time.now.strftime("%H%M")}@mozy.com".downcase
        @parent = 0
        @user_group = 0
        @num_desktop_licenses = 0
        @desktop_quota = 0
      end
    end
  end
end
