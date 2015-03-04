Then /^I get the data shuttle seed id$/ do
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['view_data_shuttle_orders'])
  @bus_site.admin_console_page.view_data_shuttle_orders_section.search_order(@partner.company_info.name)

  @seed_id = @bus_site.admin_console_page.view_data_shuttle_orders_section.top_seed_id
  Log.debug("seed id is #{@seed_id}")
end

Then /^I search order in view data shuttle orders section by (.+)$/ do |keywords|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['view_data_shuttle_orders'])
  @bus_site.admin_console_page.view_data_shuttle_orders_section.search_order(keywords)
  @order_search_table = @bus_site.admin_console_page.view_data_shuttle_orders_section.order_results_hashes[0]
end


Then /^order search results in data shuttle orders section should be:$/ do |orders_table|
  actual = @order_search_table
  expected = orders_table.hashes[0]
  expected.keys.each{|key| actual[key].should == expected[key]}
end

Then /^the data shuttle order details should contain valid inbound number$/ do
  @bus_site.admin_console_page.view_data_shuttle_orders_section.view_latest_order
  @ship_table = @bus_site.admin_console_page.order_details_section.shipping_tracking_table_rows[0]
  @status = @ship_table[3]
  @inbound_number = @ship_table[2]
  @status.should == 'Shipped'
  @inbound_number.should_not be_nil
  @bus_site.admin_console_page.order_details_section.has_inbound_link?(@inbound_number).should == true
  Log.debug("ship status is #{@status}, inbound number is #{@inbound_number}")
end

When /^I view data shuttle order details$/ do
  @bus_site.admin_console_page.view_data_shuttle_orders_section.view_latest_order
end

When /^I add drive to data shuttle order$/ do
  @bus_site.admin_console_page.order_details_section.add_drive_to_order
end

Then /^Add drive to data shuttle order message should include (.+)$/ do |messages|
  @bus_site.admin_console_page.order_details_section.messages.include?(messages).should be_true
end
