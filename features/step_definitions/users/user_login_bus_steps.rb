And /^I access freyja from bus admin$/ do
  @bus_site.user_login_bus_page.access_freyja_user_login_bus
end

And /^I change password from (.+) to (.+) in user login bus page$/ do |pwd, new_pwd|
  @bus_site.user_login_bus_page.change_password_user_login_bus(pwd, new_pwd)
end

Then /^Change password should be successfully$/ do
  @bus_site.user_login_bus_page.change_password_message.should include ('has been changed')
end

Then /^the user log out bus$/ do
  @bus_site.user_login_bus_page.user_log_out_bus
end