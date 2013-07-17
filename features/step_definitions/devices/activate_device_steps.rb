And /^activate the user's (Server|Desktop) device without a key and with the default password$/ do  |device_type|
  @client = Client.new(@new_users.first.email, CONFIGS['global']['test_pwd'], @current_partner[:id], @partner.company_info.name || @current_partner[:name], device_type)
  @license_key = @client.license_key
  Log.debug @license_key
  @license_key.should_not be_nil
end
When /^I use keyless activation to activate devices$/  do |table|
  # table is a | Machine1     | Desktop      |
  attr = table.hashes.first
  user_email = @current_user[:email]
  partner_name = (@partner && @partner.company_info.name) || @current_partner[:name]
  @current_partner[:id] ||= @bus_site.admin_console_page.partner_id
  client = Client.new(user_email, @user_password, @current_partner[:id], partner_name, attr['machine_type'], attr['machine_name'], attr['machine_codename'])
  @license_key = client.license_key
  @license_key.should_not be_nil
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