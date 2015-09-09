Then /^I will see the user account page$/ do
  @bus_site.user_account_page.computer_message.should == 'Computers'
end

Then /^I will see the Authentication Failed page$/ do
  @bus_site.authentication_failed_page.authentication_failed.should == 'Authentication Failed'
end

When /^I login the(| admin) subdomain (.+)$/ do |type, subdomain|
  subdomain.replace ERB.new(subdomain).result(binding)
  if type.include?('admin')
    @bus_site.admin_login_page(subdomain, 'ldap').load
  else
    @bus_site.user_login_page(subdomain, 'ldap').load
  end
  @bus_site.adfs_login_page.log_in(subdomain)
end

And /^I sign in with user name (.+) and password (.+)$/ do |username, password |
  username.replace ERB.new(username).result(binding)
  password.replace ERB.new(password).result(binding)
  password = '' if password == 'AD user default password'
  @bus_site.adfs_login_page.sign_in(username, password)
end

When /^I navigate to the admin subdomain (.+)$/ do |subdomain|
  subdomain.replace ERB.new(subdomain).result(binding)
  @bus_site.admin_login_page(subdomain, 'ldap').load
end

