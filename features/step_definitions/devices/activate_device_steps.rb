And /^activate the user's (Server|Desktop) device without a key and with the default password$/ do  |device_type|
  @client = Client.new(@new_users.first.email, CONFIGS['global']['test_pwd'], @partner_id, @partner.company_info.name, device_type)
  @license_key = @client.license_key
  Log.debug @license_key
  @license_key.should_not be_nil
end
