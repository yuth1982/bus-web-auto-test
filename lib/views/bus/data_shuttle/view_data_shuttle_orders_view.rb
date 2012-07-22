module Bus
  class ViewDataShuttleOrdersView < PageObject
    element(:search_order_tb, {:id => "seed_device_order_search"})
    element(:search_order_btn, {:xpath => "//div[@id='resource-view_seed_device_orders-content']//input[@value='Submit']"})
    element(:order_results_table, {:xpath => "//div[@id='resource-view_seed_device_orders-content']//table[@class='table-view']"})

    def search_order(company_name)
      search_order_tb.type_text(company_name)
      search_order_btn.click
    end

    def view_latest_order
      sleep 5 # wait until search complete
      order_results_table.body_rows.first[0].find_element(:tag_name, "a").click
    end
  end
end