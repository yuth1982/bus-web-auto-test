module Bus
  # This class provides actions for order details page section
  class OrderDetailsSection < SiteHelper::Section

    # Private elements
    #
    elements(:cancel_order_links, link: "cancel")
    elements(:order_detail_tables, xpath: "//div[starts-with(@id,'resource-show_data_shuttle_order-') and contains(@id, '-content')]//table")

    # Public: Click cancel button of first order in list
    #
    # Example
    #   @bus_admin_console_page.order_details_section.cancel_latest_order
    #
    # Returns nothing
    def cancel_latest_order
      cancel_order_links.first.click
    end

    # Public: Shipping tracking table rows text
    #
    # Example
    #   @bus_admin_console_page.order_details_section.shipping_tracking_table_rows
    #   # => [["1","","","Error"]]
    #
    # Returns Shipping tracking table rows text
    def shipping_tracking_table_rows
      order_detail_tables[1].rows_text
    end

    # Public: Last created order status
    #
    # Example
    #   @bus_admin_console_page.order_details_section.latest_order_status
    #   # => "Ordered"
    #
    # Returns status text
    def latest_order_status
      orders_table.rows.first[1].text
    end

    private

    def orders_table
      order_detail_tables[0]
    end
  end
end