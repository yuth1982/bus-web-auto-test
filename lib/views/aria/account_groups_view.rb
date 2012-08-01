module Aria
  # This class provides actions for account groups view
  class AccountGroupsView < PageObject

    # Private elements
    #
    element(:cybersource_credit_card, {:xpath => "//input[@value='10026095']"})
    element(:fail_test_cag, {:xpath => "//input[@value='10030097']"})

    element(:change_cag, {:id => "submit-button"})
    element(:message_div, {:class => "error-box"})

    # Public: Change account CAG type
    #
    # Example
    #  @aria_admin_console_page.accounts_page.account_groups_view.change_cag("CyberSource Credit Card")
    #
    # Returns nothing
    def change_cag(cag_name)
       case cag_name
         when "Fail Test CAG"
           fail_test_cag.click
         when "CyberSource Credit Card"
           cybersource_credit_card.click
         else
       end
       change_cag.click
    end

    # Public: Messages for change account group actions
    #
    # Example
    #  @bus_admin_console_page.account_groups_view.message_text
    #  # => "Account group changes saved."
    #
    # Returns success or error message text
    def message_text
      message_div.text
    end
  end
end

