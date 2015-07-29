And /^I get the machine info should be$/ do | machine_info_table |
   attr = machine_info_table.hashes.first
   expected_quota = attr['quota']
   expected_used_space = attr['user_spaceused']

   username = @clients.last.username
   password = @clients.last.password
   machine_hash = @clients.last.machine_hash
   machine_info = get_machine_info(@admin_id, username, password, machine_hash)

   # compare the result
   machine_info[/quota:\d+/].should == 'quota:' + expected_quota
   machine_info[/user_spaceused:\d+/].should == 'user_spaceused:' + expected_used_space
end