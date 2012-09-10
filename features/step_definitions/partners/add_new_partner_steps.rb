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
# Steps included:
#   click 'Add New Partner' link
#   fill in all fields
#   click next
#   fill in credit card information
#   click create

When /^I add a new (MozyPro|MozyEnterprise|Reseller) partner:$/ do |type, partner_table|
  @bus_site.admin_console_page.click_link(Bus::MENU[:add_new_partner])
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
  @partner.company_info.name = attributes['company_name'] || ''
  @partner.subscription_period = attributes["period"] # required
  @partner.company_info.country = attributes["country"] || "United States"
  @partner.company_info.vat_num = attributes["vat number"] || ""
  @partner.partner_info.coupon_code = attributes["coupon"] || ""
  @partner.net_term_payment = (attributes["net terms"] || "no").eql?("yes")

  puts @partner.to_s
  @bus_site.admin_console_page.add_new_partner_section.add_new_account(@partner)
end

When /^I add a new (MozyPro|MozyEnterprise|Reseller) partner if not exist:$/ do |type, partner_table|
  attributes = partner_table.hashes.first
  company_name =  attributes['company_name']
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

Then /^Order summary table should be:$/ do |order_summary_table|
  @bus_site.admin_console_page.add_new_partner_section.order_summary_table_headers.should == order_summary_table.headers
  @bus_site.admin_console_page.add_new_partner_section.order_summary_table_rows.should == order_summary_table.rows
end

Then /^(MozyPro|MozyEnterprise|Reseller) partner subscription period options should be:$/ do |type, periods_table|
  @bus_site.admin_console_page.add_new_partner_section.available_periods(type).should == periods_table.headers
end