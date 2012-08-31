
When /^I change account subscription up to (.+) period$/ do |link_text|
  @bus_site.admin_console_page.navigate_to_link("Billing Information")
  @bus_site.admin_console_page.billing_info_section.go_to_change_period_section
  @bus_site.admin_console_page.change_period_section.change_subscription_up(link_text)
end

When /^I change account subscription down to (.+) period$/ do |link_text|
  @bus_site.admin_console_page.navigate_to_link("Billing Information")
  @bus_site.admin_console_page.billing_info_section.go_to_change_period_section
  @bus_site.admin_console_page.change_period_section.change_subscription_down(link_text)
end

Then /^Change subscription confirmation message should be:$/ do |message|
  @bus_site.admin_console_page.change_period_section.confirmations.join(" ").should == message.to_s.gsub(/\n/," ")
end

Then /^Change subscription price table should be:$/ do |price_table|
  @bus_site.admin_console_page.change_period_section.price_table_headers.should == price_table.headers
  @bus_site.admin_console_page.change_period_section.price_table_rows.should == price_table.rows
end

Then /^Subscription changed message should be (.+)$/ do |message|
  @bus_site.admin_console_page.change_period_section.messages.should == message
end