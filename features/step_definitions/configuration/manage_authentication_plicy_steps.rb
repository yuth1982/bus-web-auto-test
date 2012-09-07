When /^I use (Directory Service|Mozy) as authentication provider$/ do |provider|
  @bus_site.admin_console_page.authentication_policy_section.select_auth(provider)
end

When /^I select Horizon Manager with organization name (.+)$/ do |org_name|
  @bus_site.admin_console_page.authentication_policy_section.check_horizon(true)
  @bus_site.admin_console_page.authentication_policy_section.fillin_org_name(org_name)
end

When /^I click Test Connection button$/ do
  @bus_site.admin_console_page.authentication_policy_section.test_connection
end

Then /^Horizon Manager test connection message should be (.+)$/ do |message|
  @bus_site.admin_console_page.authentication_policy_section.test_connection_result.should == message
end