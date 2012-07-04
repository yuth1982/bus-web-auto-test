module Bus
  class Partner
    attr_accessor :name, :company_name,
                  :street_address, :city, :state, :state_abbrev, :country, :zip, :phone, :email,
                  :vat_num,:parent_partner, :company_type, :couple_code, :use_company_info,
                  :subscription_period, :has_initial_purchase,
                  :net_term_payment, :credit_card_name, :credit_card_number, :credit_card_cvv, :credit_card_exp_mm, :credit_card_exp_yyyy

    def initialize
      first_name = Forgery::Name.first_name
      last_name = Forgery::Name.last_name

      @name = "#{first_name} #{last_name}"
      @company_name = "#{Forgery::Name.company_name} Company"

      # Company & Billing information
      @country = "United States"
      # Gets a random us state or abbreviation
      @state_abbrev = Forgery::Address.state_abbrev
      @state = Forgery::Address.state

      @street_address= Forgery::Address.street_address
      @city = Forgery::Address.city
      @zip = "12345" #Forgery::Address.zip
      @phone = "1234567890" #Forgery::Address.phone
      @email = "#{Bus::EMAIL_PREFIX}+#{first_name}+#{last_name}@mozy.com".downcase
      @vat_num = ""

      @parent_partner = Bus::MOZY_ROOT_PARTNER[:mozy_pro]
      @company_type = Bus::COMPANY_TYPE[:business]
      @couple_code = ""

      @subscription_period = 1
      @has_initial_purchase = true

      @use_company_info = true

      @credit_card_name = @name
      @credit_card_number =  "4111111111111111"
      @credit_card_cvv = rand(100..999).to_s
      @credit_card_exp_mm = rand(1..12).to_s

      year = DateTime.now.year
      @credit_card_exp_yyyy = rand((year + 1)..(year + 5)).to_s

      @net_term_payment = false
    end

    def to_s
      "company: #{@company_name}\naddress: #{@street_address}\ncity: #{@city}\nstate: #{@state}\nstate abbrev: #{@state_abbrev}\ncountry: #{@country}\nzip: #{@zip}\nphone: #{@phone}\nname: #{@name}\nemail: #{@email}\nvat_num: #{@vat_num}\nparent partner: #{@parent_partner}\ncompany type: #{@company_type}\ncouple code: #{@couple_code}\nuse company info: #{@use_company_info}\nsubscription period: #{@subscription_period}\nhas initial purchase: #{has_initial_purchase}\nnet term payment: #{@net_term_payment}\ncredit card name: #{@credit_card_name}\ncredit card number: #{@credit_card_number}\ncredit card cvv: #{@credit_card_cvv}\ncredit card exp mm: #{@credit_card_exp_mm}\ncredit card exp yyyy: #{@credit_card_exp_yyyy}"
    end
  end
end