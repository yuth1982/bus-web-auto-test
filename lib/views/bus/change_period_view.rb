module Bus
  class ChangePeriodView < PageObject
    element(:continue_btn, {:xpath => "//div[@id='billing_change_confirmation']//input[@value='Continue']"})
    element(:change_confirmation_div, {:id => "billing_change_confirmation"})
    element(:price_table, {:xpath => "//div[@id='billing_change_confirmation']/table"})

    element(:message_div, {:xpath => "//div[@id='resource-change_billing_period-errors']//li"})

    def change_subscription_up(link_text)
         driver.find_element(:link, link_text).click
         continue_btn.click
         sleep 10 # wait for change subscription period
       end

       def change_subscription_down(link_text)
         driver.find_element(:link, link_text).click
         sleep 10 #wait for change subscription period
       end
  end
end
