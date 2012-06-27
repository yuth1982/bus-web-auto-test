
When /^I add a MozyPro partner with (\d+) month\(s\) period, (.+) plan, (has|no) server plan$/ do |period, supp_plan, has_server_plan|
  step "I navigate to add new partner view"
  @partner = Bus::Partner.new
  @partner.company_type = Bus::COMPANY_TYPE[:mozypro]
  @partner.subscription_period = period
  @partner.supp_plan = supp_plan
  @partner.has_server_plan = has_server_plan.eql?("has")
  @bus_admin_console_page.add_new_partner_view.add_new_account(@partner)
end

When /^I add a MozyPro partner with (\d+) month\(s\) period, (.+) plan, (has|no) server plan, (.+) country, (.+) VAT number$/ do |period, supp_plan, has_server_plan, country, number|
  step "I navigate to add new partner view"
  @partner = Bus::Partner.new
  @partner.company_type = Bus::COMPANY_TYPE[:mozypro]
  @partner.subscription_period = period
  @partner.supp_plan = supp_plan
  @partner.has_server_plan = has_server_plan.eql?("has")
  @partner.country = country
  @partner.vat_num = number
  @bus_admin_console_page.add_new_partner_view.add_new_account(@partner)
end

When /^I add a MozyPro partner with (\d+) month\(s\) period, (.+) plan, (has|no) server plan, net terms payment$/ do |period, supp_plan, has_server_plan|
  step "I navigate to add new partner view"
  @partner = Bus::Partner.new
  @partner.company_type = Bus::COMPANY_TYPE[:mozypro]
  @partner.subscription_period = period
  @partner.supp_plan = supp_plan
  @partner.has_server_plan = has_server_plan.eql?("has")
  @partner.net_term_payment = true
  @bus_admin_console_page.add_new_partner_view.add_new_account(@partner)
end


When /^I add a MozyEnterprise partner with (\d+) month\(s\) period, (\d+) user\(s\), (.+) add-on plan$/ do |period, num_users, supp_plan|
  step "I navigate to add new partner view"
  @partner = Bus::Partner.new
  @partner.company_type = Bus::COMPANY_TYPE[:mozyenterprise]
  @partner.num_enterprise_users = num_users
  @partner.subscription_period = period
  @partner.supp_plan = supp_plan
  @bus_admin_console_page.add_new_partner_view.add_new_account(@partner)
end

When /^I add a MozyEnterprise partner with (\d+) month\(s\) period, no initial purchase$/ do |period|
  step "I navigate to add new partner view"
  @partner = Bus::Partner.new
  @partner.company_type = Bus::COMPANY_TYPE[:mozyenterprise]
  @partner.subscription_period = period
  @partner.has_initial_purchase = false
  @bus_admin_console_page.add_new_partner_view.add_new_account(@partner)
end

When /^I add a Reseller partner with (\d+) month\(s\) period, (\w+ Reseller), (\d+) GB plan, (has|no) server plan, (\d+) add-on$/ do |period, reseller_type, reseller_quota, has_server_plan, add_on_quota|
  step "I navigate to add new partner view"
  @partner = Bus::Partner.new
  @partner.company_type = Bus::COMPANY_TYPE[:reseller]
  @partner.subscription_period = period
  @partner.reseller_type = reseller_type
  @partner.reseller_quota = reseller_quota
  @partner.has_server_plan = has_server_plan.eql?("has")
  @partner.reseller_add_on_quota = add_on_quota
  @bus_admin_console_page.add_new_partner_view.add_new_account(@partner)
end


Then /^Partner creation successful message should be (.+)$/ do |message|
  @bus_admin_console_page.add_new_partner_view.creation_status_msg.should start_with(message)
  #@bus_admin_console_page.add_new_partner_view.refresh_page
  puts @partner.to_s
end


When /^I view the new partner order summary$/ do
  @bus_admin_console_page.add_new_partner_view.order_summary_tb
end

Then /^I should see taxes total price of initial order is (.+)$/ do |price|
  @bus_admin_console_page.add_new_partner_view.tax_total_span.text.should == price
end