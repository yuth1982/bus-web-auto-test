module Bus
  # This class provides actions for account details page section
  class AccountDetailsSection < SiteHelper::Section

    # Constants
    #
    ACC_SETTINGS_DIV_ID = "setting-edit_account_settings-content"

    # Private elements
    #
    elements(:acc_setting_links_dd, xpath: "//div[@id='#{ACC_SETTINGS_DIV_ID}']/div/dl/span/dd//a")
    element(:receives_statement_input, id: "receives_aria_stmt_via_email")
    element(:submit_receives_statement_btn, xpath: "//div[@id='#{ACC_SETTINGS_DIV_ID}']//dl/span[6]/dd/form/span[@class='edit']/input")
    element(:setting_saved_div, xpath: "//div[@id='setting-edit_account_settings-errors']/ul")

    # Public: account details table description column
    #
    # Example
    #   account_details_section.acc_details_desc_columns
    #   # => ["Name:","Username/Email:","Password:","Receive Mozy Pro Newsletter?","Receive Mozy Email Notifications?","Receive Mozy Account Statements?"]
    #
    # Returns account details description column text array
    def acc_details_desc_columns
      all(:xpath, "//div[@id='#{ACC_SETTINGS_DIV_ID}']/div/dl/span/dt").map{ |span| span.text}
    end

    # Public: account details table values column
    #
    # Example
    #   account_details_section.acc_details_value_columns
    #   # => ["Kevin Jones (change)","qa1+kevin+jones+1529@mozy.com (change)","(hidden) (change)","No (change)","No (change)","Yes (change)"]
    #
    # Return account details values column text array
    def acc_details_value_columns
      all(:xpath, "//div[@id='#{ACC_SETTINGS_DIV_ID}']/div/dl/span/dd/form/span[@class='view']").map{ |span| span.text}
    end

    # Pubic: Change account's receive statement status
    #
    # Example
    #  @bus_admin_console_page.account_details_section.set_receive_statement_status("No")
    #
    # Returns nothing
    def set_receive_statement_status(status)
      change_receive_statement_link.click
      receives_statement_input.select(status)
      submit_receives_statement_btn.click
    end

    # Public: Messages for change account details actions
    #
    # Example
    #  @bus_admin_console_page.account_details_section.messages
    #  # => "Successfully saved Account Statement preference."
    #
    # Returns success or error message text
    def messages
      setting_saved_div.text
    end

    private

    def change_receive_newsletter_link
      acc_setting_links_dd[6]
    end

    def change_receive_email_link
      acc_setting_links_dd[8]
    end

    def change_receive_statement_link
      acc_setting_links_dd[10]
    end
  end
end