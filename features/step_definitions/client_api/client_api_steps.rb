And /^I get the machine info should be$/ do | machine_info_table |
  machine_info_table.hashes.first.each do |k,v|
    v.replace ERB.new(v).result(binding)
  end
  attr = machine_info_table.hashes.first
  expected_quota = attr['quota']
  expected_used_space = attr['user_spaceused']

  username = @clients.last.username
  password = @clients.last.password
  machine_hash = @clients.last.machine_hash
  machine_hash = attr['machine_hash'] unless attr['machine_hash'].nil?
  machine_info = get_machine_info(@admin_id, username, password, machine_hash)

  # compare the result
  machine_info[/quota:\d+/].should == 'quota:' + expected_quota
  machine_info[/user_spaceused:\d+/].should == 'user_spaceused:' + expected_used_space
end

And /^I get the machine info with other user authentication should be$/ do | error_msg|
  username = @users.last.email
  password = @clients.last.password
  machine_hash = @clients.last.machine_hash
  machine_info = get_machine_info(@admin_id, username, password, machine_hash)
  machine_info.strip.should == error_msg.strip
end

And /^I set machine used quota by sql$/ do | table |
  table.hashes.first.each do |k,v|
    v.replace ERB.new(v).result(binding)
  end
  attr = table.hashes.first
  DBHelper.set_machine_used_quota(attr['machine_id'], attr['quota'])
end

And /^Get client user resources api with invalid authorization result should like$/ do | error_msg |
  user_email = @new_users.last.email
  user_password = CONFIGS['global']['test_pwd']
  invalid_access_token = 'fasdfsdffsdf'
  # get the api response
  api_response = get_client_user_resources(user_email, user_password, @current_partner[:id], @current_partner[:name], invalid_access_token)
  api_response.strip.should == error_msg.strip
end

And /^Get client user resources api result should be$/ do | response_table |
  attr = response_table.hashes.first
  expected_stash = attr['stash']
  expected_backup = attr['backup']
  expected_server = attr['server']
  expected_desktop = attr['desktop']
  user_email = @new_users.last.email
  user_password = CONFIGS['global']['test_pwd']

  # get the api response
  api_response = get_client_user_resources(user_email, user_password, @current_partner[:id], @current_partner[:name])
  actual_stash = api_response['stash']['active_devices']
  actual_backup = api_response['backup']['active_devices']
  actual_total_devices = api_response['backup']['total_devices']

  # for partner without server add-on, there should be no server number in the reponse
  if expected_server.nil?
    (actual_total_devices['Server'].nil?).should == true
  else
    actual_total_devices['Server'].should == expected_server.to_i
  end
  actual_total_devices['Desktop'].should == expected_desktop.to_i
  actual_stash.size.should == expected_stash.to_i
  actual_backup.size.should == expected_backup.to_i

  # if there is sync machine, check related attribute is not empty
  if actual_stash.size > 0
    (actual_stash[0]['device_hash'].blank?).should == false
    (actual_stash[0]['id'].blank?).should == false
    actual_stash[0]['alias'].should == 'Sync'
  end

  #if there are backup machines, check the device information
  if actual_backup.size > 0
    @clients.each_with_index do |value, index|
      actual_backup[index]['device_hash'].should == value.machine_hash
      actual_backup[index]['license_type'].should == value.device_type
      actual_backup[index]['license_key'].should == value.license_key
      actual_backup[index]['alias'].should == value.machine_alias
      (actual_backup[0]['id'].blank?).should == false
    end
  end

end


