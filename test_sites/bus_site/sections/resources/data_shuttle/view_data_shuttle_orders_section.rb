module Bus
  # This class provides actions for view data shuttle orders page section
  class ViewDataShuttleOrdersSection < SiteHelper::Section

    # Private elements
    #
    element(:search_order_tb, id: "seed_device_order_search")
    element(:search_order_btn, css: "div#resource-view_seed_device_orders-content input[value=Submit]")
    element(:order_results_table, css: "div#resource-view_seed_device_orders-content table.table-view")

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
      wait_until_bus_section_load
      order_results_table.rows.first[0].find("a").click
    end

    def top_seed_id
      wait_until_bus_section_load
      order_results_table.rows.first[0].find("a").text
    end

    def order_results_hashes
      wait_until_bus_section_load
      order_results_table.rows_text.map{ |row| Hash[*order_results_table.headers_text.zip(row).flatten] }
    end

    def order_results_table_rows
      order_results_table.rows_text
    end

  end
end