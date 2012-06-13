
Then /^The number of statements in billing history view should be (\d+)$/ do |number|
  @bus_admin_console_page.billing_history_view.billing_statements.length.to_s.should == number
end

Then /^The statements table header in billing history view should be (.+)$/ do |header|
  @bus_admin_console_page.billing_history_view.billing_statements_table_head.should == header
end

Then /^The statements in billing history view should be (.+)$/ do |statement|
  @bus_admin_console_page.billing_history_view.billing_statements.first.should == statement
end

Then /^The statements in billing history view should match a pattern$/ do
  @bus_admin_console_page.billing_history_view.billing_statements.should match(/\d{2}\/\d{2}\/\d{2} \$\d+.\d+ \$\d+.\d+ \$0.00+ \d+/)
end

Then /^I view the top one invoice in billing history view$/ do
  @bus_admin_console_page.billing_history_view.top_one_invoice_link.click
end
