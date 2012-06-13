Given /^I log in aria admin console as (.+)$/ do |admin|
  launch_selenium_web_driver Aria::ARIA_LOGIN_URL
  @aria_login_page = Aria::LoginPage.new driver
  @aria_login_page.login admin
  @aria_admin_console_page = Aria::AdminConsolePage.new driver
end