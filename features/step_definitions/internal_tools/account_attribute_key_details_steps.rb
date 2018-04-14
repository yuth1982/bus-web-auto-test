When /^I edit account attribute key:$/ do | account_attribute_key_table|
  attributes = account_attribute_key_table.hashes.first
  @bus_site.admin_console_page.account_attribute_key_details_section.edit_account_attribute_key(attributes)
end