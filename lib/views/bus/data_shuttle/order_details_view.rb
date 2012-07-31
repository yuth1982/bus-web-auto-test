module Bus
  # This class provides actions for order details view
  class OrderDetailsView < PageObject

    # Private elements
    #
    elements(:cancel_order_links, {:link => "cancel"})

    def cancel_latest_order
      cancel_order_links.first.click
    end

    def tables
      driver.find_element(:xpath, "//h3[contains(text(), 'Target Data Center:')]").parent.parent.find_elements(:tag_name,"table")
    end

    def orders_table
      tables[0]
    end

    def shipping_tracking_tb_rows_text
      tables[1].body_rows_text
    end

    def latest_order_status_text
      orders_table.body_rows.first[1].text
    end
  end
end