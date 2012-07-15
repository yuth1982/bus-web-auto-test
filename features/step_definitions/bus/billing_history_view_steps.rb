
Then /^Billing history table should be:$/ do |billing_table|
  @bus_admin_console_page.billing_history_view.billing_history_table.header_row_text == billing_table.headers
  @bus_admin_console_page.billing_history_view.billing_history_table.body_rows_text == billing_table.rows
end
