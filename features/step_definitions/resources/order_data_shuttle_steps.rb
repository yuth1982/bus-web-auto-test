
#
# | key type  | power adapter   | os  | quota | assign to | discount | win drivers | mac drivers | ship driver |

When /^I order data shuttle for (.+)$/ do |company_name, order_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['order_data_shuttle'])
  @bus_site.admin_console_page.order_data_shuttle_section.search_partner(company_name)
  @bus_site.admin_console_page.order_data_shuttle_section.view_order_detail(company_name)

  attributes = order_table.hashes.first
  @order = Bus::DataObj::DataShuttleOrder.new
  @order.adapter_type = attributes["power adapter"]
  @order.key_from = attributes["key from"]
  @order.os = attributes["os"] || "Win"
  @order.quota = attributes["quota"]
  @order.assign_to = attributes["assign to"]
  @order.discount = attributes["discount"]
  @order.num_win_drivers = attributes["win drivers"]
  @order.num_mac_drivers = attributes["mac drivers"]
  @order.ship_driver = attributes["ship driver"]
  @bus_site.admin_console_page.process_order_section.create_order(@order)
 end

Then /^Verify shipping address table should be:$/ do |address_table|
  @bus_site.admin_console_page.process_order_section.address_desc_columns.should == address_table.rows.map{ |row| row.first}
  @bus_site.admin_console_page.process_order_section.shipping_address.should == address_table.rows.map{ |row| row[1]}
end

When /^I navigate to process data shuttle order section for (.+)$/ do |company_name|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['order_data_shuttle'])
  @bus_site.admin_console_page.order_data_shuttle_section.search_partner(company_name)
  @bus_site.admin_console_page.order_data_shuttle_section.view_order_detail(company_name)
end

Then /^Order data shuttle message should be (.+)$/ do |messages|
  @bus_site.admin_console_page.process_order_section.messages.gsub(/\n/," ").should == messages
end

Then /^Data shuttle order should be created$/ do
  @bus_site.admin_console_page.process_order_section.messages.should match(/Data Shuttle Device for Pro Partner (.+) created./)
end

Then /^Data shuttle order summary should be:$/ do |summary_table|
  @bus_site.admin_console_page.process_order_section.order_summary_table_rows.should == summary_table.rows
end

When /^I cancel the latest data shuttle order for (.+)$/ do |account_name|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['view_data_shuttle_orders'])
  @bus_site.admin_console_page.view_data_shuttle_orders_section.search_order(account_name)
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
      raise "Please choose Win os or Mac os"
  end
end