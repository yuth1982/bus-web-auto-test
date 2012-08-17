module Bus
  # This class provides actions for change billing period section
  class ChangePeriodSection < PageObject

    # Constants
    #
    CHANGE_CONFIRM_LOC = "billing_change_confirmation"

    # Private elements
    #
    element(:continue_btn, {:xpath => "//div[@id='#{CHANGE_CONFIRM_LOC}']//input[@value='Continue']"})
    element(:price_table, {:xpath => "//div[@id='#{CHANGE_CONFIRM_LOC}']/table"})
    element(:message_div, {:xpath => "//div[@id='resource-change_billing_period-errors']//li"})
    elements(:confirmation_p, {:xpath => "//div[@id='#{CHANGE_CONFIRM_LOC}']/p"})

    # Public: Move upstream with subscription period
    #
    # Example
    #   @bus_admin_console_page.change_period_section.change_subscription_up("MozyPro annual billing period")
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
    #   @bus_admin_console_page.change_period_section.change_subscription_down("Reseller monthly billing period")
    #
    # Returns nothing
    def change_subscription_down(link_text)
      driver.find_element(:link, link_text).click
      sleep 10 #wait for change subscription period
    end

    # Public: Change subscription period confirmation text
    #
    # Example
    #   @bus_admin_console_page.change_period_section.confirmations
    #   # => "Are you sure that you want to change your subscription period from yearly to 3-year billing? ... ...
    #         If you choose to continue, your account ... ...
    #         Any resources you scheduled for return in your next subscription ...."
    #
    # Returns confirmation text array
    def confirmations
      confirmation_p.map{ |p| p.text.strip }
    end

    # Public: Messages for change subscription period actions
    #
    # Example
    #  @bus_admin_console_page.change_period_section.messages
    #  # => "Your account has been changed to yearly billing."
    #
    # Returns success or error message text
    def messages
      message_div.text
    end

    # Public: Change subscription period price table header text
    #
    # Example
    #   @bus_admin_console_page.change_period_section.price_table_header
    #   # => ["Description", "Amount"]
    #
    # Returns price table header text
    def price_table_headers
      price_table.find_elements(:xpath, "./thead/tr/th").map { |cell| cell.text }
    end

    # Public: Change subscription period price table rows text
    #
    # Example
    #   @bus_admin_console_page.change_period_section.price_table_header
    #   # => [["Credit for remainder of monthly subscription", "$42.00"],
    #         ["Charge for new yearly subscription", "$420.00"]
    #         ["Total amount to be charged", "$420.00"]]
    #
    #
    # Returns price table rows text
    def price_table_rows
      rows = price_table.find_elements(:xpath, "./tbody/tr").map{ |row| row.child }
      rows.map { |row| row.map { |cell| cell.text } }
    end
  end
end
