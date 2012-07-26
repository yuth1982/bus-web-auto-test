module Bus
  class ChangePaymentInfoView < PageObject
    element(:message_div, {:xpath => "//div[@id='resource-change_credit_card-errors']/ul"})
    element(:modify_credit_card_cb, {:id => "modify_cc"})

    element(:cc_name_tb, {:id => "cc_name"})
    element(:cc_no_tb, {:id => "cc_no"})
    element(:cvv_tb, {:id => "cvv"})
    element(:cc_exp_mm_select, {:id => "cc_exp_mm"})
    element(:cc_exp_yyyy_select, {:id => "cc_exp_yyyy"})

    element(:submit, {:id => "submit_button"})

    def update_credit_card_info(credit_card)
      modify_credit_card_cb.check
      cc_name_tb.type_text("#{credit_card.first_name} #{credit_card.last_name}")
      cc_no_tb.type_text(credit_card.number)
      cvv_tb.type_text(credit_card.cvv)
      cc_exp_mm_select.select_by(:text,credit_card.expire_month)
      cc_exp_yyyy_select.select_by(:text,credit_card.expire_year)
      submit.click
      sleep 15
    end
  end
end