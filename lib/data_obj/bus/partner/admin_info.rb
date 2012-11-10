module Bus
  module DataObj
    # This class contains attributes for admin information
    class AdminInfo
      attr_accessor :first_name, :last_name, :full_name, :email, :root_role

      # Public: Initialize a AdminInfo Object
      #
      def initialize
        @first_name = Forgery::Name.first_name
        @last_name = Forgery::Name.last_name
        @full_name = "#@first_name #@last_name"
        @email = "#{CONFIGS['global']['email_prefix']}+#{first_name}+#{last_name}+#{Time.now.strftime("%H%M")}@mozy.com".downcase
        @root_role = ""
      end
    end
  end
end