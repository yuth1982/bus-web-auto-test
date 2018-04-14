When /^I search account attribute key (.+)$/ do | account_attribute_key_name |
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['list_account_attribute_keys'])
  @bus_site.admin_console_page.list_account_attribute_keys_section.search_account_attribute_key(account_attribute_key_name)
end

And /^I get account attribute key (.+) info:$/ do | account_attribute_key_name,  account_attribute_key_details|
  attributes = account_attribute_key_details.hashes.first
  @bus_site.admin_console_page.list_account_attribute_keys_section.get_account_attribute_key_info(account_attribute_key_name).should == attributes
end

And /^I delete account attribute key (.+)$/ do | account_attribute_key_name |
  @bus_site.admin_console_page.list_account_attribute_keys_section.delete_account_attribute_key(account_attribute_key_name)
end
