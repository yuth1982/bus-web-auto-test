# Public: Create a new partner
#
# MozyPro available columns:
#   Required: period
#   Optional: base plan, server plan, coupon, country, vat number, net terms
#
# MozyEnterprise available columns:
#   Required: period
#   Optional: users, server plan, server add-on, coupon, country, vat number, net terms
#
# Reseller available columns:
#   Required: period
#   Optional: reseller type, reseller quota, server plan, server add-on, coupon,  country,  vat number, net terms
#
When /^I add a new (MozyPro|MozyEnterprise|Reseller) partner:$/ do |type, partner_table|
  step "I navigate to Add New Partner section from bus admin console page"
  attributes = partner_table.hashes.first
  case type
    when "MozyPro"
      @partner = Bus::DataObj::MozyPro.new
      @partner.has_initial_purchase = false if attributes["base plan"].nil?
      @partner.base_plan = attributes["base plan"] || ""
      @partner.has_server_plan = (attributes["server plan"] || "no").eql?("yes")
    when "MozyEnterprise"
      @partner = Bus::DataObj::MozyEnterprise.new
      @partner.has_initial_purchase = false if attributes["users"].nil?
      @partner.num_enterprise_users = attributes["users"] || 0
      @partner.server_plan = attributes["server plan"] || "None"
      @partner.num_server_add_on = attributes["server add-on"] || 0
    when "Reseller"
      @partner = Bus::DataObj::Reseller.new
      @partner.has_initial_purchase = false if attributes["reseller type"].nil?
      @partner.reseller_type = attributes["reseller type"] || "Silver"
      @partner.reseller_quota = attributes["reseller quota"] || 0
      @partner.reseller_add_on_quota = attributes["server add-on"] || 0
      @partner.has_server_plan = (attributes["server plan"] || "no").eql?("yes")
    else
      raise "Error: Company type #{type} does not exist."
  end
  # Common attributes
  @partner.subscription_period = attributes["period"] # required
  @partner.company_info.country = attributes["country"] || "United States"
  @partner.company_info.vat_num = attributes["vat number"] || ""
  @partner.partner_info.coupon_code = attributes["coupon"] || ""
  @partner.net_term_payment = (attributes["net terms"] || "no").eql?("yes")

  puts @partner.to_s
  @bus_admin_console_page.add_new_partner_section.add_new_account(@partner)
end

Then /^New partner should be created/ do
  @bus_admin_console_page.add_new_partner_section.messages.should == "New partner created."
  @partner_created = true
end

Then /^Order summary table should be:$/ do |order_summary_table|
  @bus_admin_console_page.add_new_partner_section.order_summary_table_headers.should == order_summary_table.headers
  @bus_admin_console_page.add_new_partner_section.order_summary_table_rows.should == order_summary_table.rows
end

Then /^(MozyPro|MozyEnterprise|Reseller) partner subscription period options should be:$/ do |type, periods_table|
  @bus_admin_console_page.add_new_partner_section.available_periods(type).should == periods_table.headers
end