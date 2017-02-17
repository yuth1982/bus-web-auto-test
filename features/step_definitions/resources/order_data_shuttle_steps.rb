
When /^I search partner in order data shuttle section by (.+)$/ do |keywords|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['order_data_shuttle'])
  @bus_site.admin_console_page.order_data_shuttle_section.search_partner(keywords)
end

When /^I clear partner search results in order data shuttle section$/ do
  @bus_site.admin_console_page.order_data_shuttle_section.clear_search
end

Then /^Partners search results in order data shuttle section should be:$/ do |partners_table|
  actual = @bus_site.admin_console_page.order_data_shuttle_section.search_results_hashes
  expected = partners_table.hashes
  expected.each do |col|
    col.each do |k,v|
      case k
        when 'Partner'
          v.gsub!(/@partner_name/, @partner.company_info.name) unless @partner.nil?
        when 'Created'
          v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
        when "Root Admin"
          v.gsub!(/@admin_email/, @partner.admin_info.email) unless @partner.nil?
        else
          # do nothing
      end
    end
  end
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

Then /^Partner search results in order data shuttle section should be empty$/ do
  rows = @bus_site.admin_console_page.order_data_shuttle_section.search_results_table_rows
  rows.to_s.include?('No results found.').should be_true
end

When /^I refresh order data shuttle section$/ do
  @bus_site.admin_console_page.order_data_shuttle_section.refresh_bus_section
end

When /^I collapse order data shuttle section$/ do
  @bus_site.admin_console_page.order_data_shuttle_section.collapse_bus_section
end

Then /^Partner search results in order data shuttle section should be invisible$/ do
  @bus_site.admin_console_page.order_data_shuttle_section.search_results_table_present?.should == false
end

#
# | key type  | power adapter   | os  | quota | assign to | discount | win drivers | mac drivers | ship driver |

When /^I (order|fill in) data shuttle for (.+)$/ do |type, company_name, order_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['order_data_shuttle'])
  @bus_site.admin_console_page.order_data_shuttle_section.search_partner(company_name)
  @bus_site.admin_console_page.order_data_shuttle_section.view_order_detail(company_name)

  cell = order_table.hashes.first
  @order = Bus::DataObj::DataShuttleOrder.new
  @order.name = cell['name'] || 'keep the same'
  @order.address_1 = cell['address 1'] || 'keep the same'
  @order.address_2 = cell['address 2'] || ''
  @order.city = cell['city'] || 'keep the same'
  @order.state = cell['state'] || 'keep the same'
  @order.country = cell['country']
  @order.zip = cell['zip'] || 'keep the same'
  @order.phone = cell['phone'] || 'keep the same'

  @order.adapter_type = cell['power adapter']
  @order.key_from = cell['key from']
  @order.os = cell['os'] || 'Win'
  @order.quota = cell['quota']
  @order.assign_to = cell['assign to']
  @order.discount = cell['discount']
  @order.num_win_drivers = cell['win drivers']
  @order.num_mac_drivers = cell['mac drivers']
  @order.ship_driver = cell['ship driver']
  @order.drive_type = cell['drive type']
  save = (type == 'order'? true : false)
  @bus_site.admin_console_page.process_order_section.create_order(@order, save)
end

And /^I input discount percentage value (\d+)$/ do |value|
  @bus_site.admin_console_page.process_order_section.input_discount(value)
end

When /^I click finish button$/ do
  @bus_site.admin_console_page.process_order_section.finish_data_shuttle_order
end

When /^I refresh process data shuttle section$/ do
  @bus_site.admin_console_page.process_order_section.refresh_bus_section
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

Then /^order data shuttle message should be:$/ do |messages|
  @bus_site.admin_console_page.process_order_section.messages.gsub(/\n/," ").should == messages
end

Then /^order data shuttle notification should be:$/ do |messages|
  @order.notification_msg.gsub(/\n/," ").should == messages
end

Then /^Order data shuttle message should include (.+)$/ do |messages|
  @bus_site.admin_console_page.process_order_section.messages.include?(messages).should be_true
end

Then /^Data shuttle order should be created$/ do
  @bus_site.admin_console_page.process_order_section.messages.should match(/Data Shuttle Device for Pro Partner (.+) created./)
end

Then /^Data shuttle order should (|not )have VAT fee$/ do |boolean|
  @bus_site.admin_console_page.process_order_section.wait_until_bus_section_load
  if (boolean == 'not ')
    @bus_site.admin_console_page.process_order_section.get_vat_fee_field.should be_false
  else
    @bus_site.admin_console_page.process_order_section.get_vat_fee_amount[1..-1].to_f.should > 0
  end
end

Then /^Data shuttle order summary should be:$/ do |summary_table|
  (@bus_site.admin_console_page.process_order_section.order_summary_table_rows.sort).should == (summary_table.rows).sort
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

