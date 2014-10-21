

def bus_create_partner(type,attributes)
  #@type a string of one of these values: MozyPro|MozyEnterprise|Reseller|MozyEnterprise DPS|OEM
  #@attributes a hash with options: account type,address,admin email,admin name,base plan,cc first name,
  # cc last name,cc number,city,company name,country,coupon,create under,cvv,expire month,expire year,
  # net terms,period,phone,sales channel,sales origin,security,state,state abbrev,vat number,zip,
  # reseller quota,reseller type,root role,server add on,server plan,stash grant plan,storage add on,users,

  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['add_new_partner']) unless type == "OEM"

  case type
    when CONFIGS['bus']['company_type']['oem']
      step %{I act as partner by:}, table(%{
      |name|including sub-partners|
      |Fortress|no|})
      step %{I act as partner by:}, table(%{
      |name|including sub-partners|
      |MozyOEM|no|})
      step %{I add a new sub partner:}, table(%{
      |#{partner_table.headers.join('|')}|
      |#{partner_table.rows.first.join('|')}|})
    when CONFIGS['bus']['company_type']['mozypro']
      @partner = Bus::DataObj::MozyPro.new
      @partner.partner_info.type = type
      @partner.has_initial_purchase = false if attributes["base plan"].nil?
      @partner.base_plan = attributes["base plan"] || ""
      @partner.has_server_plan = (attributes["server plan"] || "no").eql?("yes")
      @partner.has_stash_grant_plan = (attributes["stash grant plan"] || "no").eql?("yes")
      @partner.storage_add_on =  attributes["storage add on"] || 0
      @partner.admin_info.root_role = attributes["root role"] || CONFIGS['bus']['root_role']['mozypro']
    when CONFIGS['bus']['company_type']['mozyenterprise']
      @partner = Bus::DataObj::MozyEnterprise.new
      @partner.partner_info.type = type
      @partner.has_initial_purchase = false if attributes["users"].nil?
      @partner.num_enterprise_users = attributes["users"] || 0
      @partner.server_plan = attributes["server plan"] || "None"
      @partner.num_server_add_on = attributes["server add on"] || 0
      @partner.admin_info.root_role = attributes["root role"] || CONFIGS['bus']['root_role']['mozyenterprise']
    when CONFIGS['bus']['company_type']['mozyenterprise_dps']
      @partner = Bus::DataObj::MozyEnterpriseDPS.new
      @partner.partner_info.type = type
      @partner.has_initial_purchase = false if attributes['base plan'].nil?
      @partner.base_plan = attributes["base plan"] || 0
      @partner.admin_info.root_role = attributes["root role"] || CONFIGS['bus']['root_role']['mozyenterprise']
    when CONFIGS['bus']['company_type']['reseller']
      @partner = Bus::DataObj::Reseller.new
      @partner.partner_info.type = type
      @partner.has_initial_purchase = false if attributes["reseller type"].nil?
      @partner.reseller_type = attributes["reseller type"] || attributes["reseller type"].nil?
      @partner.reseller_quota = attributes["reseller quota"] || 0
      @partner.reseller_add_on_quota = attributes["storage add on"] || 0
      @partner.has_server_plan = (attributes["server plan"] || "no").eql?("yes")
      @partner.has_stash_grant_plan = (attributes["stash grant plan"] || "no").eql?("yes")
      @partner.admin_info.root_role = attributes["root role"] || CONFIGS['bus']['root_role']['reseller']
      @partner.account_detail.sales_channel = 'Reseller'
    else
      raise "Error: Company type #{type} does not exist."
  end

  unless type == "OEM"
    # Company info attributes
    @partner.company_info.name = attributes['company name'] unless attributes['company name'].nil?
    @partner.company_info.address = attributes['address'] unless attributes['address'].nil?
    @partner.company_info.city = attributes['city'] unless attributes['city'].nil?
    @partner.company_info.state = attributes['state'] unless attributes['state'].nil?
    @partner.company_info.state_abbrev = attributes['state abbrev'] unless attributes['state abbrev'].nil?
    @partner.company_info.country = attributes["country"] unless attributes['country'].nil?
    @partner.company_info.zip = attributes['zip'] unless attributes['zip'].nil?
    @partner.company_info.phone = attributes['phone'] unless attributes['phone'].nil?
    @partner.company_info.vat_num = attributes['vat number'] unless attributes["vat number"].nil?
    @partner.company_info.security = attributes['security'] unless attributes["security"].nil?

    # Partner info attributes
    @partner.partner_info.coupon_code = attributes['coupon'] unless attributes['coupon'].nil?
    @partner.partner_info.parent = attributes['create under'] || CONFIGS['bus']['mozy_root_partner']['mozypro']

    # Admin existing email check
    attributes['admin email'] = @existing_user_email if attributes['admin email'] == '@existing_user_email'
    attributes['admin email'] = @existing_admin_email if attributes['admin email'] == '@existing_admin_email'

    # Admin info attributes
    @partner.admin_info.full_name = attributes['admin name'] unless attributes['admin name'].nil?
    @partner.admin_info.email = attributes['admin email'] unless attributes['admin email'].nil?

    # Account Details
    @partner.account_detail.account_type = attributes['account type'] unless attributes['account type'].nil?
    @partner.account_detail.sales_origin = attributes['sales origin'] unless attributes['sales origin'].nil?
    @partner.account_detail.sales_channel = attributes['sales channel'] unless attributes['sales channel'].nil?

    # Billing info attributes
    # Not implemented, always use company info

    # Credit card info attributes
    @partner.credit_card.first_name = attributes['cc first name'] unless attributes['cc first name'].nil?
    @partner.credit_card.last_name = attributes['cc last name'] unless attributes['cc last name'].nil?
    @partner.credit_card.number = attributes['cc number'] unless attributes['cc number'].nil?
    @partner.credit_card.expire_month = attributes['expire month'] unless attributes['expire month'].nil?
    @partner.credit_card.expire_year = attributes['expire year'] unless attributes['expire year'].nil?
    @partner.credit_card.cvv = attributes['cvv'] unless attributes['cvv'].nil?

    # Common attributes
    @partner.subscription_period = attributes['period']
    @partner.net_term_payment = (attributes['net terms'] || 'no').eql?('yes')

    @partner.company_info.name = "Internal Mozy - #{@partner.company_info.name}" if  ENV['BUS_ENV'] == 'prod'

    Log.debug(@partner.to_s)
    @bus_site.admin_console_page.add_new_partner_section.add_new_account(@partner)
  end


end


def compare_partner_creation_message(string)
  @bus_site.admin_console_page.add_new_partner_section.messages.should == string
end