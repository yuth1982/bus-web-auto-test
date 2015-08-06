Then /^I create a new client config:$/ do |table|
  #bus requires a throttle amount greater than zero when default throttle is left checked
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['client_configuration'])

  @client_config = Bus::DataObj::ClientConfig.new
  attributes = table.hashes.first
  @client_config.name = attributes['name']
  @client_config.type = attributes['type']
  @client_config.ckey = attributes['ckey']
  @client_config.user_group = attributes['user group']
  @client_config.user_group_2 = attributes['user group 2']
  @client_config.private_key = attributes['private_key']
  @client_config.throttle = (attributes['throttle'] || "no").eql?("yes")
  @client_config.throttle_amount = attributes['throttle amount']

  @bus_site.admin_console_page.client_config_section.wait_until_bus_section_load
  @bus_site.admin_console_page.client_config_section.cc_iframe.create_client_config(@client_config)
end

Then /^client configuration section message should be (.+)/ do |message|
  @bus_site.admin_console_page.client_config_section.cc_iframe.messages == message
end

Then /^I edit the new created config (.+)$/ do |client_config_name|
  @bus_site.admin_console_page.client_config_section.cc_iframe.edit_client_config(client_config_name)
end

Then /^I remove user group: (.+) from the configuration$/ do |user_group_name|
  @bus_site.admin_console_page.client_config_section.cc_iframe.remove_group_from_config(user_group_name)
end

Then /^I save the client configuration changes$/ do
  @bus_site.admin_console_page.client_config_section.cc_iframe.save_client_configs
end

And /^I click tab (.+)$/ do |tab_name|
  @bus_site.admin_console_page.client_config_section.cc_iframe.click_tab(tab_name)
end

##| linux backup set name |name includes|name excludes|type includes|type excludes| search locations 1 |search locations 2|
##| 126287_backupset      | test1       | test2       | autotest1   | autotest2   | Include:/home/user/www|Exclude:/home/user1/www|
When /^I (create|edit) Linux Backup Set:$/ do |action,backupset_table|
  attributes = backupset_table.hashes.first
  if action == 'create'
    @linux_backup_sets = Bus::DataObj::LinuxBackupSets.new
    @linux_backup_sets.backup_name = attributes['linux backup set name'] unless attributes['linux backup set name'].nil?
    @bus_site.admin_console_page.client_config_section.cc_iframe.set_linux_backup_name(@linux_backup_sets.backup_name)
  end

  #add/edit locations
  locations = []
  attributes.each do |key,value|
    if  key.match(/^search locations \d+$/)
        type_location = value.split(':')
        locations << {'location types' => type_location[0],'folder names' => type_location[1]}
    end
  end

  if locations.size > 0
    @bus_site.admin_console_page.client_config_section.cc_iframe.add_locations(locations)
    @linux_backup_sets.search_locations = locations
  end

  #add/edit rules
  rules = Hash.new
  attributes.each do |key,value|
    if key.match(/\w+[in|ex]cludes$/)
      rules[key]=value
    end
  end

  if rules.size > 0
    @linux_backup_sets.rules = rules
    @bus_site.admin_console_page.client_config_section.cc_iframe.add_linux_backup_rules(@linux_backup_sets.rules)
  end
end

When /^I click edit link of linux backup set (.+)$/ do |backup_name|
  @bus_site.admin_console_page.client_config_section.cc_iframe.click_edit_backup(backup_name)
end

Then /^linux backup set (.+) should be opened$/ do |backup_name|
  @bus_site.admin_console_page.client_config_section.cc_iframe.backup_name_visible(backup_name).should be_true
end

When /^I (setting|cascade|lock) linux backup set (.+)/ do |type, backup_name|
  case type
    when 'cascade'
      @bus_site.admin_console_page.client_config_section.cc_iframe.cascade_linux_backup(backup_name)
    when 'setting'
      @bus_site.admin_console_page.client_config_section.cc_iframe.setting_linux_backup(backup_name)
    when 'lock'
      @bus_site.admin_console_page.client_config_section.cc_iframe.lock_linux_backup(backup_name)
  end
end

Then /^the linux backup set should be:$/ do |backupset_table|
  #check rules
  attributes = backupset_table.hashes.first
  expected_rules = Hash.new
  attributes.each do |key,value|
    if key.match(/\w+[in|ex]cludes$/)
      expected_rules[key]=value
    end
  end
  if expected_rules.size > 0
    actual_rules = @bus_site.admin_console_page.client_config_section.cc_iframe.get_linux_backup_rules
    expected_rules.each do |key,value|
      value.should == actual_rules[key]
      Log.debug("actual #{key} rule is:"+actual_rules[key])
    end
  end
  ##will add check search locations here
end

When /^I get backup sets rule through API$/ do
  username =  @clients.last.username
  password =  @clients.last.password
  machine_hash =  @clients.last.machine_hash
  get_linux_backup_sets_clients(@admin_id, username, password, machine_hash)
end

And /^I click done to save linux backup sets$/ do
  @bus_site.admin_console_page.client_config_section.cc_iframe.click_done()
  @bus_site.admin_console_page.client_config_section.wait_until_bus_section_load
end

When /^I delete configuration (.+)/ do |client_config|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['client_configuration'])
  @bus_site.admin_console_page.client_config_section.cc_iframe.delete_client_config(client_config)
end

Then /^the backup set rules from API should be:$/ do |rules_client_table|
  expected = rules_client_table.hashes.first
  rules_response = @backupsets_from_client[0]['rules']
  expected.each do |key, value|
    rules_response[key][0].to_s.should == value
    Log.debug("rules from API is:"+rules_response[key][0].to_s)
  end
end