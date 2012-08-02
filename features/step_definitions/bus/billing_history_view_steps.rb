
Then /^Billing history table should be:$/ do |billing_table|
  billing_table.map_column!('Date') do |value|
    value.gsub(/@today/,Time.now.localtime("-06:00").strftime("%m/%d/%y"))
  end
  @bus_admin_console_page.billing_history_section.billing_history_tb_header_text.should == billing_table.headers
  @bus_admin_console_page.billing_history_section.billing_history_tb_rows_text.should == billing_table.rows
end
