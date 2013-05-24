And /^activate the user's (Server|Desktop) device without a key and with the default password$/ do  |device_type|
  @client = Client.new(@new_users.first.email, CONFIGS['global']['test_pwd'], @partner_id, @partner.company_info.name, device_type)
  @license_key = @client.license_key
  Log.debug @license_key
  @license_key.should_not be_nil
end
When /^I use keyless activation to activate devices$/  do |table|
  # table is a | @user_email | Machine1     | Desktop      | @partner_name |
  attr = table.hashes.first
  user_email = attr['user_email'] == '@user_email' ? @new_users.first.email : attr['user_email']
  partner_name = attr['partner_name'] == '@partner_name' ? @partner.company_info.name : attr['partner_name']
  client = Client.new(user_email, @user_password, @partner_id, partner_name, attr['machine_type'], attr['machine_name'])
  @license_key = client.license_key
  @license_key.should_not be_nil
end

When /^I add (\d+) machines for the user and update its used quota$/ do |count, table|
  count.to_i.times do |row|
    step %{I use keyless activation to activate devices}, table(%{
      |#{table.headers.join('|')}|
      |#{table.rows[row].join('|')}|
    })
    step %{I get the machine_id by license_key}
    step %{I update the newly created machine used quota to #{table.hashes[row]['used_quota']}}
  end
end