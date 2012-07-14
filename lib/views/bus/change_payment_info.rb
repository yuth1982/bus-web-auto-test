module Bus
  class ChangePaymentInfoView < PageObject
    element(:bus_message_div, {:xpath => "//div[@id='resource-change_credit_card-errors']/ul[@class='flash successes']"})
  end
end