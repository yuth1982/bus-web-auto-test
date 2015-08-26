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

And /^I cancel update client configuration$/ do
  @bus_site.admin_console_page.client_config_section.cc_iframe.cancel_edit_client_config
end

Then /^I remove user group: (.+) from the configuration$/ do |user_group_name|
  @bus_site.admin_console_page.client_config_section.cc_iframe.remove_group_from_config(user_group_name)
end

Then /^I save the client configuration changes$/ do
  @bus_site.admin_console_page.client_config_section.cc_iframe.save_client_configs
end

And /^I copy client configuration (.+) to create new client configuration (.+)/ do |old_config_name,new_config_name|
  @bus_site.admin_console_page.client_config_section.cc_iframe.copy_client_config(old_config_name,new_config_name)
end

Then /^the group of client configuration (.+) should be (.+)$/ do |config_name,group_name|
  if group_name == 'blank'
    @bus_site.admin_console_page.client_config_section.cc_iframe.get_client_config_group(config_name).size.should == 0
  else
    @bus_site.admin_console_page.client_config_section.cc_iframe.get_client_config_group(config_name).should == group_name
  end
end

And /^I click tab (.+)$/ do |tab_name|
  @bus_site.admin_console_page.client_config_section.cc_iframe.click_tab(tab_name)
end

Then /^I should on linux backup sets list page$/ do
  @bus_site.admin_console_page.client_config_section.cc_iframe.create_backup_lnk_visible.should be_true
end

##| linux backup set name |name includes|name excludes|type includes|type excludes|exclusionary| search locations 1 |search locations 2        |delete location |
##| 126287_backupset      | test1       | test2       | autotest1   | autotest2   | true       |Include:/home/user/www|Exclude:/home/user1/www| /a/c|
When /^I (create|edit) Linux Backup Set:$/ do |action,backupset_table|
  attributes = backupset_table.hashes.first
  if action == 'create'
    @linux_backup_sets = Bus::DataObj::LinuxBackupSets.new
    @linux_backup_sets.backup_name = attributes['linux backup set name'] unless attributes['linux backup set name'].nil?
    @bus_site.admin_console_page.client_config_section.cc_iframe.set_linux_backup_name(@linux_backup_sets.backup_name)
  end

  # input exclusionary
  exclusionary = attributes['exclusionary'] unless attributes['exclusionary'].nil?
  unless exclusionary.nil?
    @bus_site.admin_console_page.client_config_section.cc_iframe.check_exclusionary(exclusionary)
    @linux_backup_sets.exclusionary = exclusionary
  end

  # get inputted rules and locations
  locations = []
  rules = Hash.new
  attributes.each do |key,value|
    if  key.match(/^search locations \d+$/)
        type_location = value.split(':')
        locations << {'location types' => type_location[0],'folder names' => type_location[1]}
    end
    if key.match(/\w+[in|ex]cludes$/)
      rules[key]=value
    end
  end

  # add/edit locations
  if locations.size > 0
    @bus_site.admin_console_page.client_config_section.cc_iframe.add_locations(locations)
    @linux_backup_sets.search_locations = locations
  end

  #add/edit rules
  if rules.size > 0
    @linux_backup_sets.rules = rules
    @bus_site.admin_console_page.client_config_section.cc_iframe.add_linux_backup_rules(@linux_backup_sets.rules)
  end

  #delete location
  unless attributes['delete location'].nil?
    del_location = []
    del_type_location = attributes['delete location'].split(':')
    @bus_site.admin_console_page.client_config_section.cc_iframe.delete_location(del_type_location[1])
    del_location << {'location types' => del_type_location[0],'folder names' => del_type_location[1]}
    @linux_backup_sets.search_locations = locations - del_location
  end
end

When /^I click edit link of linux backup set (.+)$/ do |backup_name|
  @bus_site.admin_console_page.client_config_section.cc_iframe.click_edit_linux_backup(backup_name)
end

Then /^edit link of linux backup set (.+) should be disabled$/ do |backup_name|
  @bus_site.admin_console_page.client_config_section.cc_iframe.edit_linux_backup_exsit(backup_name).size.should == 0
end

When /^I delete linux backup set (.+)$/ do |backup_name|
  @bus_site.admin_console_page.client_config_section.cc_iframe.delete_linux_backup(backup_name)
end

Then /^linux backup set (.+) should be opened$/ do |backup_name|
  @bus_site.admin_console_page.client_config_section.cc_iframe.backup_name_visible(backup_name).should be_true
end

Then /^linux backup set (.+) (should not|should) exist$/ do |backup_name,action|
  if action == 'should not'
    @bus_site.admin_console_page.client_config_section.cc_iframe.backup_set_name_visible(backup_name).should < 1
  else
    @bus_site.admin_console_page.client_config_section.cc_iframe.backup_set_name_visible(backup_name).should > 0
  end
end

When /^I (check|uncheck) the (setting|cascade|lock) for linux backup set (.+)/ do |action,type, backup_name|
  index = 0
  case type
    when 'cascade'
      index = 2
    when 'setting'
      index = 1
    when 'lock'
      index = 3
  end
  backup_hash ={'backup name' => backup_name, 'index' => index, 'action' => action}
  @bus_site.admin_console_page.client_config_section.cc_iframe.lock_cascade_setting_linux_backup(backup_hash)
end

Then /^the (setting|setting and lock|setting and lock and cascade) of linux backup set (.+) should be (disabled|checked|unchecked)/ do |action, backup_name,type|
  backup_array = []
  if action.include?('cascade')
    backup_array << {'backup name' => backup_name, 'index' => 2}
  end
  if action.include?('setting')
    backup_array << {'backup name' => backup_name, 'index' => 1}
  end
  if action.include?('lock')
    backup_array << {'backup name' => backup_name, 'index' => 3}
  end
  backup_array.each_index do |n|
    if type == 'disabled'
      @bus_site.admin_console_page.client_config_section.cc_iframe.lock_cascade_setting_linux_backup_disabled?(backup_array[n]).should be_true
    elsif type == 'checked'
      @bus_site.admin_console_page.client_config_section.cc_iframe.lock_cascade_setting_linux_backup_checked?(backup_array[n]).should be_true
    else
      @bus_site.admin_console_page.client_config_section.cc_iframe.lock_cascade_setting_linux_backup_checked?(backup_array[n]).should be_false
    end
  end
end

Then /^the linux backup set should be:$/ do |backupset_table|
  attributes = backupset_table.hashes.first
  expected_rules = Hash.new
  expected_locations = []
  attributes.each do |key,value|
    # get expected rules
    if key.match(/\w+[in|ex]cludes$/)
      expected_rules[key]=value
    end
    # get expected locations
    if key.match(/^search locations \d+$/)
      type_location = value.split(':')
      expected_locations << {'location types' => type_location[0],'folder names' => type_location[1]}
    end
  end
  if expected_rules.size > 0
    actual_rules = @bus_site.admin_console_page.client_config_section.cc_iframe.get_linux_backup_rules
    expected_rules.each_key do |key|
      expected_rules[key].should == actual_rules[key]
      Log.debug("actual #{key} rule is:"+actual_rules[key])
    end
  end
  if expected_locations.size > 0
    actual_locations = @bus_site.admin_console_page.client_config_section.cc_iframe.get_search_locations
    Log.debug("search locations from UI is:"+actual_locations.to_s)
    (expected_locations - actual_locations).size.should == 0
  end
  # check exclusionary
  exclusionary = attributes['exclusionary'] unless attributes['exclusionary'].nil?
  unless exclusionary.nil?
    Log.debug("exclusionary from UI is:"+exclusionary.to_s)
    @bus_site.admin_console_page.client_config_section.cc_iframe.get_exclusionary.to_s.should == exclusionary
  end
end

When /^I get linux backup sets through API$/ do
  username =  @clients.last.username
  password =  @clients.last.password
  machine_hash =  @clients.last.machine_hash
  get_linux_backup_sets_clients(@admin_id, username, password, machine_hash)
end

And /^I click (done to save|cancel to cancel update) linux backup sets$/ do |action|
  case action
    when 'done to save'
      @bus_site.admin_console_page.client_config_section.cc_iframe.click_done
    when 'cancel to cancel update'
      @bus_site.admin_console_page.client_config_section.cc_iframe.cancel_edit_linuxset
  end
  @bus_site.admin_console_page.client_config_section.wait_until_bus_section_load
end

When /^I delete configuration (.+)/ do |client_config|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['client_configuration'])
  @bus_site.admin_console_page.client_config_section.cc_iframe.delete_client_config(client_config)
end

# | exclusionary | search locations 1        | search locations 2         | filenames    |exclude_filenames          | filetypes                     | exclude_filetypes |
# | true         | Include:/home/备份/backup* | Exclude:/home/qiezi/*.exe  | /home/user/ |note  *e* "UNIT TEXT" 文件 | log txt JPG EXE MSI TA*  *LSX | exe rb        |
Then /^the backup sets from API should be:$/ do |sets_table|
  expected_sets_array = sets_table.hashes
  expected_sets_array.each_index do |array_index|
    expected_sets = expected_sets_array[array_index]
    expected_exclusionary = expected_sets['exclusionary'] unless expected_sets['exclusionary'].nil?
    expected_name = expected_sets['linux backup set name'] unless expected_sets['linux backup set name'].nil?
    expected_rules = Hash.new
    expected_locations = []
    expected_sets.each do |key,value|
      #get expected rules
      if key.match(/^*file\w+s$/)
        expected_rules[key]=value
      end
      #get expected locations
      if key.match(/^search locations \d+$/)
        type_location = value.split(':')
        expected_locations << {'location types' => type_location[0],'folder names' => type_location[1]}
      end
    end
    #check backup set name
    @backupsets_from_client[array_index]['name'].to_s.should == expected_name unless expected_name.nil?

    #check exclusionary
    unless expected_exclusionary.nil?
      exclusionary_response = @backupsets_from_client[array_index]['exclusionary']
      Log.debug("exclusionary from API is:"+exclusionary_response.to_s)
      exclusionary_response.to_s.should == expected_exclusionary
    end
    #get and check rules from api
    if expected_rules.size > 0
      rules_response = @backupsets_from_client[array_index]['rules']
      expected_rules.each_key do |key|
        rules_response[key] = rules_response[key].join(' ')
        Log.debug("rules from API is:"+rules_response[key].to_s)
        rules_response[key].to_s.should == expected_rules[key].gsub("\"","")
      end
    end
    #get and check locations from api
    if expected_locations.size >0
      excludes_locations = @backupsets_from_client[array_index]['excludes']
      includes_locations = @backupsets_from_client[array_index]['paths']
      actual_locations = []
      if excludes_locations.size > 0
        excludes_locations.each_index do |n|
          actual_locations << {'location types' => 'Exclude', 'folder names' => excludes_locations[n]}
        end
      end
      if includes_locations.size > 0
        includes_locations.each_index do |n|
          actual_locations << {'location types' => 'Include', 'folder names' => includes_locations[n]}
        end
      end
      #expected_locations && actual_locations =[{'location types' => 'Include',folder names' =>'/a/b/c'},{},......]
      Log.debug("search locations from API is:"+actual_locations.to_s)
      (expected_locations - actual_locations).size.should == 0
    end
  end
end

Then /^the linux backup set (.+) shouldn't exist in Client API$/ do |backup_name|
  @backupsets_from_client.each_index do |n|
    @backupsets_from_client[n]['name'].to_s.should_not == backup_name
  end
end


