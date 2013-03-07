Then /^I will see the user account page$/ do
  @bus_site.user_account_page.computer_message.should == 'Computers'
end

Then /^I will see the Authentication Failed page$/ do
  @bus_site.authentication_failed_page.authentication_failed.should == 'Authentication Failed'
end

When /^I login the subdomain (\w+)$/ do |subdomain|
  @bus_site.user_login_page(subdomain, 'ldap').load
  @bus_site.adfs_login_page.log_in
end