module Aria
  # This class provides actions for account status view
  class AccountStatusView < PageObject

    # Private elements
    #
    element(:change_acc_status_link, {:link => "Change Account Status"})
    element(:remove_queued_req_link, {:link => "Remove Queued Status Change Request"})
    element(:change_acc_status_btn, {:xpath => "//input[@value='Change Account Status']"})
    element(:save_status_change_btn, {:id => "submit-button"})
    element(:message_div, {:class => "error-box"})

    # Public: Change aria account status
    #
    # Example
    #   @aria_admin_console_page.accounts_page.account_overview_view.account_status_view.change_account_status("Active Dunning 1")
    #
    # Returns nothing
    def change_account_status(status_code)
      change_acc_status_link.click
      driver.find_element(:xpath, "//td[text() = '#{status_code.upcase}']").previous_sibling.first_child.click
      change_acc_status_btn.click
      save_status_change_btn.click
      sleep 10 # wait for status to take effect
    end

    # Public: Messages for change account status actions
    #
    # Example
    #   @aria_admin_console_page.accounts_page.account_overview_view.account_status_view.message_text
    #  # => "Account status changed"
    #
    # Returns success or error message text
    def message_text
      message_div.text
    end
  end
end
