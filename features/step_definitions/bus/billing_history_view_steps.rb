
Then /^Billing history table should be:$/ do |billing_table|
  billing_table.map_column!('Date') do |value|
    value.gsub(/@today/,Time.now.strftime("%m/%d/%y")) #localtime("-06:00")
  end
  @bus_admin_console_page.billing_history_view.billing_history_tb_header_text.should == billing_table.headers
  @bus_admin_console_page.billing_history_view.billing_history_tb_rows_text.should == billing_table.rows
end
