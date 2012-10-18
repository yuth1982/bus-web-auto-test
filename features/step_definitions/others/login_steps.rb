Given /^I log in bus admin console as (.+)$/ do |admin|
  @start_time = Time.now
  @bus_site = BusSite.new
  @bus_site.login_page.load
  @bus_site.login_page.login(admin)
end

When /^I log out bus admin console$/ do
  @bus_site.login_page.logout
end