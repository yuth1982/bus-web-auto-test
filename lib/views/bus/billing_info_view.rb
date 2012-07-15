module Bus
  class BillingInfoView < PageObject

    BILLING_INFO_LOC = "resource-billing-content"

    element(:next_renewal_h4, {:xpath =>"//div[@id='#{BILLING_INFO_LOC}']/div[1]/h4"})

    element(:change_subscription_link, {:link => "(change)"})

    element(:continue_btn, {:xpath => "//div[@id='billing_change_confirmation']//input[@value='Continue']"})
    element(:change_status_txt, {:xpath => "//div[@id='resource-change_billing_period-errors']//li"})

    element(:period_span, {:xpath =>"//div[@id='#{BILLING_INFO_LOC}']//table[@class='info-table']/tbody/tr/td/span[@class='capitalize']"})

    element(:autogrow_status_th, {:xpath =>"Status"})

    elements(:next_renewal_tds, {:xpath => "//div[@id='#{BILLING_INFO_LOC}']/div/table[@class='info-table']//td"})

    elements(:tables, {:xpath => "//div[@id='#{BILLING_INFO_LOC}']//table"})

    element(:change_confirmation_div, {:id => "billing_change_confirmation"})

    def change_subscription_up(link_text)
      driver.find_element(:link, link_text).click
      continue_btn.click
      sleep 10 # wait for change subscription period
    end

    def change_subscription_down(link_text)
      driver.find_element(:link, link_text).click
      sleep 10 #wait for change subscription period
    end

    def master_plan_table
       tables[0]
    end

    def supplemental_plan_table
       tables[1]
    end

    def autogrow_status_td
      ele = driver.find_element(:xpath, "//th[text()='Status']")
      ele.next_sibling
    end


  end
end