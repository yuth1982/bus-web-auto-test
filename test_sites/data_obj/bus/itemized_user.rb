module Bus
  module DataObj
    # This class contains attributes for user
    class ItemizedUser
      attr_accessor :name, :email, :user_group, :devices_server, :quota_server, :devices_desktop,
                    :quota_desktop, :enable_stash, :stash_quota, :send_invite

      def initialize
        @name = Forgery::Name.first_name
        @email = "#{CONFIGS['global']['email_prefix']}+#{Forgery(:basic).password(:at_least => 12, :at_most => 15)}@decho.com".downcase
      end

    end
  end
end