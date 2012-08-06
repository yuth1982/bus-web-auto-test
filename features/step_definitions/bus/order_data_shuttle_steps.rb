
#
# | key type  | power adapter   | os  | quota | assign to | discount | win drivers | mac drivers | ship driver |

When /^I order data shuttle for (.+)$/ do |account, order_table|
  step "I navigate to Order Data Shuttle section from bus admin console page"
  @bus_admin_console_page.order_data_shuttle_section.search_partner(account[:company_name])
  @bus_admin_console_page.order_data_shuttle_section.view_order_detail(account[:company_name])

  attributes = order_table.hashes.first
  @order = Bus::DataObj::DataShuttleOrder.new
  @order.adapter_type = attributes["power adapter"] unless attributes["power adapter"].nil?
  @order.key_from = attributes["key from"] # required
  @order.os = attributes["os"] || "Win"
  @order.quota = attributes["quota"] || 2
  @order.assign_to = attributes["assign to"].gsub(/@email/,@partner.admin_info.email) unless attributes["assign to"].nil?
  @order.discount = attributes["discount"] || 0
  @order.num_win_drivers = attributes["win drivers"].to_i unless attributes["win drivers"].nil?
  @order.num_mac_drivers = attributes["mac drivers"].to_i unless attributes["mac drivers"].nil?
  @order.ship_driver = attributes["ship driver"].eql?("yes") || false unless attributes["ship driver"].nil?
  @bus_admin_console_page.process_order_section.create_order(@order)
 end

When /^Verify shipping address table should be:$/ do |address_table|
  @bus_admin_console_page.process_order_section.address_desc_column_text.should == address_table.rows.map{ |row| row.first}
  @bus_admin_console_page.process_order_section.shipping_address_text.should == address_table.rows.map{ |row| row[1]}
end

When /^I navigate to process data shuttle order section for (.+)$/ do |account|
  step "I navigate to Order Data Shuttle section from bus admin console page"
  @bus_admin_console_page.order_data_shuttle_section.search_partner(account[:company_name])
  @bus_admin_console_page.order_data_shuttle_section.view_order_detail(account[:company_name])
end

When /^I go to next section without select power adapter in verify shipping address section$/ do
  @bus_admin_console_page.process_order_section.go_to_create_order_section
end

Then /^Order data shuttle error message should be (.+)$/ do |err_message|
  @bus_admin_console_page.process_order_section.message_text.should == err_message
end

Then /^Data shuttle order should be created$/ do
  @bus_admin_console_page.process_order_section.message_text.should match(/Data Shuttle Device for Pro Partner (.+) created./)
end

Then /^Data shuttle order summary should be:$/ do |summary_table|
  @bus_admin_console_page.process_order_section.order_summary_tb_rows_text.should == summary_table.rows
end


When /^I cancel the latest data shuttle order for (.+)$/ do |account|
  @bus_admin_console_page.refresh_page
  step "I navigate to View Data Shuttle Orders section from bus admin console page"
  @bus_admin_console_page.view_data_shuttle_orders_section.search_order(account[:company_name])
  @bus_admin_console_page.view_data_shuttle_orders_section.view_latest_order
  @bus_admin_console_page.order_details_section.cancel_latest_order
end

Then /^The order should be (.+)$/ do |status|
  @bus_admin_console_page.order_details_section.latest_order_status_text == status
end

Then /^The number of (win|mac) drivers should be (\d+)$/ do |type, num_drivers|
  case type
    when "win"
      @bus_admin_console_page.process_order_section.num_win_driver_ordered.should == num_drivers
    when "mac"
      @bus_admin_console_page.process_order_section.num_mac_driver_ordered.should == num_drivers
    else

  end
end