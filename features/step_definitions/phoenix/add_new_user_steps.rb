# Public: Create a phoenix account
#
# MozyPro available columns:
#   Required: period
#   Optional: base plan, server plan, coupon, country, vat number, net terms
#
# MozyHome:
#   Required: period
#   Optional: base plan, coupon, country, add-computer, add-quota
#
# Shared available columns:
# Optional: address, city, state, state abbrev, zip, country, phone, admin email, admin name
#
# Steps included:
#   www.mozy.com
#   click 'Sign Up' link
#   select country
#   fill in admin info
#   fill in partner info (pro account)
#   fill in licensing info
#   fill in billing info
#   click create
When /^I add a phoenix Home user:$/ do |user_table|
  # table is a Cucumber::Ast::Table
  attributes = user_table.hashes.first
  @partner = Bus::DataObj::MozyPro.new
  @partner.partner_info.type = "MozyHome"
  @partner.base_plan = attributes["base plan"] || ""
  @partner.has_server_plan = (attributes["server plan"] || "no").eql?("yes")

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
  @partner.admin_info.email = attributes["admin email"] unless attributes["admin name"].nil?

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
    case
    when attributes["period"].eql?("1")
      @partner.subscription_period = "M"
    when attributes["period"].eql?("12")
      @partner.subscription_period = "Y"
    when attributes["period"].eql?("24")
      @partner.subscription_period = "2"
    end

  # for info review
  # puts @partner.to_s
  @phoenix_site.select_dom.select_country(@partner)
  @phoenix_site.admin_fill_out.admin_info_fill_out(@partner)
  @phoenix_site.licensing_fill_out.licensing_billing_fillout(@partner)
  @phoenix_site.billing_fill_out.billing_info_fill_out(@partner)
end

When /^I add a phoenix Home user to the billing page:$/ do |user_table|
  # table is a Cucumber::Ast::Table
  step %{I build a phoenix Home user:}, table(%{
      |#{user_table.headers.join('|')}|
      |#{user_table.rows.first.join('|')}|
    })
  # for info review
  # puts @partner.to_s
  @phoenix_site.select_dom.select_country(@partner)
  @phoenix_site.admin_fill_out.admin_info_fill_out(@partner)
  @phoenix_site.licensing_fill_out.licensing_billing_fillout(@partner)
end

When /^I build a phoenix Home user:$/ do |user_table|
  # table is a Cucumber::Ast::Table
  attributes = user_table.hashes.first
  @partner = Bus::DataObj::MozyPro.new
  @partner.partner_info.type = "MozyHome"
  @partner.base_plan = attributes["base plan"] || ""
  @partner.has_server_plan = (attributes["server plan"] || "no").eql?("yes")

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
  @partner.admin_info.email = attributes["admin email"] unless attributes["admin name"].nil?

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
  case
    when attributes["period"].eql?("1")
      @partner.subscription_period = "M"
    when attributes["period"].eql?("12")
      @partner.subscription_period = "Y"
    when attributes["period"].eql?("24")
      @partner.subscription_period = "2"
  end
end

Then /^the billing summary looks like:$/ do |billing_table|
	# table is a Cucumber::Ast::Table
	# pending - add step here
	attributes = billing_table.hashes.first
  @phoenix_site.billing_fill_out.billing_summary_table_headers.should == billing_table.headers
  @phoenix_site.billing_fill_out.billing_summary_table_rows.should == billing_table.rows
end

Then /^the user is successfully added.$/ do
  @phoenix_site.reg_complete_pg.home_success(@partner)
end
Then /^the user is successfully added$/ do
  @phoenix_site.reg_complete_pg.reg_comp_banner_present
end

Then /^the default country is (.+) in the home billing page$/ do |country|
  Log.debug @phoenix_site.billing_fill_out.home_billing_country
  @phoenix_site.billing_fill_out.home_billing_country.should == country
end
When /^I change credit card info to:$/ do |contact_table|
  # table is a | Name: | Street Address: | City: | State/Province: | Zip/Postal Code: | Country: |
  company_info = contact_table.hashes.first
  company_info.keys.each do |header|
    case header
      when 'Name:'
        @partner.company_info.name = company_info['Name:']
      when 'Street Address:'
        @partner.company_info.address = company_info['Street Address:']
      when 'City:'
        @partner.company_info.city = company_info['City:']
      when 'State/Province:'
        @partner.company_info.state_abbrev = company_info['State/Province:']
      when 'Zip/Postal Code:'
        @partner.company_info.zip = company_info['Zip/Postal Code:']
      when 'Country:'
        @partner.company_info.country = company_info['Country:']
      else
        raise "Unexpected #{header}"
    end
  end
  # for info review
  # puts @partner.to_s
  puts @partner
  @phoenix_site.licensing_fill_out.licensing_billing_fillout(@partner)
  @phoenix_site.billing_fill_out.billing_info_fill_out(@partner)
end