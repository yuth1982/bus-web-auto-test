When /^I log in zimbra as (.+)$/ do |zimbra_admin|
  launch_selenium_web_driver Zimbra::ZIMBRA_LOGIN_URL
  @zimbra_login_page = Zimbra::LoginPage.new driver
  @zimbra_login_page.login(zimbra_admin)
  @mail_main_page = Zimbra::MailMainPage.new driver
end