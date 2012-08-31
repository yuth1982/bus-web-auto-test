module Bus
  # This class provides actions for billing information section
  class BillingInfoSection < SiteHelper::Section

    # Constants
    #
    BILLING_INFO_LOC = "resource-billing-content"

    # Private elements
    #
    element(:next_renewal_h4, xpath: "//div[@id='#{BILLING_INFO_LOC}']/div[1]/h4")
    element(:change_subscription_link, link: "(change)")
    element(:autogrow_status_th, xpath: "//th[text()='Status']")
    elements(:next_renewal_tds, xpath: "//div[@id='#{BILLING_INFO_LOC}']/div/table[@class='info-table']//td")
    element(:vat_info_table, xpath: "//div[starts-with(@id,'partner-billing-info-vat-')]/table")
    elements(:tables, xpath: "//div[@id='#{BILLING_INFO_LOC}']//table")

    # Public: Click change link
    #
    # Returns nothing
    def go_to_change_period_section
      change_subscription_link.click
    end

    # Public: Next renewal table rows text in billing information view
    #
    # Example
    #
    #  @bus_admin_console_page.billing_info_section.next_renewal_table_rows
    #  # => [["Period", "monthly (change)"],
    #        ["Date", "Jul 30, 2013"],
    #        ["Amount", "$39.99 (Without taxes or discounts)"],
    #        ["Payment Type", "Visa ending in 7014 (change)"]]
    #
    # Returns next renewal table rows text array
    def next_renewal_table_rows
      tables[0].rows_text
    end

    # Public: Supplemental table rows text in billing information view
    #
    # Example
    #
    #  @bus_admin_console_page.billing_info_section.supp_plan_table_rows
    #  # => [["Total price for 50 GB", "$19.99"]]
    #
    # Returns supplemental table rows text array
    def supp_plan_table_rows
      tables[1].rows_text
    end

    # Public: Vat table rows text in billing information view
    #
    # Example
    #
    #  @bus_admin_console_page.billing_info_section.vat_table_rows
    #  # => [["VAT Number", "BE0883236072"]]
    #
    #
    # Returns next renewal table rows text array
    def vat_table_rows
      vat_info_table.rows_text
    end

    # Public: Auto grow status text in billing information view
    #
    # Example
    #
    #  @bus_admin_console_page.billing_info_section.autogrow_status_text
    #  # => "Disabled (more info)"
    #
    # Returns the auto grow status text
    def autogrow_status
      autogrow_status_th.next_sibling.text
    end

  end
end