When /^I log in zimbra as default account$/ do
  launch_selenium_web_driver Zimbra::ZIMBRA_LOGIN_URL
  @zimbra_login_page = Zimbra::LoginPage.new driver
  @zimbra_login_page.login_as_default_account
  @mail_main_page = Zimbra::MailMainPage.new driver
end