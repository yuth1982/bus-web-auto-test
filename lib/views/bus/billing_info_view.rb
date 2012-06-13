module Bus
  class BillingInfoView < PageObject

    element :next_renewal_h4, {:xpath =>"//div[@id='resource-billing-content']/div[1]/h4"}

    element :change_subscription_link, {:link => "(change)"}

    element :continue_btn, {:xpath => "//div[@id='billing_change_confirmation']//input[@value='Continue']"}
    element :subscription_changed_txt, {:xpath => "//div[@id='resource-change_billing_period-errors']/ul[@class='flash successes']"}
    element :period_span, {:xpath =>"//div[@id='resource-billing-content']//table[@class='info-table']/tbody/tr/td/span[@class='capitalize']"}

    element :overdraft_status_td, {:xpath =>"//div[@id='resource-billing-content']/div[7]/table/tbody/tr/td"}
    element :overdraft_status_th, {:xpath =>"//div[@id='resource-billing-content']/div[7]/table/tbody/tr/th"}

    elements :next_renewal_tds, {:xpath => "//div[@id='resource-billing-content']/div/table[@class='info-table']//td"}
    element :plan_prices_tb, {:xpath => "//div[@id='resource-billing-content']/table[@class='info-table shade-table']"}

    def switch_subscription(link_text)
      driver.find_element(:link, link_text).click
      continue_btn.click
    end

  end
end