Given /^I log in bus admin console as (.+)$/ do |admin|
  launch_selenium_web_driver(Bus::BUS_LOGIN_URL)
  @bus_login_page = Bus::LoginPage.new(driver)
  @bus_login_page.login(admin)
  @bus_admin_console_page = Bus::AdminConsolePage.new(driver)
end