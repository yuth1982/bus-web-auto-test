
Then /^Account details table should be:$/ do |acc_details_table|
  acc_details_table.map_column!('value') do |value|
    value.gsub(/@name/,@partner.admin_info.full_name).gsub(/@email/,@partner.admin_info.email)
  end
  @bus_site.admin_console_page.account_details_section.wait_until_bus_section_load
  @bus_site.admin_console_page.account_details_section.acc_details_desc_columns.should == acc_details_table.hashes.map{ |row| row[:description] }
  @bus_site.admin_console_page.account_details_section.acc_details_value_columns.should == acc_details_table.hashes.map{ |row| row[:value] }
end

Then /^I set account Receive Mozy Account Statements option to (Yes|No)$/ do |status|
  step "I navigate to Account Details section from bus admin console page"
  @bus_site.admin_console_page.account_details_section.wait_until_bus_section_load
  @bus_site.admin_console_page.account_details_section.set_receive_statement_status(status)
end

Then /^Account statement preference should be changed$/ do
  @bus_site.admin_console_page.account_details_section.messages.should == "Successfully saved Account Statement preference."
end

Then /^I change the display name to (.+)/ do |display_name|
  @bus_site.admin_console_page.account_details_section.edit_display_name(display_name)
end

Then /^I change the username to (.+)$/ do  |username|
  @bus_site.admin_console_page.account_details_section.edit_username(username)
end

Then /^Account Details error message should be:$/ do |messages|
  @bus_site.admin_console_page.account_details_section.messages.should == messages.to_s
end

Then /^(.+) changed success message should be displayed$/ do |changes|
  case changes
    when 'username'
      @bus_site.admin_console_page.account_details_section.messages.should == "Email address updated successfully"
    when 'display name'
      @bus_site.admin_console_page.account_details_section.messages.should == "Name updated successfully"
  end
end
