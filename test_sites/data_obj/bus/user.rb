module Bus
  module DataObj
    # This class contains attributes for user
    class User
      attr_accessor :name, :email, :user_group, :storage_type, :storage_limit, :devices, :enable_stash, :send_email

      def initialize
        @name = Forgery::Name.first_name
        @email = "#{CONFIGS['global']['email_prefix']}+#{Forgery(:basic).password(:at_least => 9, :at_most => 12)}@decho.com".downcase
      end

    end
  end
end