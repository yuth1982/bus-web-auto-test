# Create MozyPro Partner Steps

When /^I add a MozyPro partner with (\d+) month\(s\) period, (.+) plan, (has|no) server plan, (no|.+) coupon, (credit card|net terms) payment$/ do |period, supp_plan, has_server_plan, coupon, payment|
  step "I navigate to add new partner view"
  @partner = Bus::MozyPro.new
  @partner.subscription_period = period
  @partner.supp_plan = supp_plan
  @partner.has_server_plan = has_server_plan.eql?("has")
  @partner.partner_info.coupon_code = coupon unless coupon.eql?("no")
  @partner.net_term_payment = payment.eql?("net terms")
  puts @partner.to_s
  @bus_admin_console_page.add_new_partner_view.add_new_account(@partner)
end

When /^I add a MozyPro partner with (\d+) month\(s\) period, (.+) plan, (has|no) server plan, (no|.+) coupon, (.+) country, (.+) VAT number, (credit card|net terms) payment$/ do |period, supp_plan, has_server_plan, coupon, country, vat_number, payment|
  step "I navigate to add new partner view"
  @partner = Bus::MozyPro.new
  @partner.subscription_period = period
  @partner.supp_plan = supp_plan
  @partner.has_server_plan = has_server_plan.eql?("has")
  @partner.partner_info.coupon_code = coupon unless coupon.eql?("no")
  @partner.company_info.country = country
  @partner.company_info.vat_num = vat_number unless vat_number.eql?("no")
  @partner.net_term_payment = payment.eql?("net terms")
  puts @partner.to_s
  @bus_admin_console_page.add_new_partner_view.add_new_account(@partner)
end

When /^I add a MozyPro partner with (\d+) month\(s\) period, no initial purchase$/ do |period|
  step "I navigate to add new partner view"
  @partner = Bus::MozyPro.new
  @partner.subscription_period = period
  @partner.has_initial_purchase = false
  puts @partner.to_s
  @bus_admin_console_page.add_new_partner_view.add_new_account(@partner)
end

# Create MozyEnterprise Partner Steps

When /^I add a MozyEnterprise partner with (\d+) month\(s\) period, (\d+) user\(s\), (no|.+) server plan, (no|.+) server add-on, (no|.+) coupon, (credit card|net terms) payment$/ do |period, num_users, supp_plan, num_add_on, coupon, payment|
  step "I navigate to add new partner view"
  @partner = Bus::MozyEnterprise.new
  @partner.subscription_period = period
  @partner.num_enterprise_users = num_users
  @partner.supp_plan = supp_plan unless supp_plan.eql?("no")
  @partner.num_server_add_on = num_add_on
  @partner.partner_info.coupon_code = coupon unless coupon.eql?("no")
  @partner.net_term_payment = payment.eql?("net terms")
  puts @partner.to_s
  @bus_admin_console_page.add_new_partner_view.add_new_account(@partner)
end

When /^I add a MozyEnterprise partner with (\d+) month\(s\) period, (\d+) user\(s\), (no|.+) server plan, (\d+) server add-on, (no|.+) coupon, (.+) country, (.+) VAT number, (credit card|net terms) payment$/ do |period, num_users, supp_plan, num_add_on, coupon, country, vat_number, payment|
  step "I navigate to add new partner view"
  @partner = Bus::MozyEnterprise.new
  @partner.num_enterprise_users = num_users
  @partner.subscription_period = period
  @partner.supp_plan = supp_plan unless supp_plan.eql?("no")
  @partner.num_server_add_on = num_add_on
  @partner.company_info.country = country
  @partner.company_info.vat_num = vat_number unless vat_number.eql?("no")
  @partner.partner_info.coupon_code = coupon unless coupon.eql?("no")
  @partner.net_term_payment = payment.eql?("net terms")
  puts @partner.to_s
  @bus_admin_console_page.add_new_partner_view.add_new_account(@partner)
end

When /^I add a MozyEnterprise partner with (\d+) month\(s\) period, no initial purchase$/ do |period|
  step "I navigate to add new partner view"
  @partner = Bus::MozyEnterprise.new
  @partner.subscription_period = period
  @partner.has_initial_purchase = false
  puts @partner.to_s
  @bus_admin_console_page.add_new_partner_view.add_new_account(@partner)
end

# Create Reseller Partner Steps

When /^I add a Reseller partner with (\d+) month\(s\) period, (\w+ Reseller), (\d+) GB plan, (has|no) server plan, (\d+) add-on, (no|.+) coupon, (credit card|net terms) payment$/ do |period, reseller_type, reseller_quota, has_server_plan, add_on_quota, coupon, payment|
  step "I navigate to add new partner view"
  @partner = Bus::Reseller.new
  @partner.subscription_period = period
  @partner.reseller_type = reseller_type
  @partner.reseller_quota = reseller_quota
  @partner.has_server_plan = has_server_plan.eql?("has")
  @partner.reseller_add_on_quota = add_on_quota
  @partner.partner_info.coupon_code = coupon unless coupon.eql?("no")
  @partner.net_term_payment = payment.eql?("net terms")
  puts @partner.to_s
  @bus_admin_console_page.add_new_partner_view.add_new_account(@partner)
end

When /^I add a Reseller partner with (\d+) month\(s\) period, (\w+ Reseller), (\d+) GB plan, (has|no) server plan, (\d+) add-on, (no|.+) coupon, (.+) country, (.+) VAT number, (credit card|net terms) payment$/ do |period, reseller_type, reseller_quota, has_server_plan, add_on_quota, coupon, country, vat_number,payment|
  step "I navigate to add new partner view"
  @partner = Bus::Reseller.new
  @partner.subscription_period = period
  @partner.reseller_type = reseller_type
  @partner.reseller_quota = reseller_quota
  @partner.has_server_plan = has_server_plan.eql?("has")
  @partner.reseller_add_on_quota = add_on_quota
  @partner.company_info.country = country
  @partner.company_info.vat_num = vat_number unless vat_number.eql?("no")
  @partner.partner_info.coupon_code = coupon unless coupon.eql?("no")
  @partner.net_term_payment = payment.eql?("net terms")
  puts @partner.to_s
  @bus_admin_console_page.add_new_partner_view.add_new_account(@partner)
end

When /^I add a Reseller partner with (\d+) month\(s\) period, no initial purchase$/ do |period|
  step "I navigate to add new partner view"
  @partner = Bus::Reseller.new
  @partner.subscription_period = period
  @partner.has_initial_purchase = false
  puts @partner.to_s
  @bus_admin_console_page.add_new_partner_view.add_new_account(@partner)
end

# Other Steps

Then /^Partner created successful message should be (.+)$/ do |message|
  sleep 20 # wait for create the new partner
  @bus_admin_console_page.add_new_partner_view.message_div.text.should == message
  step "I activate new partner admin with default password"
end

Then /^Order summary table should be:$/ do |order_summary_table|
  @bus_admin_console_page.add_new_partner_view.order_summary_table.body_rows_text.should == order_summary_table.rows
end