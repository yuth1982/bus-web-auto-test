Then /^I create a new client config:$/ do |table|
  #bus requires a throttle amount greater than zero when default throttle is left checked
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['client_configuration'])

  @client_config = Bus::DataObj::ClientConfig.new
  attributes = table.hashes.first
  @client_config.name = attributes['name']
  @client_config.type = attributes['type']
  @client_config.throttle = (attributes['throttle'] || "no").eql?("yes")
  @client_config.throttle_amount = attributes['throttle amount']
  @client_config.user_group = attributes['user group']

  @bus_site.admin_console_page.client_config_section.wait_until_bus_section_load
  @bus_site.admin_console_page.client_config_section.create_client_config(@client_config)
end

Then /^client configuration section message should be (.+)/ do |message|
  @bus_site.admin_console_page.client_config_section.messages == message
end

Then /^I delete configuration (.+)/ do |client_config|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['client_configuration'])
  @bus_site.admin_console_page.client_config_section.delete_client_config(client_config)
end

Then /^existing client config should be:/ do |table|
  @bus_site.admin_console_page.client_config_section.assert_existing_config_hashes(table)
end