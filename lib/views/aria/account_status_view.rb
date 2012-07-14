module Aria
  class AccountStatusView < PageObject
    element(:change_acc_status_link, {:link => "Change Account Status"})
    element(:remove_queued_req_link, {:link => "Remove Queued Status Change Request"})
    element(:change_acc_status_btn, {:xpath => "//input[@value='Change Account Status']"})
    element(:save_status_change_btn, {:id => "submit-button"})
    element(:bus_message_div, {:class => "error-box"})

    def change_account_status(status_code)
      change_acc_status_link.click
      driver.find_element(:xpath, "//td[text() = '#{status_code.upcase}']").previous_sibling.first_child.click
      change_acc_status_btn.click
      save_status_change_btn.click
    end

  end
end
