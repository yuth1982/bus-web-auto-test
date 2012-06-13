module Bus
  class Partner
    attr_accessor :name, :company_name, :street_address, :city, :state, :state_abbrev, :country, :zip, :phone, :email, :vat_num,
                  :has_initial_purchase,
                  :subscription_period, :supp_plan, :has_server_plan,
                  :num_enterprise_users,
                  :reseller_type, :reseller_quota, :reseller_add_on_quota,
                  :parent_partner, :company_type, :couple_code,
                  :use_company_info, :net_term_payment,
                  :credit_card_name, :credit_card_number, :credit_card_cvv, :credit_card_exp_mm, :credit_card_exp_yyyy

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
      @email = "qa1+#{first_name}+#{last_name}@mozy.com"
      @vat_num = ""

      @parent_partner = Bus::MOZY_ROOT_PARTNER[:mozy_pro]
      @company_type = Bus::COMPANY_TYPE[:business]
      @couple_code = ""

      @has_initial_purchase = true

      @subscription_period = 1
      @supp_plan = ""
      @supp_plan_id = ""
      # MozyPro server add-on
      @has_server_plan = false
      # MozyEnterprise single users
      @num_enterprise_users = 1

      @reseller_type = "Silver"
      @reseller_quota = 1
      @reseller_add_on_quota = 0

      @use_company_info = true

      @credit_card_name = @name
      @credit_card_number =  "4111111111111111"
      @credit_card_cvv = rand(100..999).to_s
      @credit_card_exp_mm = rand(1..12).to_s
      @credit_card_exp_yyyy = rand(2013..2027).to_s

      @net_term_payment = false
    end

    #def total_licence_num
    #  (server_lic_num + desktop_lic_num).to_s
    #end

    #def total_quota
    #  (server_quota + desktop_quota).to_s
    #end
  end
end