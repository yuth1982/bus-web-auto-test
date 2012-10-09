When /^I use (Directory Service|Mozy) as authentication provider$/ do |provider|
  @bus_site.admin_console_page.authentication_policy_section.select_auth(provider)
end

When /^I select Horizon Manager with organization name (.*)$/ do |org_name|
  @bus_site.admin_console_page.authentication_policy_section.check_horizon(true)
  case org_name
  when 'nothing'
    @bus_site.admin_console_page.authentication_policy_section.fillin_org_name('')
  else
    @bus_site.admin_console_page.authentication_policy_section.fillin_org_name(org_name)
  end
end

When /^I Test Connection for (Horizon Manager|AD)$/ do |provider|
  case provider 
  when "Horizon Manager"
    @bus_site.admin_console_page.authentication_policy_section.test_connection_horizon
  when "AD"
    @bus_site.admin_console_page.authentication_policy_section.test_connection_ad
  end
end

When /^I move to the Sync rules tab$/ do
  @bus_site.admin_console_page.authentication_policy_section.move_to_sync_rules
end

When /^I add a new rule: (.+)$/ do |rule|
  @bus_site.admin_console_page.authentication_policy_section.fill_in_rules(1, rule)
end

Then /^There should be (\d+) items:$/ do |num, table|
  @bus_site.admin_console_page.authentication_policy_section.group_num.should == num.to_i
  @bus_site.admin_console_page.authentication_policy_section.group_names.should == table.headers
end

Then /test connection message should be (.+)$/ do |message|
  @bus_site.admin_console_page.authentication_policy_section.test_connection_result.should include(message)
end

When /^I clear (SAML Authentication|Connection Settings) information exists$/ do |tab|
  case tab
    when "SAML Authentication"
      @bus_site.admin_console_page.authentication_policy_section.clear_all
    when "Connection Settings"
      #TODO
    else
      #TODO
  end
  step "I save the #{tab} information"
end

When /^I click (SAML Authentication|Connection Settings) tab$/ do |tab|
  @bus_site.admin_console_page.authentication_policy_section.select_tab(tab)
end

When /^I load attributes$/ do
  @bus_site.admin_console_page.authentication_policy_section.load_attributes
  # Verify all input fields are disabled
  @bus_site.admin_console_page.authentication_policy_section.auth_URL_disabled?.should be_true
  while @bus_site.admin_console_page.authentication_policy_section.auth_URL_disabled? do
  end
end

Then /^SAML authentication information should include$/ do |table|
  # table is a | mozyqa2.horizonmanager.com/SAAS/API/1.0/GET/federation/request?s=1876 | horizonmanager.com| glbv7YsYBdLHAtbX2Geg==|pending
  data = table.hashes
  data.each do |d|
    @bus_site.admin_console_page.authentication_policy_section.auth_URL.should include(d[:URL])
    @bus_site.admin_console_page.authentication_policy_section.client_endpoint.should include(d[:Endpoint])
    @bus_site.admin_console_page.authentication_policy_section.certificate.should include(d[:Certificate])
  end
end

When /^I save the (SAML Authentication|Connection Settings) information$/ do |tab|
  step "I click #{tab} tab"
  case tab
  when "SAML Authentication"
    @bus_site.admin_console_page.authentication_policy_section.save_saml_tab
    @bus_site.admin_console_page.authentication_policy_section.auth_URL_disabled?.should be_true
    while @bus_site.admin_console_page.authentication_policy_section.auth_URL_disabled? do
    end
  when "Connection Settings"
    @bus_site.admin_console_page.authentication_policy_section.save_saml_tab
    @bus_site.admin_console_page.authentication_policy_section.server_host_disabled?.should be_true
    while @bus_site.admin_console_page.authentication_policy_section.server_host_disabled? do
    end
  else
  end
end

Then /^Horizon Manager load attribute information should be (Failed to load attributes from Horizon)$/ do |message|
  @bus_site.admin_console_page.authentication_policy_section.load_attributes_result.should include(message)
end

Then /^I load attributes and I should see an JS alert with message (Oranization name \(Org Name\) is not specified.)$/ do |message|
  @bus_site.admin_console_page.authentication_policy_section.load_attributes_alert_text.should include(message)
end

When /^I de-select Horizon Manager$/ do
  @bus_site.admin_console_page.authentication_policy_section.check_horizon(false)
end

When /^I input server connection settings$/ do |table|
  # table is a | ad01.qa5.mozyops.com | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
  server = table.hashes.first
  @connection_info = Bus::DataObj::ConnectionInfo.new
  @connection_info.server_host = server['Server Host']
  @connection_info.ssl_cert = server['SSL Cert']
  @connection_info.protocol = (server['Protocol'] == 'No SSL' ? 'false' : server['Protocol'].downcase)
  @connection_info.port = server['Port']
  @connection_info.base_dn = server['Base DN']
  @connection_info.bind_user = server['Bind Username']
  @connection_info.bind_password = server['Bind Password']
  @bus_site.admin_console_page.authentication_policy_section.fillin_connection_settings(@connection_info)
end

Then /^server connection settings information should include$/ do |table|
  # table is a | ad01.qa5.mozyops.com | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
  data = table.hashes.first
  connection_info = @bus_site.admin_console_page.authentication_policy_section.connection_info
  data['Server Host'].should include(connection_info.server_host)
  data['Protocol'].downcase.should include(connection_info.protocol)
  #data['SSL Cert'].should include(connection_info.ssl_cert)
  data['Port'].should include(connection_info.port)
  data['Base DN'].should include(connection_info.base_dn)
  data['Bind Username'].should include(connection_info.bind_user)
  data['Bind Password'].should include(connection_info.bind_password)
end
