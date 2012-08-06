
When /^I change account subscription up to (.+)$/ do |link_text|
  step "I navigate to Billing Information section from bus admin console page"
  @bus_admin_console_page.billing_info_section.go_to_change_period_section
  @bus_admin_console_page.change_period_section.change_subscription_up(link_text)
end

When /^I change account subscription down to (.+)$/ do |link_text|
  step "I navigate to Billing Information section from bus admin console page"
  @bus_admin_console_page.billing_info_section.go_to_change_period_section
  @bus_admin_console_page.change_period_section.change_subscription_down(link_text)
end

Then /^Change subscription confirmation message should be:$/ do |message_table|
  @bus_admin_console_page.change_period_section.confirmation_text.should == message_table.rows.flatten
end

Then /^Change subscription price table should be:$/ do |price_table|
  @bus_admin_console_page.change_period_section.price_tb_headers_text.should == price_table.headers
  @bus_admin_console_page.change_period_section.price_tb_rows_text.should == price_table.rows
end

Then /^Subscription changed message should be (.+)$/ do |message|
  @bus_admin_console_page.change_period_section.message_text.should == message
end