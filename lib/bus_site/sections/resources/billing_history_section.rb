module Bus
  # This class provides actions for billing history section
  class BillingHistorySection < SiteHelper::Section

    # Private elements
    #
    element(:export_to_excel_link, link: "Export to Excel (CSV)")
    element(:bill_history_h3, xpath: "//h3[text()='Billing History']")
    element(:billing_history_table, xpath: "//div[@id='resource-all_charges-content']//table[@class='table-view']")

    # Public: billing history table header rows text
    #
    # Example
    #
    #   @bus_admin_console_page.billing_history_section.billing_history_table_header
    #   # => ["Date", "Amount", "Total Paid", "Balance Due"]
    #
    # Returns the billing history table header row text array
    def billing_history_table_headers
      billing_history_table.headers_text
    end

    # Public: billing history table body rows text
    #
    # Example
    #
    #   @bus_admin_console_page.billing_history_section.billing_history_table_header
    #   # => [["07/30/12", "$439.89", "$439.89", "$0.00"], ["07/31/12", "95.00", "95.00", "$0.00"]]
    #
    # Returns the billing history table body rows text array
    def billing_history_table_rows
      billing_history_table.rows_text
    end
  end
end