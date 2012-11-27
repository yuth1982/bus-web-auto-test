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

When /^I click (SAML Authentication|Connection Settings|Sync Rules|Attribute Mapping) tab$/ do |tab|
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
    @bus_site.admin_console_page.authentication_policy_section.encrypted_saml?.should == (d[:Encrypted] == 'Yes' ? true : false) if d[:Encrypted]
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
  #data['Bind Password'].should include(connection_info.bind_password)
end

Then /^user mapping tab should be disabled$/ do
  @bus_site.admin_console_page.authentication_policy_section.tabs().should_not include("Sync Rules")
  @bus_site.admin_console_page.authentication_policy_section.tabs().should_not include("Arribute Mapping")
end

When /^I select Protocol as (No SSL|StartTLS|LDAPS)$/ do |p|
  @bus_site.admin_console_page.authentication_policy_section.select_protocol(p == 'No SSL' ? 'false' : p.downcase)
end

Then /^certificate text field is (disabled|enabled)$/ do |p|
  if p == 'disabled'
    @bus_site.admin_console_page.authentication_policy_section.data_ad_connection_cert_displayed?.should be_false
  else
    @bus_site.admin_console_page.authentication_policy_section.data_ad_connection_cert_displayed?.should be_true
  end
end

When /^I input SAML authentication information$/ do |table|
  # table is a |sso.connect.pingidentity.com|sso.connect.pingidentity.com | abcdefghijkl     | No        |
  auth = table.hashes.first
  @saml_info = Bus::DataObj::SAMLInfo.new
  @saml_info.auth_url = auth['URL']
  @saml_info.saml_endpoint = auth['Endpoint']
  @saml_info.saml_cert = auth['Certificate']
  @saml_info.encrypted = (auth['Encrypted'] == 'No') ? false : true
  @bus_site.admin_console_page.authentication_policy_section.fillin_saml_settings(@saml_info)
end


When /^I click Test Connection button$/ do
  @bus_site.admin_console_page.authentication_policy_section.test_connection
end

Then /^There should be (\d+) (.+) items:$/ do |num, type, table|
  @bus_site.admin_console_page.authentication_policy_section.options_num(type).should == num.to_i
  @bus_site.admin_console_page.authentication_policy_section.options_names(type).should == table.headers
end

Then /^The sync status result should be:$/ do |table|
  @bus_site.admin_console_page.authentication_policy_section.sync_result.should == table.rows.first
end

Then /^The layout of attribute should:$/ do |table|
  @bus_site.admin_console_page.authentication_policy_section.attribute_layout.should == table.raw
end

When /^I add (\d+) new (.+) rules:$/ do |num, type, table|
  @bus_site.admin_console_page.authentication_policy_section.add_rules(type, num.to_i, table.transpose.raw[0], table.transpose.raw[1])
end

Then /^The (.+) order icon should be correct$/ do |type, table|
  num = table.raw.length
  (1..num).each { |i| @bus_site.admin_console_page.authentication_policy_section.arrow_status(type, i).should == table.raw[i - 1] }
end

When /^I save the changes$/ do
  @bus_site.admin_console_page.authentication_policy_section.save_changes
end

Then /^Authentication Policy has been updated successfully$/ do
  @bus_site.admin_console_page.authentication_policy_section.result_message.should == 'Authentication Policy has been updated successfully.'
end

When /^I change the (.+) order by the following rule:$/ do |type, table|
  r = table.raw
  r.each do |row|
    if row[1] != ''
      @bus_site.admin_console_page.authentication_policy_section.change_order(type, row[0], row[1])
    end
  end
end

Then /^The new (.+) rules order should be:$/ do |type, table|
  @bus_site.admin_console_page.authentication_policy_section.rules_order(type).should == table.rows
end

When /^I delete (\d+) (.+) rules$/ do |num, type|
  num.to_i.times do
    @bus_site.admin_console_page.authentication_policy_section.delete_rule(type)
  end
end

Then /^The (.+) rule number is (\d+)$/ do |type, num|
  @bus_site.admin_console_page.authentication_policy_section.rule_num(type).should == num.to_i
end

When /^I move to the connection settings tab when changing from mozy to ad$/ do
  @bus_site.admin_console_page.authentication_policy_section.change_provider_connecting_settings
end

When /^The selected (.+) option is (.+)$/ do |type, option|
  @bus_site.admin_console_page.authentication_policy_section.selected_option(type).should == option
end

When /^The save error message should be:$/ do |table|
  @bus_site.admin_console_page.authentication_policy_section.result_message.should == "#{table.raw[0][0]}\n#{table.raw[1][0]}"
end

When /^I click the sync now button$/ do
  @bus_site.admin_console_page.authentication_policy_section.sync_now
  @sync_time = Time.now
  Log.debug(@sync_time)
end

Then /^The sync status result should like:$/ do |table|
#  sleep(1)
#  pre_time = @bus_site.admin_console_page.authentication_policy_section.sync_result[0]
#  while @bus_site.admin_console_page.authentication_policy_section.sync_result[0] == pre_time
#    pre_time = @bus_site.admin_console_page.authentication_policy_section.sync_result[0]
#    @bus_site.admin_console_page.authentication_policy_section.refresh
#  end
  @bus_site.admin_console_page.authentication_policy_section.refresh
  sleep(6)
  @bus_site.admin_console_page.authentication_policy_section.sync_result[0].should == table.rows.first[0]
  last_sync_time = @bus_site.admin_console_page.authentication_policy_section.sync_result[1]
  Log.debug("last sync time is #{last_sync_time}")
  Log.debug("the time to click sync now is #{@sync_time}")
  Log.debug(Time.strptime(last_sync_time, '%m/%d/%y %H:%M %Z') - @sync_time)

  (Time.strptime(last_sync_time, '%m/%d/%y %H:%M %Z') - @sync_time).abs.should be < 120
  expected_next_sync = table.rows.first[2]
  unless expected_next_sync.nil?
    if expected_next_sync == ''
      @bus_site.admin_console_page.authentication_policy_section.sync_result[2].should == expected_next_sync
    elsif expected_next_sync != '@next_sync_time'
      next_time_got = @bus_site.admin_console_page.authentication_policy_section.sync_result[2]
      p next_sync_time = Time.strptime(next_time_got, '%m/%d/%y %H:%M %Z')
      t = Time.now
      p expected_time = Time.utc(t.year,t.month, t.day, expected_next_sync.to_i, 0, 0).getlocal
      if Time.now > expected_time
        expected_time = Time.utc(t.year,t.month, t.day + 1, expected_next_sync.to_i, 0, 0).getlocal
      end
      Log.debug("the next sync time is #{@bus_site.admin_console_page.authentication_policy_section.sync_result[2]}")
      next_sync_time.should == expected_time
    else
    end
#  @bus_site.admin_console_page.authentication_policy_section.sync_result[2].should == '09/20/12 11:00 +08:00'
  end
end

When /^I Choose to (.+) users if missing from LDAP for (\d+) days$/ do |method, days|
  @bus_site.admin_console_page.authentication_policy_section.handle_user(method, days.to_i)
end

When /^I change the user last sync field in the db to be (\d+) days earlier$/ do |days|
  DBHelper.change_last_sync_at(@user_id, days.to_i)
end

When /^I wait until the sharp time$/ do
  sec = (60 - Time.now.min) * 60
  Log.debug(Time.now)
  Log.debug("wait for #{sec} seconds")
  sleep(sec)
end

When /^I choose to sync daily at the nearest sharp time$/ do
  t = Time.now
  # needs to refine here
  @sync_time = Time.new(t.year,t.month,t.day,(t.hour+1),0,0)
  next_sync_time = (t.getutc.hour + 1) % 24
  Log.debug("The scheduled sync time is #{next_sync_time} utc")
  @bus_site.admin_console_page.authentication_policy_section.sync_daily_at(next_sync_time)
end

When /^I clear the user sync information$/ do
  @bus_site.admin_console_page.authentication_policy_section.clear_user_sync_info
end

When /^I add a user (.+) to the AD$/ do |username|
  LDAPHelper.add_user(username)
end
When /^I delete a user (.+) in the AD$/ do |username|
  LDAPHelper.delete_user(username)
end

When /^I update a user in the AD:$/ do |table|
  # table is a | dev_test4 | :cn       | dev_test44   |
  data = table.rows.first
  LDAPHelper.update_user(data[0], data[1], data[2])
end
Then /^I get the user (.+) details in the console$/ do |username|
  LDAPHelper.show_user(username)
end

When /^I modify a user (.+) to (.+) in the AD:$/ do |username, new_name|
  LDAPHelper.modify_rdn(username, new_name)
end

When /^I choose to daily sync at (\d+) GMT$/ do |hour|
  @bus_site.admin_console_page.authentication_policy_section.sync_daily_at(hour)
end

When /^I set the fixed attribute to (.+)$/ do |attr|
  @bus_site.admin_console_page.authentication_policy_section.set_fixed_attribute(attr)
end

Then /^The daily sync time should be (\d+) GMT$/ do |hour|
  @bus_site.admin_console_page.authentication_policy_section.sync_daily_time.should == hour
end

When /^I clear the daily sync information$/ do
  @bus_site.admin_console_page.authentication_policy_section.sync_daily_at('')
end

Then /^The daily sync time should be empty$/ do
  @bus_site.admin_console_page.authentication_policy_section.sync_daily_time.should == ''
end

When /^I clear the fixed attribute$/ do
  @bus_site.admin_console_page.authentication_policy_section.set_fixed_attribute('')
end

Then /^I change root role to (.+)$/ do | role |
  @bus_site.admin_console_page.partner_details_section.change_root_role(role)
end
Then /^I should see (Mozy|LDAP) auth selected$/ do |provider|
  case provider
  when "Mozy"
    @bus_site.admin_console_page.authentication_policy_section.provider_mozy_checked?.should be_true
    @bus_site.admin_console_page.authentication_policy_section.provider_ldap_checked?.should be_false
  when "LDAP"
    @bus_site.admin_console_page.authentication_policy_section.provider_ldap_checked?.should be_true
    @bus_site.admin_console_page.authentication_policy_section.provider_mozy_checked?.should be_false
  end
end
When /^I see the response code is (\d+)$/ do |code|
  @bus_site.admin_console_page.authentication_policy_section.response_code.should == code
end