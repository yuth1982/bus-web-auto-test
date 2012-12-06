Given /^I log in bus admin console as administrator$/ do
  @bus_site = BusSite.new
  @bus_site.login_page.load
  @admin_username = BUS_ENV['bus_username']
  @admin_password = BUS_ENV['bus_password']
  @bus_site.login_page.login(@admin_username, @admin_password)
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

