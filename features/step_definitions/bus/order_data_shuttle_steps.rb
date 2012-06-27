When /^I order data shuttle for (.+)$/ do |search_key|
  @bus_admin_console_page.order_data_shuttle_view.search_partner(search_key)
  @bus_admin_console_page.order_data_shuttle_view.view_order_detail(search_key)
end


When /^I add a new key of (\d+) GB quota, assigned to (.+)$/ do |quota, email|
  @bus_admin_console_page.order_data_shuttle_view.power_adapter_select.select_by(:text, "Data Shuttle US")
  sleep 5
  @bus_admin_console_page.order_data_shuttle_view.verify_address_next.click
  @bus_admin_console_page.order_data_shuttle_view.order_keys_table
  sleep 20

  @bus_admin_console_page.order_data_shuttle_view.add_new_key.click
  sleep 20

  @bus_admin_console_page.order_data_shuttle_view.order_quota.type_text("20")
  @bus_admin_console_page.order_data_shuttle_view.order_assign_to.type_text("qa1+data+shuttle@mozy.com")

  sleep 20
end
