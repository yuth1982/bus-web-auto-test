
When /^I change subscription up to (.+)$/ do |link_text|
  step "I navigate to billing information view"
  step "I navigate to change subscription view"
  @bus_admin_console_page.change_period_view.change_subscription_up(link_text)
end

When /^I change subscription down to (.+)$/ do |link_text|
  step "I navigate to billing information view"
  step "I navigate to change subscription view"
  @bus_admin_console_page.change_period_view.change_subscription_down(link_text)
end

Then /^Change subscription confirmation message should include (.+)$/ do |message|
  @bus_admin_console_page.change_period_view.change_confirmation_div.text.should include(message)
end

Then /^Change subscription price table should be:$/ do |price_table|
  @bus_admin_console_page.change_period_view.price_table.header_row_text.should == price_table.headers
  @bus_admin_console_page.change_period_view.price_table.body_rows_text.should == price_table.rows
end

Then /^Subscription changed message should be (.+)$/ do |message|
  @bus_admin_console_page.change_period_view.message_div.text.should == message
end