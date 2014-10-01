#
# This will add a phoenix account, either home or pro.
#
#
# encoding: utf-8


When /^I (.+) a phoenix (Home|Pro|Direct|Free) (partner|user):$/ do |_,type,_,partner_table|
  # There were two Home signups, (When I add ...)(When I sign up...) The string combines them
  #(partner | user) is keep all tests cases working from when Home and Pro where separate
  attributes = partner_table.hashes.first

  attributes.each do |header,attribute| #can use variable inside <%= %>
    attribute.replace ERB.new(attribute).result(binding)
    attributes[header] = nil if attribute == ''
  end

  phoenix_create_partner_or_user(type,attributes)

end

#AMMENDED: For some reason this works intermittently.  Original is unchange, commented out '# unless portion'.
Then /^the (order|billing) summary looks like:$/ do |type, billing_table|
  actual = @partner.order_summary
  expected = billing_table.hashes
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

## Changed to more useful or the different account types
And /^the (partner|user) is successfully added(.|)$/ do  |_,_|
  phoenix_create_partner_or_user_success?
end

Then /^the default country is (.+) in the pro billing page$/ do |country|
  @phoenix_site.billing_fill_out.pro_billing_country.should == country
end

And /^they have logged in and verified their account.$/ do
  @phoenix_site.reg_complete_pg.clear_phoenix_cookies
  @bus_site = BusSite.new unless !@bus_site.nil?
  @bus_site.login_page.load
  @bus_site.login_page.partner_login(@partner)
  @bus_site.admin_console_page.open_partner_details_from_header(@partner)
  @bus_site.admin_console_page.partner_details_section.partner_info_verify(@partner)
  #TODO: localized logic is tied to phoenix even if this is verified in BUS(@phoenix_site is misleading)
  @phoenix_site.reg_complete_pg.logout(@partner)
end

Then /^the default country is (.+) in the home billing page$/ do |country|
  Log.debug @phoenix_site.billing_fill_out.home_billing_country
  @phoenix_site.billing_fill_out.home_billing_country.should == country
end

# changed to add in locale and different verbage for home
When /^verify email address link should show success message$/ do
  @phoenix_site.verify_email_address.visit(@verify_email_query)
  if @partner.base_plan.eql?("free")
    @phoenix_site.reg_complete_pg.free_home_verified(@partner)
    # free users are taken to acct created screen, not mail verification page
  else
    @phoenix_site.verify_email_address.form_title_txt.should == "#{LANG[@partner.company_info.country][@partner.partner_info.type]['verify_mail_banner']}"
    @phoenix_site.verify_email_address.form_message_txt.should == " #{LANG[@partner.company_info.country][@partner.partner_info.type]['verify_mail_success']}"
  end
end

Then /^sign up page error message should be:$/ do |message|
  @phoenix_site.phoenix_acct_fill_out.rp_error_messages.should eq(message)
end

Then /^sign up page error message to (.+) should be displayed$/ do |username|
  @phoenix_site.phoenix_acct_fill_out.rp_error_messages.should eq(" An account with email address \"#{username}\" already exists")
end

# this piece may be combinable with the bus admin login step
When /^I login (as the user|under changed password) on the account.$/ do |login_condition|
  @phoenix_site = PhoenixSite.new
  @phoenix_site.user_account.load
  case login_condition
    when "as the user"
      @phoenix_site.user_account.user_login(@partner)
    when "under changed password"
      @phoenix_site.user_account.user_login_changed_pw(@partner)
      step %{I verify the user account:}
  end
end

When /^I log into phoenix with username (.+) and password (.+)$/ do |username,password|
  @bus_site = BusSite.new #In case you log into bus through the phoenix page
  @phoenix_site = PhoenixSite.new
  @phoenix_site.user_account.load
  @phoenix_site.user_account.phoenix_login(username,password)
end

Given /^I log into phoenix with capitalized username$/ do
  username = QA_ENV['bus_username'].upcase
  password = QA_ENV['bus_password']
  step %{I log into phoenix with username #{username} and password #{password}}
end

Given /^I log into phoenix with mixed case username$/ do
  username = QA_ENV['bus_username']
  until username.match(/[A-Z]/) do
    username = username.gsub /[a-z]/i do |x| rand(2)>0 ? x.downcase : x.upcase end
  end
  password = QA_ENV['bus_password']
  step %{I log into phoenix with username #{username} and password #{password}}
end

# this piece may be combinable with the verification of account step
When /^I verify the user account.$/ do
  @phoenix_site.user_account.login_verify(@partner)
end

# this relates to admin console account details
When /^(.+) account information should be:$/ do  |home_user_table|
  # table is a Cucumber::Ast::Table
  account_data = home_user_table.hashes.first

  @phoenix_site.user_account.account_detail_section.load_acct_home_section(@partner)
  @phoenix_site.user_account.account_detail_section.plan_details_headers.should == account_data.headers
  @phoenix_site.user_account.account_detail_section.plan_details_rows.should == account_data.rows
end

# added "( |partner)" for future flexibility
Then /^the (user|partner) has activated their account$/ do |_|
  if @partner.base_plan.eql?("free")
    step %{I retrieve email content by keywords:}, table(%{
      | to | subject |
      | @new_admin_email | #{LANG[@partner.company_info.country][@partner.partner_info.type]["free_mail_subject"]} |
      })
  else
    step %{I retrieve email content by keywords:}, table(%{
      | to | subject |
      | @new_admin_email | #{LANG[@partner.company_info.country][@partner.partner_info.type]["verify_mail_subject"]} |
      })
  end
  step %{I get verify email address from email content}
  step %{verify email address link should show success message}
end
