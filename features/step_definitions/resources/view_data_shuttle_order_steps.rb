Then /^I get the data shuttle seed id$/ do
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['view_data_shuttle_orders'])
  @bus_site.admin_console_page.view_data_shuttle_orders_section.search_order(@partner.company_info.name)

  @seed_id = @bus_site.admin_console_page.view_data_shuttle_orders_section.top_seed_id
  Log.debug("seed id is #{@seed_id}")
end
