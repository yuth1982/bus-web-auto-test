module Bus
  # This class provides actions for billing information section
  class BillingInfoSection < SiteHelper::Section

    # Private elements
    #
    element(:change_subscription_link, css: "a[href='/resource/change_billing_period']")

    element(:vat_info_table, css: 'div[id^=partner-billing-info-vat-] table')

    # All tables in Billing Information section, including Next Renewal, Supplemental Plan, Autogrow
    elements(:tables, css: 'div#resource-billing-content table')

    # Public: Click change link
    #
    # Returns nothing
    def go_to_change_period_section
      change_subscription_link.click
    end

    # Public: Next renewal table rows text
    #
    # Example
    #  @bus_admin_console_page.billing_info_section.next_renewal_table_rows
    #  # => [["Period", "Date", "Amount", "Payment Type"],
    #        ["monthly (change)", "Jul 30, 2013", "$39.99 (Without taxes or discounts)", "Visa ending in 7014 (change)"]]
    #
    # Returns transposed next renewal table rows array
    def next_renewal_table_rows
      wait_until_bus_section_load
      tables.first.rows_text.transpose
    end

    # Public: Next renewal hashes
    #         Converts results table into an Array of Hash where the keys of each Hash are the headers in the table.                                                                                               # Example
    #
    #  @bus_admin_console_page.billing_info_section.next_renewal_hashes
    #
    # Returns hash array
    def next_renewal_hashes
      next_renewal_table_rows[1..-1].map{ |row| Hash[*next_renewal_table_rows[0].zip(row).flatten] }
    end

    # Public: Supplemental plan table rows text
    # *This method requires refactor
    #
    # There's no identification for supplemental plan table, therefore, when a partner has VAT info, tables[1] will return wrong information.
    # Also each supplemental plan displays in its own table, this is difficult to locate all supplemental plans
    #
    # Example
    #
    #  @bus_admin_console_page.billing_info_section.supp_plan_table_rows
    #  # => [["Number purchased", "Price each", "Total price for GB - Silver Reseller"],
    #        ["100", "$0.42", "$42.00"]]
    #
    # Returns transposed supplemental table rows array of first supplemental plan
    def supp_plan_table_rows
      wait_until_bus_section_load
      tables[1].rows_text.transpose
    end

    # Public: Supplemental plan hashes
    #         Converts results table into an Array of Hash where the keys of each Hash are the headers in the table.                                                                                               # Example
    #
    #  @bus_admin_console_page.billing_info_section.supp_plan_hashes
    #
    # Returns hash array
    def supp_plan_hashes
      supp_plan_table_rows[1..-1].map{ |row| Hash[*supp_plan_table_rows[0].zip(row).flatten] }
    end

    # Public: Vat table rows text
    #
    # Example
    #  @bus_admin_console_page.billing_info_section.vat_table_rows
    #  # => [["VAT Number"],
    #        ["BE0883236072"]]
    #
    # Returns VAT table rows array
    def vat_table_rows
      vat_info_table.rows_text.delete_if{ |row|row.size!=2 }.transpose
    end

    # Public: VAT info hashes
    #         Converts results table into an Array of Hash where the keys of each Hash are the headers in the table.                                                                                               # Example
    #
    #  @bus_admin_console_page.billing_info_section.vat_hashes
    #
    # Returns hash array
    def vat_hashes
      vat_table_rows[1..-1].map{ |row| Hash[*vat_table_rows[0].zip(row).flatten] }
    end

    # Public: Autogrow table rows
    #
    # Example
    #
    #  @bus_admin_console_page.billing_info_section.autogrow_table_rows
    #  # => [["Autogrow"],
    #        [""Disabled (more info)""]]
    #
    # Returns the auto grow status text
    def autogrow_table_rows
      wait_until_bus_section_load
      tables.last.rows_text.transpose
    end

    # Public: Autogrow hashes
    #         Converts results table into an Array of Hash where the keys of each Hash are the headers in the table.                                                                                               # Example
    #
    #  @bus_admin_console_page.billing_info_section.autogrow_hashes
    #
    # Returns hash array
    def autogrow_hashes
      wait_until_bus_section_load
      tables.last.hashes
    end
  end
end