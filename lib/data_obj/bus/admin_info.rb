module Bus
  class AdminInfo
    attr_accessor :first_name, :last_name, :full_name, :email
    def initialize
      @first_name = Forgery::Name.first_name
      @last_name = Forgery::Name.last_name
      @full_name = "#@first_name #@last_name"
      @email = "#{Bus::EMAIL_PREFIX}+#{first_name}+#{last_name}+#{Time.now.strftime("%H%M")}@mozy.com".downcase
    end
  end
end