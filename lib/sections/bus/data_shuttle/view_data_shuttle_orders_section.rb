module Bus
  # This class provides actions for view data shuttle orders view
  class ViewDataShuttleOrdersSection < PageObject

    # Private elements
    #
    element(:search_order_tb, {:id => "seed_device_order_search"})
    element(:search_order_btn, {:xpath => "//div[@id='resource-view_seed_device_orders-content']//input[@value='Submit']"})
    element(:order_results_table, {:xpath => "//div[@id='resource-view_seed_device_orders-content']//table[@class='table-view']"})

    # Public: Search data shuttle order
    #
    # Examples
    #
    #  @bus_admin_console_page.view_data_shuttle_orders_section.search_order("Lego Company")
    #
    # Returns Nothing
    def search_order(company_name)
      search_order_tb.type_text(company_name)
      search_order_btn.click
    end

    # Public: Click to view latest created data shuttle order in list
    #
    # Examples
    #
    #  @bus_admin_console_page.view_data_shuttle_orders_section.view_latest_order
    #
    # Returns Nothing
    def view_latest_order
      sleep 5 # wait until search complete
      order_results_table.body_rows.first[0].find_element(:tag_name, "a").click
    end
  end
end