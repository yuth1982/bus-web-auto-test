When /^I order data shuttle for (.+)$/ do |search_key|
  step "I navigate to Order Data Shuttle view from bus admin console page"
  @bus_admin_console_page.order_data_shuttle_view.search_partner(search_key)
  @bus_admin_console_page.order_data_shuttle_view.process_order(search_key)
end

When /^I order a (available|new) key with (.+) power adapter, (Win|Mac) OS, (\d+) GB quota, assigned to (.+), (\d+) discount, (\d+) win drivers, (\d+) mac drivers, (ship|no ship) drivers$/ do |from, adapter_type, os, quota, assign_to, discount, win_drivers, mac_drivers, is_ship|
  assign_to = assign_to.include?("@") ? assign_to : ""
  is_ship = is_ship.eql?("ship") ? true : false
  @order = Bus::DataShuttleOrder.new(adapter_type, os, quota, assign_to, from, discount, win_drivers, mac_drivers, is_ship)
  @bus_admin_console_page.process_order_view.create_order(@order)
end

When /^I order a (available|new) key with (.+) power adapter, (Win|Mac) OS, (\d+) GB quota, assigned to (.+), (\d+) discount$/ do |from, adapter_type, os, quota, assign_to, discount|
  step "I order a #{from} key with #{adapter_type} power adapter, #{os} OS, #{quota} GB quota, assigned to #{assign_to}, #{discount} discount, 1 win drivers, 0 mac drivers, ship drivers"
end

When /^Verify shipping address table should match:$/ do |address_table|
  @bus_admin_console_page.process_order_view.address_desc_column_text.should == address_table.rows.map{ |row| row.first}
  @bus_admin_console_page.process_order_view.shipping_address_text.should == address_table.rows.map{ |row| row[1]}
end

When /^I go to next section without select power adapter in verify shipping address section$/ do
  @bus_admin_console_page.process_order_view.go_to_create_order_section
end

Then /^Order data shuttle error message should match: (.+)$/ do |err_message|
  @bus_admin_console_page.process_order_view.message_text.should match(err_message)
end

Then /^Order data shuttle successful message should match: Data Shuttle Device for Pro Partner (.+) created\.$/ do |company_name|
  @bus_admin_console_page.process_order_view.message_text.should == "Data Shuttle Device for Pro Partner #{company_name} created."
end

Then /^Data shuttle order summary should match:$/ do |summary_table|
  @bus_admin_console_page.process_order_view.order_summary_tb_rows_text.should == summary_table.rows
end

When /^I search data shuttle order by (.+)$/ do |company_name|
  @bus_admin_console_page.refresh_page
  step "I navigate to View Data Shuttle Orders view from bus admin console page"
  @bus_admin_console_page.view_data_shuttle_orders_view.search_order(company_name)
  @bus_admin_console_page.view_data_shuttle_orders_view.view_latest_order
end

When /^I cancel the latest data shuttle order$/ do
  @bus_admin_console_page.order_details_view.cancel_latest_order
end

Then /^The latest order status should be (.+)$/ do |status|
  @bus_admin_console_page.order_details_view.latest_order_status_text == status
end

Then /^The number of driver in shipping tracking table should be (\d+)$/ do |num_drivers|
  @bus_admin_console_page.order_details_view.shipping_tracking_tb_rows_text.length.should == num_drivers.to_i
end