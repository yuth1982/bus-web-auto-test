And /^activate the user's (Server|Desktop) device without a key and with the default password$/ do  |device_type|
  @new_clients =[]
  @clients =[] if @clients.nil?
  client = KeylessClient.new(@new_users.first.email, CONFIGS['global']['test_pwd'], @partner_id, @partner.company_info.name, device_type, @partner.partner_info.type)
  client.activate_client_devices
  @license_key = client.license_key
  Log.debug @license_key
  @license_key.should_not be_nil
  @new_clients << client
  @clients << client
end

When /^I use keyless activation to activate devices(| unsuccessful)$/  do | error, table|
  attr = table.hashes.first.each do |_, v|
    v.replace ERB.new(v).result(binding)
    v.gsub!(" ", "_")
  end

  user_email = attr['user_name'].nil? ? @current_user[:email] : attr['user_name']
  partner_name = (@partner && @partner.company_info.name) || @current_partner[:name]
  @current_partner[:id] ||= @bus_site.admin_console_page.partner_id
  @user_password = CONFIGS['global']['test_pwd'] unless !@user_password.nil?

  @new_clients =[]
  @clients =[] if @clients.nil?
  client = KeylessClient.new(user_email, @user_password, @current_partner[:id], partner_name, attr['machine_type'], @partner.partner_info.type, nil, nil, nil, attr['machine_name'])
  client.activate_client_devices
  @license_key = client.license_key
  if error.include?('unsuccessful')
    (client.response.body.include?('error')).should == true
  else
    @license_key.should_not be_nil
  end
  @new_clients << client
  @clients << client
end

When /^I use keyless activation to activate devices with (none machine hash|invalid machine hash|none access token|error access token)$/  do |error_type, table|
  attr = table.hashes.first.each do |_, v|
    v.replace ERB.new(v).result(binding)
    v.gsub!(" ", "_")
  end
  user_email = attr['user_name'].nil? ? @current_user[:email] : attr['user_name']
  partner_name = (@partner && @partner.company_info.name) || @current_partner[:name]
  @current_partner[:id] ||= @bus_site.admin_console_page.partner_id
  @user_password = CONFIGS['global']['test_pwd'] unless !@user_password.nil?

  machine_hash = nil
  if error_type == 'none machine hash'
    machine_hash = ''
  #invalid machine hash with length > 40
  elsif error_type == 'invalid machine hash'
    machine_hash = 'invalidmachinehashabdafoier435gsgsgletw34nsgsdfgserttwer'
  end

  client = KeylessClient.new(user_email, @user_password, @current_partner[:id], partner_name, attr['machine_type'], @partner.partner_info.type, nil, nil, machine_hash, attr['machine_name'])

  if error_type == 'none access token'
    access_token = '{"access_token", ""}'
  elsif error_type == 'error access token'
    access_token = '{"access_token", "NzUwNjk0NDI4NGZkYWI1OGMzOTVlMzViNTlmMzNmN2M1YmExMjI3YzpwYXNzd29yZA=="}'
  end
  client.activate_client_devices(access_token)
  @new_clients =[]
  @clients =[] if @clients.nil?
  @new_clients << client
  @clients << client
end

Then /^activate machine result should be$/ do |table|
  attr = table.hashes.first.each do |_, v|
    v.replace ERB.new(v).result(binding)
  end
  attr = table.hashes.first
  expected_code = attr['code']
  expected_body = attr['body']
  #for negative case, the response could like:  #<Net::HTTPUnauthorized 401 Authorization Required readbody=true>
  Log.debug @clients.last.response
  begin
    @clients.last.response.code.should == expected_code
  rescue
    (@clients.last.response).match(/\d+/)[0].should == expected_code
  end

  actual_body = @clients.last.response.body
  if expected_body.include?('machine license key')
    ((actual_body.match(/^\{"license_key":"(\w)+"\}$/)).nil?).should == false
  else
    actual_body.should == expected_body
  end
end

When /^I add machines for the user and update its used quota$/ do |table|
  header = table.headers.join('|')
  table.rows.each_with_index do |row, index|
    step %{I use keyless activation to activate devices}, table(%{
      |#{header}|
      |#{row.join('|')}|
    })
    step %{I get the machine_id by license_key}
    step %{I update the newly created machine used quota to #{table.hashes[index]['used_quota']}}
  end
end

When /^I activate the new user's (\d+) (Server|Desktop) device\(s\) and update used quota to (\d+) GB$/ do |times, device_type, quota|
  user_id = DBHelper.get_user_id_by_email @new_users[0].email
  DBHelper.create_machines(user_id, device_type, times, quota.to_i)
end

And /^activate the user's device with a key and with the default password$/ do
  @new_clients =[]
  @clients =[] if @clients.nil?
  client = Client.new(@key, @new_users.first.email, CONFIGS['global']['test_pwd'], @partner.company_info.name, @partner.partner_info.type)
  @new_clients << client
  @clients << client
end

When /^I use key activation to activate devices$/  do |table|
  # table is a | Machine1     | Desktop      |
  attr = table.hashes.first
  user_email = @current_user[:email]
  partner_name = (@partner && @partner.company_info.name) || @current_partner[:name]
  @current_partner[:id] ||= @bus_site.admin_console_page.partner_id

  @new_clients =[]
  @clients =[] if @clients.nil?
  client = Client.new(@key, user_email, @user_password, partner_name, @partner.partner_info.type, attr['machine_name'])
  @new_clients << client
  @clients << client
end


