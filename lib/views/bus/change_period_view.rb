module Bus
  # This class provides actions for change billing period view
  class ChangePeriodView < PageObject

    # Private elements
    #
    element(:continue_btn, {:xpath => "//div[@id='billing_change_confirmation']//input[@value='Continue']"})
    element(:change_confirmation_div, {:id => "billing_change_confirmation"})
    element(:price_table, {:xpath => "//div[@id='billing_change_confirmation']/table"})
    element(:message_div, {:xpath => "//div[@id='resource-change_billing_period-errors']//li"})

    # Public: Move upstream with subscription period
    #
    # Example
    #   @bus_admin_console_page.change_period_view.change_subscription_up("MozyPro annual billing period")
    #
    # Returns nothing
    def change_subscription_up(link_text)
      driver.find_element(:link, link_text).click
      continue_btn.click
      sleep 10 # wait for change subscription period
    end

    # Public: Move downstream with subscription period
    #
    # Example
    #   @bus_admin_console_page.change_period_view.change_subscription_down("Reseller monthly billing period")
    #
    # Returns nothing
    def change_subscription_down(link_text)
      driver.find_element(:link, link_text).click
      sleep 10 #wait for change subscription period
    end

    # Public: change subscription period confirmation text
    #
    # Example
    #   @bus_admin_console_page.change_period_view.change_confirmation_text
    #   # => "Are you sure that you want to change your subscription period from yearly to 3-year billing? ... ..."
    #
    # Returns confirmation text
    def change_confirmation_text
      change_confirmation_div.text
    end

    # Public: Messages for change subscription period actions
    #
    # Example
    #  @bus_admin_console_page.change_period_view.message_text
    #  # => "Your account has been changed to yearly billing."
    #
    # Returns success or error message text
    def message_text
      message_div.text
    end

    # Public: Change subscription period price table header text
    #
    # Example
    #   @bus_admin_console_page.change_period_view.price_tb_header_text
    #   # => ["Description", "Amount"]
    #
    # Returns price table header text
    def price_tb_header_text
      price_table.header_row_text
    end

    # Public: Change subscription period price table rows text
    #
    # Example
    #   @bus_admin_console_page.change_period_view.price_tb_header_text
    #   # => [["Credit for remainder of monthly subscription", "$42.00"],
    #         ["Charge for new yearly subscription", "$420.00"]
    #         ["Total amount to be charged", "$420.00"]]
    #
    # Returns price table rows text
    def price_tb_rows_text
      price_table.body_rows_text
    end
  end
end
