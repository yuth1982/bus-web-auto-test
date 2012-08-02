# Create MozyPro Partner Steps

When /^I add a MozyPro partner with (\d+) month\(s\) period, (.+) base plan, (has|no) server plan, (no|.+) coupon, (.+) country, (.+) VAT number, (credit card|net terms) payment$/ do |period, base_plan, has_server_plan, coupon, country, vat_number, payment|
  step "I navigate to Add New Partner view from bus admin console page"
  @partner = Bus::DataObj::MozyPro.new
  @partner.subscription_period = period
  if base_plan.eql?("no")
    @partner.has_initial_purchase = false
  else
    @partner.base_plan = base_plan
    @partner.has_server_plan = has_server_plan.eql?("has")
    @partner.partner_info.coupon_code = coupon unless coupon.eql?("no")
    @partner.company_info.country = country
    @partner.company_info.vat_num = vat_number unless vat_number.eql?("no")
    @partner.net_term_payment = payment.eql?("net terms")
  end
  puts @partner.to_s
  @bus_admin_console_page.add_new_partner_section.add_new_account(@partner)
end

When /^I add a MozyPro partner with (\d+) month\(s\) period, (.+) base plan, (has|no) server plan, (no|.+) coupon, (credit card|net terms) payment$/ do |period, base_plan, has_server_plan, coupon, payment|
  step "I add a MozyPro partner with #{period} month\(s\) period, #{base_plan} base plan, #{has_server_plan} server plan, #{coupon} coupon, United States country, no VAT number, #{payment} payment"
end

When /^I add a MozyPro partner with (\d+) month\(s\) period, no initial purchase$/ do |period|
  step "I add a MozyPro partner with #{period} month\(s\) period, no base plan, no server plan, no coupon, United States country, no VAT number, credit card payment"
end

# Create MozyEnterprise Partner Steps

When /^I add a MozyEnterprise partner with (\d+) month\(s\) period, (\d+) user\(s\), (no|.+) server plan, (\d+) server add-on, (no|.+) coupon, (.+) country, (.+) VAT number, (credit card|net terms) payment$/ do |period, num_users, server_plan, num_add_on, coupon, country, vat_number, payment|
  step "I navigate to Add New Partner view from bus admin console page"
  @partner = Bus::DataObj::MozyEnterprise.new
  @partner.subscription_period = period
  if num_users.to_i == 0 and server_plan.eql?("no") and num_add_on.to_i == 0
    @partner.has_initial_purchase = false
  else
    @partner.num_enterprise_users = num_users
    @partner.server_plan = server_plan unless server_plan.eql?("no")
    @partner.num_server_add_on = num_add_on
    @partner.company_info.country = country
    @partner.company_info.vat_num = vat_number unless vat_number.eql?("no")
    @partner.partner_info.coupon_code = coupon unless coupon.eql?("no")
    @partner.net_term_payment = payment.eql?("net terms")
  end
  puts @partner.to_s
  @bus_admin_console_page.add_new_partner_section.add_new_account(@partner)
end

When /^I add a MozyEnterprise partner with (\d+) month\(s\) period, (\d+) user\(s\), (no|.+) server plan, (no|.+) server add-on, (no|.+) coupon, (credit card|net terms) payment$/ do |period, num_users, server_plan, server_add_on, coupon, payment|
  step "I add a MozyEnterprise partner with #{period} month\(s\) period, #{num_users} user\(s\), #{server_plan} server plan, #{server_add_on} server add-on, #{coupon} coupon, United States country, no VAT number, #{payment} payment"
end

When /^I add a MozyEnterprise partner with (\d+) month\(s\) period, no initial purchase$/ do |period|
  step "I add a MozyEnterprise partner with #{period} month\(s\) period, 0 user\(s\), no server plan, 0 server add-on, no coupon, United States country, no VAT number, credit card payment"
end

# Create Reseller Partner Steps
When /^I add a Reseller partner with (\d+) month\(s\) period, (\w+ Reseller), (\d+) GB base plan, (has|no) server plan, (\d+) add-on, (no|.+) coupon, (.+) country, (.+) VAT number, (credit card|net terms) payment$/ do |period, reseller_type, reseller_quota, has_server_plan, add_on_quota, coupon, country, vat_number,payment|
  step "I navigate to Add New Partner view from bus admin console page"
  @partner = Bus::DataObj::Reseller.new
  @partner.subscription_period = period
  if reseller_quota.to_i == 0 and has_server_plan.eql?("no") and add_on_quota.to_i == 0
    @partner.has_initial_purchase = false
  else
    @partner.reseller_type = reseller_type
    @partner.reseller_quota = reseller_quota
    @partner.has_server_plan = has_server_plan.eql?("has")
    @partner.reseller_add_on_quota = add_on_quota
    @partner.company_info.country = country
    @partner.company_info.vat_num = vat_number unless vat_number.eql?("no")
    @partner.partner_info.coupon_code = coupon unless coupon.eql?("no")
    @partner.net_term_payment = payment.eql?("net terms")
  end
  puts @partner.to_s
  @bus_admin_console_page.add_new_partner_section.add_new_account(@partner)
end

When /^I add a Reseller partner with (\d+) month\(s\) period, (\w+ Reseller), (\d+) GB base plan, (has|no) server plan, (\d+) add-on, (no|.+) coupon, (credit card|net terms) payment$/ do |period, reseller_type, reseller_quota, has_server_plan, add_on_quota, coupon, payment|
  step "I add a Reseller partner with #{period} month\(s\) period, #{reseller_type}, #{reseller_quota} GB base plan, #{has_server_plan} server plan, #{add_on_quota} add-on, #{coupon} coupon, United States country, no VAT number, #{payment} payment"
end

When /^I add a Reseller partner with (\d+) month\(s\) period, no initial purchase$/ do |period|
  step "I add a Reseller partner with #{period} month\(s\) period, Silver Reseller, 0 GB base plan, no server plan, 0 add-on, no coupon, United States country, no VAT number, credit card payment"
end

# Other Steps

Then /^Partner created successful message should be (.+)$/ do |message|
  sleep 20 # wait for create the new partner
  @bus_admin_console_page.add_new_partner_section.message_text.should == message
  step "I activate new partner admin with default password"
end

Then /^Order summary table should be:$/ do |order_summary_table|
  @bus_admin_console_page.add_new_partner_section.order_summary_tb_rows_text.should == order_summary_table.rows
end