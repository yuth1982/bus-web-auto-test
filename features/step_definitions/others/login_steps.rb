Given /^I log in bus admin console as (.+)$/ do |admin|
  @bus_site = BusSite.new
  @bus_site.login_page.load
  @bus_site.login_page.login(admin)
end