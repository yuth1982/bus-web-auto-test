# Public: Create a new partner
#
# MozyPro available columns:
#   Required: period
#   Optional: base plan, server plan, storage add on, coupon, country, vat number, net terms
#
# MozyEnterprise available columns:
#   Required: period
#   Optional: users, server plan, server add on, coupon, country, vat number, net terms
#
# Reseller available columns:
#   Required: period
#   Optional: reseller type, reseller quota, server plan, storage add on, coupon,  country,  vat number, net terms
#
# Shared available columns:
# Optional: address, city, state, state abbrev, zip, country, phone, admin email, admin name, root role
#
# Steps included:
#   click 'Add New Partner' link
#   fill in all fields
#   click next
#   fill in credit card information
#   click create

When /^I add a new (MozyPro|MozyEnterprise|Reseller) partner:$/ do |type, partner_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['add_new_partner'])
  attributes = partner_table.hashes.first
  case type
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
    else
      raise "Error: Company type #{type} does not exist."
  end

  # Company info attributes
  @partner.company_info.name = attributes['company name'] unless attributes['company name'].nil?
  @partner.company_info.address = attributes['address'] unless attributes['address'].nil?
  @partner.company_info.city = attributes['city'] unless attributes['city'].nil?
  @partner.company_info.state = attributes['state'] unless attributes['state'].nil?
  @partner.company_info.state_abbrev = attributes['state abbrev'] unless attributes['state abbrev'].nil?
  @partner.company_info.country = attributes["country"] unless attributes['country'].nil?
  @partner.company_info.zip = attributes['zip'] unless attributes['zip'].nil?
  @partner.company_info.phone = attributes['phone'] unless attributes['phone'].nil?
  @partner.company_info.vat_num = attributes["vat number"] unless attributes["vat number"].nil?

  # Partner info attributes
  @partner.partner_info.coupon_code = attributes["coupon"] unless attributes["coupon"].nil?
  @partner.partner_info.parent = attributes["create under"] || CONFIGS['bus']['mozy_root_partner']['mozypro']

  # Admin info attributes
  @partner.admin_info.full_name = attributes["admin name"] unless attributes["admin name"].nil?
  @partner.admin_info.email = attributes["admin email"] unless attributes["admin email"].nil?

  # Account Detail info attributes
  @partner.account_detail.account_type = attributes["account type"]
  @partner.account_detail.sales_origin = attributes["sales origin"]
  @partner.account_detail.sales_channel = attributes["sales channel"]

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
  @partner.net_term_payment = (attributes["net terms"] || "no").eql?("yes")

  Log.debug(@partner.to_s)
  @bus_site.admin_console_page.add_new_partner_section.add_new_account(@partner)
end

When /^I add a new (MozyPro|MozyEnterprise|Reseller) partner if not exist:$/ do |type, partner_table|
  attributes = partner_table.hashes.first
  company_name =  attributes['company name']
  email = attributes['email']
  search_result = Proc.new do |company_name, email|
    search = email
    compare = company_name
    if company_name && !email
      search = company_name
    end
    @bus_site.admin_console_page.search_list_partner_section.search_partner search
    @bus_site.admin_console_page.search_list_partner_section.search_results_table_rows.first[1] == compare
  end
  unless company_name && search_result.call(company_name, email)
    step %{I add a new #{type} partner:}, table(%{
      |#{partner_table.headers.join('|')}|
      |#{partner_table.rows.first.join('|')}|
    })
    @bus_site.admin_console_page.add_new_partner_section.messages.should == 'New partner created.'
  end
end

Then /^New partner should be created$/ do
  @bus_site.admin_console_page.add_new_partner_section.messages.should == "New partner created."
end

Then /^Sub-total before taxes or discounts should be (.+)$/ do |amount|
  @partner.pre_sub_total.should == amount
end

Then /^Order summary table should be:$/ do |order_summary_table|
  actual = @bus_site.admin_console_page.add_new_partner_section.order_summary_hashes
  expected = order_summary_table.hashes
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

Then /^(MozyPro|MozyEnterprise|Reseller) partner subscription period options should be:$/ do |type, periods_table|
  @bus_site.admin_console_page.add_new_partner_section.available_periods(type).should == periods_table.headers
end

When /^I add a new sub partner:$/ do |sub_partner_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['add_new_partner'])
  @user = Bus::DataObj::User.new
  attributes = sub_partner_table.hashes.first
  partner_name = attributes["name"]
  @user.name = attributes["admin name"] unless attributes["admin name"].nil?
  @user.email = attributes["admin email"] unless attributes["admin email"].nil?
  @bus_site.admin_console_page.add_new_partner_section.add_new_sub_partner(partner_name, @user.name, @user.email)
end
Then /^the default billing country is (.+) in add new partner section$/ do |country|
  @bus_site.admin_console_page.add_new_partner_section.billing_country.should == country
end