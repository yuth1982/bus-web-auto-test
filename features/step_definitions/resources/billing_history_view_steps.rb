
Then /^Billing history table should be:$/ do |billing_table|
  billing_table.map_column!('Date') do |value|
    value.gsub(/@today/,Time.now.localtime("-06:00").strftime("%m/%d/%y"))
  end
  @bus_site.admin_console_page.billing_history_section.billing_history_table_headers.should == billing_table.headers
  @bus_site.admin_console_page.billing_history_section.billing_history_table_rows.should == billing_table.rows
end
