module Bus
  class ChangePaymentInfoView < PageObject
    element(:message_div, {:xpath => "//div[@id='resource-change_credit_card-errors']/ul"})
  end
end