module Aria
  class Account
    attr_accessor :first_name, :last_name, :street_address, :suite, :city, :country, :state_abbrev, :state, :zip,
                  :phone, :email,:same_billing_address, :user_name, :password, :secret_question, :secret_answer,
                  :promo_code, :plan_mapping, :server_lic_num, :server_quota_num, :desktop_lic_num, :desktop_quota_num,
                  :credit_card_number, :cvv, :credit_card_exp_mm, :credit_card_exp_yyyy

    def initialize
      @first_name = Forgery::Name.first_name
      @last_name = Forgery::Name.last_name

      @street_address= Forgery::Address.street_address
      @suite = ""
      @city = Forgery::Address.city
      @country = ""
      @state_abbrev = Forgery::Address.state_abbrev
      @state = Forgery::Address.state
      @zip = Forgery::Address.zip
      @phone = Forgery::Address.phone
      @email = "qa1+#{first_name}+#{last_name}@mozy.com"
      @same_billing_address = true

      @user_name =  "#{first_name}_#{last_name}"
      @password = DEFAULT_PWD
      @secret_question = "What city or town were you born in?"
      @secret_answer = "Shanghai"

      @promo_code = ""
      @plan_mapping = ""

      @server_lic_num = 1 #rand(1..15)
      @server_quota_num = 10 #(rand(10..100)*10)
      @desktop_lic_num = 1 #rand(1..15)
      @desktop_quota_num = 10 #(rand(10..100)*10)

      @credit_card_number = "4111111111111111"
      #Forgery::CreditCard.number(:type => 'Visa', :length => 16)

      @cvv = rand(100..999).to_s
      @credit_card_exp_mm = rand(1..12).to_s
      @credit_card_exp_yyyy = rand(2013..2027).to_s

    end

  end
end