
Then /^Account details table should be:$/ do |acc_details_table|
  acc_details_table.map_column!('value') do |value|
    value.gsub(/@name/,@partner.admin_info.full_name).gsub(/@email/,@partner.admin_info.email)
  end
  @bus_admin_console_page.account_details_section.acc_details_desc_column_text.should == acc_details_table.hashes.map{ |row| row[:description] }
  @bus_admin_console_page.account_details_section.acc_details_value_column_text.should == acc_details_table.hashes.map{ |row| row[:value] }
end

Then /^I set account Receive Mozy Account Statements option to (Yes|No)$/ do |status|
  step "I navigate to Account Details section from bus admin console page"
  @bus_admin_console_page.account_details_section.set_receive_statement_status(status)
end

Then /^Account statement preference should be changed$/ do
  @bus_admin_console_page.account_details_section.message_text.should == "Successfully saved Account Statement preference."
end
