module Bus
  # This class provides actions for billing information view
  class BillingInfoView < PageObject

    # Constants
    #
    BILLING_INFO_LOC = "resource-billing-content"

    # Private elements
    #
    element(:next_renewal_h4, {:xpath =>"//div[@id='#{BILLING_INFO_LOC}']/div[1]/h4"})
    element(:change_subscription_link, {:link => "(change)"})
    element(:autogrow_status_th, {:xpath =>"//th[text()='Status']"})
    elements(:next_renewal_tds, {:xpath => "//div[@id='#{BILLING_INFO_LOC}']/div/table[@class='info-table']//td"})
    element(:vat_info_table, {:xpath => "//div[starts-with(@id,'partner-billing-info-vat-')]/table"})
    elements(:tables, {:xpath => "//div[@id='#{BILLING_INFO_LOC}']//table"})

    # Public: Click change link
    #
    # Returns nothing
    def navigate_to_change_period_view
      change_subscription_link.click
    end

    # Public: Next renewal table info in billing information view
    #
    # Example
    #
    #  @bus_admin_console_page.billing_info_view.next_renewal_tb_rows_text
    #  # => [["Period", "monthly (change)"],
    #        ["Date", "Jul 30, 2013"],
    #        ["Amount", "$39.99 (Without taxes or discounts)"],
    #        ["Payment Type", "Visa ending in 7014 (change)"]]
    #
    # Returns next renewal table rows text array
    def next_renewal_tb_rows_text
      tables[0].body_rows_text
    end

    # Public: supplemental table info in billing information view
    #
    # Example
    #
    #  @bus_admin_console_page.billing_info_view.supp_plan_tb_rows_text
    #  # => [["Total price for 50 GB", "$19.99"]]
    #
    # Returns supplemental table rows text array
    def supp_plan_tb_rows_text
      tables[1].body_rows_text
    end

    # Public: Next renewal table info in billing information view
    #
    # Example
    #
    #  @bus_admin_console_page.billing_info_view.vat_tb_rows_text
    #  # => [["VAT Number", "BE0883236072"]]
    #
    #
    # Returns next renewal table rows text array
    def vat_tb_rows_text
      vat_info_table.body_rows_text
    end

    # Public: Auto grow status text in billing information view
    #
    # Example
    #
    #  @bus_admin_console_page.billing_info_view.autogrow_status_text
    #  # => "Disabled (more info)"
    #
    # Returns the auto grow status text
    def autogrow_status_text
      autogrow_status_th.next_sibling.text
    end

    # Public: Next renewal label text align style
    #
    # Example
    #
    #  @bus_admin_console_page.billing_info_view.next_renewal_text_align_css
    #  # => "left"
    #
    # Returns Next renewal label text align style
    def next_renewal_text_align_css
      next_renewal_h4.style("text-align")
    end
  end
end