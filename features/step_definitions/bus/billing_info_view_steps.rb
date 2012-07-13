
When /^I change subscription up to (.+)$/ do |link_text|
  step "I navigate to billing information view"
  step "I navigate to change subscription view"
  @bus_admin_console_page.billing_info_view.change_subscription_up(link_text)
end

When /^I change subscription down to (.+)$/ do |link_text|
  step "I navigate to billing information view"
  step "I navigate to change subscription view"
  @bus_admin_console_page.billing_info_view.change_subscription_down(link_text)
end

Then /^Change subscription confirmation message should include (.+)$/ do |message|
  @bus_admin_console_page.billing_info_view.change_confirmation_div.text.should include(message)
end

Then /^Subscription changed message should be (.+)$/ do |message|
  @bus_admin_console_page.billing_info_view.change_status_txt.text.should == message
end

Then /^The subscription period should change to (\w+)$/ do |period|
  @bus_admin_console_page.refresh_page
  @bus_admin_console_page.billing_information.click
  @bus_admin_console_page.billing_info_view.period_span.text.downcase.should == period.downcase
end

Then /^Next Renewal text align is set to left justify$/ do
  @bus_admin_console_page.billing_info_view.next_renewal_h4.style("text-align").should == "start"
end

Then /^Autogrow status text's should be (.+)$/ do |value|
  @bus_admin_console_page.billing_info_view.autogrow_status_td.text.should == value
end

Then /^Next renewal supplemental plan details should be:$/ do |plan_table|
  @bus_admin_console_page.billing_info_view.supplemental_plan_table.body_rows_text.should == plan_table.hashes.map { |el| el.values }
end

Then /^Next renewal master plan period should be (.+)$/ do |period|
  @bus_admin_console_page.billing_info_view.master_plan_table.body_rows_text[0][1].should == period
end

Then /^Next renewal master plan date should be (.+)$/ do |date|
  # Set Time.now mto qa6 local time
  next_month = DateTime.now >> date.match(/(\d+)/).to_s.to_i
  @bus_admin_console_page.billing_info_view.master_plan_table.body_rows_text[1][1].should == next_month.to_time.localtime("-06:00").strftime("%b %d, %Y")
end

Then /^Next renewal master plan amount should be (.+)$/ do |amount|
  @bus_admin_console_page.billing_info_view.master_plan_table.body_rows_text[2][1].should == amount
end

Then /^Next renewal master plan payment type should be (.+)$/ do |type|
  @bus_admin_console_page.billing_info_view.master_plan_table.body_rows_text[3][1].should == type.gsub(/XXXX/, @partner.credit_card_number[12..-1])
end