
When /^I switch subscription to (.+)$/ do |link_text|
  step "I navigate to billing information view"
  step "I navigate to change subscription view"
  @bus_admin_console_page.billing_info_view.switch_subscription(link_text)
end

Then /^Subscription changed message should be (.+)$/ do |message|
  @bus_admin_console_page.billing_info_view.subscription_changed_txt.text.should == message
end

Then /^The subscription period should change to (\w+)$/ do |period|
  @bus_admin_console_page.refresh_page
  @bus_admin_console_page.billing_information.click
  @bus_admin_console_page.billing_info_view.period_span.text.downcase.should == period.downcase
end

Then /^Next Renewal (.+) property should set to (.+)$/ do |property, value|
  @bus_admin_console_page.billing_info_view.next_renewal_h4.style(property).should == value
end

Then /^Overdraft Protection (.+) property should set to (.+)$/ do |property, value|
  @bus_admin_console_page.billing_info_view.overdraft_status_th.style(property).should == value
end

Then /^Overdraft Protection status text's should be (.+)$/ do |value|
  @bus_admin_console_page.billing_info_view.overdraft_status_td.text.should == value
end

Then /^Partner can change their subscription period$/ do
  @bus_admin_console_page.billing_info_view.change_subscription_link.displayed?.should == true
end

Then /^Next renewal amount should be:$/ do |table|
  @bus_admin_console_page.billing_info_view.next_renewal_tds.map{ |el| el.text }.should == table.hashes.first.map{ |el| el.values }
end

Then /^Current plan price list should be:$/ do |price_table|
  @bus_admin_console_page.billing_info_view.plan_prices_tb.body_rows_text.should == price_table.hashes.map { |el| el.values }
end