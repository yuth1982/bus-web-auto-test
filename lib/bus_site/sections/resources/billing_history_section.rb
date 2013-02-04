module Bus
  # This class provides actions for billing history section
  class BillingHistorySection < SiteHelper::Section

    # Private elements
    #
    element(:export_to_excel_link, link: "Export to Excel (CSV)")
    element(:bill_history_h3, xpath: "//h3[text()='Billing History']")
    element(:billing_history_table, xpath: "//div[@id='resource-all_charges-content']//table[@class='table-view']")

    # Public: Billing history hashes
    #         Converts results table into an Array of Hash where the keys of each Hash are the headers in the table.                                                                                               # Example
    #
    #  @bus_admin_console_page.billing_history_section.billing_history_hashes
    #
    # Returns hash array
    def billing_history_hashes
      billing_history_table.rows_text.map{ |row| Hash[*billing_history_table.headers_text.zip(row).flatten] }
    end
  end
end