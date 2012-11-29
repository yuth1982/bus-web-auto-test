Given /^I log in bus admin console as administrator$/ do
  @bus_site = BusSite.new
  @bus_site.login_page.load
  @admin_username = BUS_ENV['bus_username']
  @admin_password = BUS_ENV['bus_password']
  @bus_site.login_page.login(@admin_username, @admin_password)
end

Given /^I log in bus admin console with user name (.+) and password (.+)$/ do |username, password|
  @bus_site = BusSite.new
  @bus_site.login_page.load
  @bus_site.login_page.login(username, password)
end

When /^I log out bus admin console$/ do
  @bus_site.login_page.logout
end