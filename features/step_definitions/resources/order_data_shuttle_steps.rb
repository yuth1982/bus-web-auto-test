
#
# | key type  | power adapter   | os  | quota | assign to | discount | win drivers | mac drivers | ship driver |

When /^I order data shuttle for (.+)$/ do |account, order_table|
  step "I navigate to Order Data Shuttle section from bus admin console page"
  @bus_site.admin_console_page.order_data_shuttle_section.search_partner(account[:company_name])
  @bus_site.admin_console_page.order_data_shuttle_section.view_order_detail(account[:company_name])

  attributes = order_table.hashes.first
  @order = Bus::DataObj::DataShuttleOrder.new
  @order.adapter_type = attributes["power adapter"] || "Data Shuttle US"
  @order.key_from = attributes["key from"] || "new"
  @order.os = attributes["os"] || "Win"
  @order.quota = attributes["quota"] || 2
  @order.assign_to = (attributes["assign to"] || "").gsub(/@email/,@partner.admin_info.email)
  @order.discount = attributes["discount"] || 0
  @order.num_win_drivers = (attributes["win drivers"] || 0).to_i
  @order.num_mac_drivers = (attributes["mac drivers"] || 0).to_i
  @order.ship_driver = (attributes["ship driver"] || "yes").eql?("yes")
  @bus_site.admin_console_page.process_order_section.create_order(@order)
 end

Then /^Verify shipping address table should be:$/ do |address_table|
  address_table.map_column!('value') do |value|
    value.gsub(/@name/, @partner.admin_info.full_name).gsub(/@address/, @partner.company_info.address).gsub(/@city/,@partner.company_info.city).gsub(/@state/,@partner.company_info.state_abbrev).gsub(/@country/,@partner.company_info.country)
  end

  @bus_site.admin_console_page.process_order_section.address_desc_columns.should == address_table.rows.map{ |row| row.first}
  @bus_site.admin_console_page.process_order_section.shipping_address.should == address_table.rows.map{ |row| row[1]}
end

When /^I navigate to process data shuttle order section for (.+)$/ do |account|
  step "I navigate to Order Data Shuttle section from bus admin console page"
  @bus_site.admin_console_page.order_data_shuttle_section.search_partner(account[:company_name])
  @bus_site.admin_console_page.order_data_shuttle_section.view_order_detail(account[:company_name])
end

When /^I go to next section without select power adapter in verify shipping address section$/ do
  @bus_site.admin_console_page.process_order_section.go_to_create_order_section
end

Then /^Order data shuttle error message should be (.+)$/ do |err_message|
  @bus_site.admin_console_page.process_order_section.messages.should == err_message
end

Then /^Data shuttle order should be created$/ do
  @bus_site.admin_console_page.process_order_section.messages.should match(/Data Shuttle Device for Pro Partner (.+) created./)
end

Then /^Data shuttle order summary should be:$/ do |summary_table|
  @bus_site.admin_console_page.process_order_section.order_summary_table_rows.should == summary_table.rows
end


When /^I cancel the latest data shuttle order for (.+)$/ do |account|
  step "I navigate to View Data Shuttle Orders section from bus admin console page"
  @bus_site.admin_console_page.view_data_shuttle_orders_section.search_order(account[:company_name])
  @bus_site.admin_console_page.view_data_shuttle_orders_section.view_latest_order
  @bus_site.admin_console_page.order_details_section.cancel_latest_order
end

Then /^The order should be (.+)$/ do |status|
  @bus_site.admin_console_page.order_details_section.latest_order_status == status
end

Then /^The number of (win|mac) drivers should be (\d+)$/ do |type, num_drivers|
  case type
    when "win"
      @bus_site.admin_console_page.process_order_section.num_win_driver_ordered.should == num_drivers
    when "mac"
      @bus_site.admin_console_page.process_order_section.num_mac_driver_ordered.should == num_drivers
    else

  end
end