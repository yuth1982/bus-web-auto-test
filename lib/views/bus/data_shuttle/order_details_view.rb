module Bus
  # This class provides actions for order details view
  class OrderDetailsView < PageObject

    # Private elements
    #
    elements(:cancel_order_links, {:link => "cancel"})
    elements(:order_detail_tables, {:xpath => "//div[starts-with(@id,'resource-show_data_shuttle_order-') and contains(@id, '-content')]//table"})

    # Public: Click cancel button of first order in list
    #
    # Example
    #   @bus_admin_console_page.order_details_view.cancel_latest_order
    #
    # Returns nothing
    def cancel_latest_order
      cancel_order_links.first.click
    end

    # Public: Shipping tracking table rows text
    #
    # Example
    #   @bus_admin_console_page.order_details_view.shipping_tracking_tb_rows_text
    #   # => [["1","","","Error"]]
    #
    # Returns Shipping tracking table rows text
    def shipping_tracking_tb_rows_text
      order_detail_tables[1].body_rows_text
    end

    # Public: Last created order status
    #
    # Example
    #   @bus_admin_console_page.order_details_view.latest_order_status_text
    #   # => "Ordered"
    #
    # Returns status text
    def latest_order_status_text
      orders_table.body_rows.first[1].text
    end

    private

    def orders_table
      order_detail_tables[0]
    end
  end
end