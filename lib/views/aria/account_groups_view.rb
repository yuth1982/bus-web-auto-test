module Aria
  class AccountGroupsView < PageObject
    element(:cybersource_credit_card, {:xpath => "//input[@value='10026095']"})
    element(:fail_test_cag, {:xpath => "//input[@value='10030097']"})

    element(:change_cag, {:id => "submit-button"})
    element(:message_div, {:class => "error-box"})

    def change_to_cag(cag_name)
       case cag_name
         when "Fail Test CAG"
           fail_test_cag.click
         when "CyberSource Credit Card"
           cybersource_credit_card.click
         else
       end
       change_cag.click
    end
  end
end

