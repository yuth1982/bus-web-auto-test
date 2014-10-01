
#@type has options of Home|Pro|Direct|Free
#Direct is a pro partner using the other signup page
#@attributes is a hash of details
#Ex {"base plan"=>"free","country"=>"United States"}
def phoenix_create_partner_or_user(type,attributes)
  # initial object instantiation
  @partner = ((type == "Pro" || type == "Direct") ? Bus::DataObj::MozyPro.new : Bus::DataObj::MozyHome.new )

  # account type and relevant items
  @partner.partner_info.type = ((type == "Pro" || type == "Direct") ? "MozyPro" : "MozyHome")
  @partner.base_plan = attributes["base plan"] || ""
  @partner.has_server_plan = (attributes["server plan"] || "no").eql?("yes")

  if (type == "Home" || type == "Free")
    @partner.has_stash = (attributes["has stash"] || "no").eql?("yes")
    @partner.additional_computers = attributes['addl computers'] unless attributes['addl computers'].nil?
    @partner.additional_storage = attributes['addl storage'] unless attributes['addl storage'].nil?
  end

  # Company info attributes
  @partner.company_info.name = attributes['company name'] unless attributes['company name'].nil?
  @partner.company_info.name = "Internal Mozy - #{@partner.company_info.name}" if  ENV['BUS_ENV'] == 'prod'
  @partner.company_info.address = attributes['address'] unless attributes['address'].nil?
  @partner.company_info.city = attributes['city'] unless attributes['city'].nil?
  @partner.company_info.state = attributes['state'] unless attributes['state'].nil?
  @partner.company_info.state_abbrev = attributes['state abbrev'] unless attributes['state abbrev'].nil?
  @partner.company_info.country = attributes["country"] unless attributes['country'].nil?
  @partner.company_info.zip = attributes['zip'] unless attributes['zip'].nil?
  @partner.company_info.phone = attributes['phone'] unless attributes['phone'].nil?
  @partner.company_info.vat_num = attributes["vat number"] unless attributes["vat number"].nil?
  @partner.company_info.security = attributes["security"].nil? ? "Standard" : attributes['security']

  # Partner info attributes
  @partner.partner_info.coupon_code = attributes["coupon"] unless attributes["coupon"].nil?

  # Partners added through phoenix do not get to select their parent.
  # It is assigned based on their 'dom' and product selection
  if type == "Pro" || type == "Direct"
    #parent is MozyPro
    @partner.partner_info.parent = case @partner.company_info.country
                                     when "Ireland"
                                       #parent is
                                       'MozyPro Ireland'
                                     when "United Kingdom"
                                       #parent is
                                       'MozyPro UK'
                                     when "Germany"
                                       #parent is
                                       'MozyPro Germany'
                                     when "France"
                                       #parent is
                                       'MozyPro France'
                                     when "United States"
                                       #parent is
                                       'MozyPro'
                                   end
  elsif type == "Home" || type == "Free"
    #parent is MozyHome
    @partner.partner_info.parent = case @partner.company_info.country
                                     when "Ireland"
                                       #parent is
                                       'MozyHome Ireland'
                                     when "United Kingdom"
                                       #parent is
                                       'MozyHome UK'
                                     when "Germany"
                                       #parent is
                                       'MozyHome Germany'
                                     when "France"
                                       #parent is
                                       'MozyHome France'
                                     when "United States"
                                       #parent is
                                       'MozyHome'
                                   end
  else
    raise "unsupported user type"
  end

  # Admin existing email check
  attributes['admin email'] = @existing_user_email if attributes['admin email'] == '@existing_user_email'
  attributes['admin email'] = @existing_admin_email if attributes['admin email'] == '@existing_admin_email'


  # Admin info attributes
  @partner.admin_info.full_name = attributes["admin name"] unless attributes["admin name"].nil?
  @partner.admin_info.email = attributes["admin email"] unless attributes["admin email"].nil?

  # Account Details
  @partner.account_detail.account_type = "Live"
  @partner.account_detail.sales_origin = "Web"

  # Billing info attributes
  # Not implemented, always use company info

  # Credit card info attributes
  @partner.credit_card.first_name = attributes["cc first name"] unless attributes["cc first name"].nil?
  @partner.credit_card.last_name = attributes["cc last name"] unless attributes["cc last name"].nil?
  @partner.credit_card.number = attributes["cc number"] unless attributes["cc number"].nil?
  @partner.credit_card.expire_month = attributes["expire month"] unless attributes["expire month"].nil?
  @partner.credit_card.expire_year = attributes["expire year"] unless attributes["expire year"].nil?
  @partner.credit_card.cvv = attributes["cvv"] unless attributes["cvv"].nil?

  # Common attributes
  @partner.subscription_period = attributes["period"]

  #Maybe change the
  if (type == "Home" || type == "Free")
    case
      when attributes["period"].eql?("1")
        @partner.subscription_period = "M"
      when attributes["period"].eql?("12")
        @partner.subscription_period = "Y"
      when attributes["period"].eql?("24")
        @partner.subscription_period = "2"
    end
  end

  Log.debug(@partner)

  case type
    when "Direct"
      @phoenix_site.phoenix_acct_fill_out.go_to_pro_direct_page
      @phoenix_site.select_dom.select_country(@partner)
      @phoenix_site.phoenix_acct_fill_out.direct_fill_out(@partner)
    when "Free"
      @phoenix_site.phoenix_acct_fill_out.go_to_home_free
      @phoenix_site.select_dom.select_country(@partner)
      @phoenix_site.phoenix_acct_fill_out.free_user_info_input(@partner)
    when "Pro"
      @phoenix_site.select_dom.select_country(@partner)
      @phoenix_site.phoenix_acct_fill_out.admin_info_fill_out(@partner)
    when "Home"
      @phoenix_site.select_dom.select_country(@partner)
      @phoenix_site.phoenix_acct_fill_out.admin_info_fill_out(@partner)
  end

  #If catches an error of already used email
  unless @phoenix_site.phoenix_acct_fill_out.stuck_on_sign_up? || type == "Free"
    @phoenix_site.licensing_fill_out.licensing_billing_fillout(@partner)
    @phoenix_site.licensing_fill_out.has_vat_error?.should_not be_true
    @phoenix_site.billing_fill_out.billing_info_fill_out(@partner)
  end


end

def phoenix_create_partner_user_success
  if @partner.partner_info.type == "MozyPro"
    @phoenix_site.reg_complete_pg.go_to_account_verify(@partner)
    @bus_site = BusSite.new unless !@bus_site.nil?
    @bus_site.admin_console_page.partner_created(@partner)
    #TODO: localized logic is tied to phoenix even if this is verified in BUS(@phoenix_site is misleading)
    @phoenix_site.reg_complete_pg.logout(@partner)
  else
    # if not a pro acct - its a home acct, but need to determine type still
    if @partner.base_plan == "free" #reg_complete_pg.check_url == "Home"
      # free acct url end with: registration/free_finish
      @phoenix_site.reg_complete_pg.free_home_success(@partner)
      sleep 2 # time for systems to catch up, this may be a symptom of a race condition w/ the mail systems
    else
      # paid accts url ends with: registration/mozy_home_finish
      @phoenix_site.reg_complete_pg.home_success(@partner)
      sleep 2 # time for systems to catch up, this may be a symptom of a race condition w/ the mail systems
    end
  end
end
