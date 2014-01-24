Given /^I log in (bus admin console|to legacy bus01) as administrator$/ do | environment |
  @bus_site = BusSite.new
  case environment
    when "bus admin console"
      @bus_site.login_page.load
      @bus_site.login_page.choose_english
      @admin_username = QA_ENV['bus_username']
      @admin_password = QA_ENV['bus_password']
      @bus_site.login_page.login(@admin_username, @admin_password)
    when "to legacy bus01"
      @bus_site.itemized_login.load
      @admin_username = QA_ENV['bus01_admin']
      @admin_password = QA_ENV['bus01_pass']
      @bus_site.itemized_login.login(@admin_username, @admin_password)
  end
  # there was redundant code here - removed.
end

When /^I navigate to bus admin console login page$/ do
  @bus_site = BusSite.new
  @bus_site.login_page.load
end

When /^I log in bus admin console with user name (.+) and password (.+)$/ do |username, password|
  @bus_site.login_page.login(username, password)
end

When /^I log out bus admin console$/ do
  @bus_site.login_page.logout
end

Then /^Login page error message should be (.+)$/ do |messages|
  @bus_site.login_page.messages.should == messages
end

When /^I save login page cookies (.+) value$/ do |name|
  cookie = @bus_site.login_page.cookies.select{ |cookie| cookie[:name] == name }.first
  @login_page_cookie_value = cookie[:value]
  puts "login page #{name}: #@login_page_cookie_value"
end

And /^I log in bus admin console as new partner admin$/ do
  @bus_site.login_page.load
  @bus_site.login_page.login(@partner.admin_info.email, CONFIGS['global']['test_pwd'])
end

Then /^the new partner admin should be asked to verify their email address$/ do
  @bus_site.verify_email_page.current_url.should == "#{QA_ENV['bus_host']}/login/email_needs_verification"
  @bus_site.verify_email_page.links_present.should be_true
end