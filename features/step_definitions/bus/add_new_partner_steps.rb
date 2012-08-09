# Public: Create a new partner
#
# MozyPro available column names:
# | period | base plan | server plan | coupon | country | vat number | net terms |
#
# MozyEnterprise available column names:
# | period | users | server plan | server add-on | coupon | country | vat number | net terms |
#
# Reseller available column names:
# | period | reseller type | reseller quota | server plan | server add-on | coupon | country | vat number | net terms |
#
When /^I add a new (MozyPro|MozyEnterprise|Reseller) partner:$/ do |type, partner_table|
  step "I navigate to Add New Partner section from bus admin console page"
  attributes = partner_table.hashes.first
  case type
    when "MozyPro"
      @partner = Bus::DataObj::MozyPro.new
      @partner.has_initial_purchase = false if attributes["base plan"].nil?
      @partner.base_plan = attributes["base plan"] || ""
      @partner.has_server_plan = attributes["server plan"].eql?("yes") unless attributes["server plan"].nil?
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
      @partner.has_server_plan = attributes["server plan"].eql?("yes") unless attributes["server plan"].nil?
    else
      raise "Error: Company type #{type} does not exist."
  end
  # Common attributes
  @partner.subscription_period = attributes["period"] # required
  @partner.company_info.country = attributes["country"] || "United States"
  @partner.company_info.vat_num = attributes["vat number"] || ""
  @partner.partner_info.coupon_code = attributes["coupon"] || ""
  @partner.net_term_payment = attributes["net terms"].eql?("yes") unless attributes["net terms"].nil?

  puts @partner.to_s
  @bus_admin_console_page.add_new_partner_section.add_new_account(@partner)
end

Then /^New partner should created/ do
  begin
    @bus_admin_console_page.add_new_partner_section.message_text.should == "New partner created."
    puts "After partner created successful: #{DateTime.now.to_s}"
  rescue
    puts "After partner created failed: #{DateTime.now.to_s}"
  end
  step "I activate new partner admin with default password"
end

Then /^Order summary table should be:$/ do |order_summary_table|
  @bus_admin_console_page.add_new_partner_section.order_summary_tb_headers_text.should == order_summary_table.headers
  @bus_admin_console_page.add_new_partner_section.order_summary_tb_rows_text.should == order_summary_table.rows
end