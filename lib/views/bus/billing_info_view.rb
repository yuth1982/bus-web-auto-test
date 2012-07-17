module Bus
  class BillingInfoView < PageObject

    BILLING_INFO_LOC = "resource-billing-content"

    element(:next_renewal_h4, {:xpath =>"//div[@id='#{BILLING_INFO_LOC}']/div[1]/h4"})

    element(:change_subscription_link, {:link => "(change)"})

    element(:autogrow_status_th, {:xpath =>"Status"})

    elements(:next_renewal_tds, {:xpath => "//div[@id='#{BILLING_INFO_LOC}']/div/table[@class='info-table']//td"})

    elements(:tables, {:xpath => "//div[@id='#{BILLING_INFO_LOC}']//table"})

    def master_plan_table
       tables[0]
    end

    def autogrow_status_td
      ele = driver.find_element(:xpath, "//th[text()='Status']")
      ele.next_sibling
    end
  end
end