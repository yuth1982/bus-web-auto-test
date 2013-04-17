module Bus
  module DataObj
    # This class contains attributes for user
    class User
      attr_accessor :name, :email, :user_group, :storage_type, :storage_max, :devices, :enable_stash, :send_email

      def initialize
        @name = rand_name
        @email = rand_email
      end

      def rand_name
        Forgery::Name.first_name
      end

      def rand_email
        "#{CONFIGS['global']['email_prefix']}+User+#{Time.now.strftime('%H%M%S')}@decho.com".downcase
      end
    end
  end
end
