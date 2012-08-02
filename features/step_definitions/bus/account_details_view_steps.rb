
Then /^Account details table should be:$/ do |acc_details_table|
  acc_details_table.map_column!('value') do |value|
    value.gsub(/@name/,@partner.admin_info.full_name).gsub(/@email/,@partner.admin_info.email)
  end
  @bus_admin_console_page.account_details_section.acc_details_desc_column_text.should == acc_details_table.hashes.map{ |row| row[:description] }
  @bus_admin_console_page.account_details_section.acc_details_value_column_text.should == acc_details_table.hashes.map{ |row| row[:value] }
end

Then /^I set Receive Mozy Account Statements option to (Yes|No)$/ do |status|
  @bus_admin_console_page.account_details_section.set_receive_statement_status(status)
end

Then /^I should see setting saved message is (.+)$/ do |message|
  @bus_admin_console_page.account_details_section.message_text.should == message.to_s
end
