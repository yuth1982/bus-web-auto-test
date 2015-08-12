def login(environment)
  success = true
  begin
    @bus_site = BusSite.new
    case environment
      when 'bus admin console'
        @bus_site.login_page.load
        @bus_site.login_page.choose_english
        @admin_username = QA_ENV['bus_username']
        @admin_password = QA_ENV['bus_password']
        @bus_site.login_page.login(@admin_username, @admin_password)
      when 'to legacy bus01'
        @bus_site.itemized_login.load
        @admin_username = QA_ENV['bus01_admin']
        @admin_password = QA_ENV['bus01_pass']
        @bus_site.itemized_login.login(@admin_username, @admin_password)
    end
  rescue Exception => ex
    Log.debug(ex.to_s)
    success = false
  end
  success
end

#Give the login steps more chances to retry since it is a key path to all following steps
Given /^I log in (bus admin console|to legacy bus01) as administrator$/ do |environment|
  i = 0
  while !login(environment) && i < 3
    sleep 60
    i += 1
  end
end

And /^I login as (.+) admin successfully$/ do |admin|
  admin = @partner.company_info.name  if admin == 'mozypro'
  @bus_site.admin_console_page.get_partner_name_topcorner.should eq(admin)
end

When /^I navigate to bus admin console login page$/ do
  @bus_site = BusSite.new
  @bus_site.login_page.load
end

When /^I navigate to (.+) user login page$/ do |subdomain|
  @bus_site = BusSite.new
  @bus_site.user_login_page(subdomain, 'mozy').load
end

When /^I log in bus admin console with user name (.+) and password (.+)$/ do |username, password|
  username.replace ERB.new(username).result(binding)
  password.replace ERB.new(password).result(binding)
  @bus_site.login_page.login(username, password)
end

When /^I log out bus admin console$/ do
  @bus_site.login_page.logout
end

When /^I log out user$/ do
  @bus_site.user_login_page(type = 'mozy').logout
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

When /^I log into bus admin console with uppercase (.+) and (.+)$/ do |username, password|
  username = username.upcase
  step %{I log in bus admin console with user name #{username} and password #{password}}
end

When /^I log into bus admin console with mixed case (.+) and (.+)$/ do |username, password|
  until username.match(/[A-Z]/) do
    username = username.gsub /[a-z]/i do |x| rand(2)==0 ? x.downcase : x.upcase end
  end
  step %{I log in bus admin console with user name #{username} and password #{password}}
end

When /^I log into (.+) with uppercase username (.+) and (.+)$/ do |subdomain, username, password|
  username = username.upcase
  user_account = {:user_name => username, :password => password}
  @bus_site.user_login_page(subdomain, 'mozy').login(user_account)
end

When /^I log into (.+) with mixed case username (.+) and (.+)$/ do |subdomain, username, password|
  until username.match(/[A-Z]/) do
    username = username.gsub /[a-z]/i do |x| rand(2)==0 ? x.downcase : x.upcase end
  end
  user_account = {:user_name => username, :password => password}
  @bus_site.user_login_page(subdomain, 'mozy').login(user_account)
end
