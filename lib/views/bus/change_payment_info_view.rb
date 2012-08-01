module Bus
  # This class provides actions for change payment information view
  class ChangePaymentInfoView < PageObject

    # Private elements
    #
    element(:message_div, {:xpath => "//div[@id='resource-change_credit_card-errors']/ul"})
    element(:modify_credit_card_cb, {:id => "modify_cc"})
    element(:cc_name_tb, {:id => "cc_name"})
    element(:cc_no_tb, {:id => "cc_no"})
    element(:cvv_tb, {:id => "cvv"})
    element(:cc_exp_mm_select, {:id => "cc_exp_mm"})
    element(:cc_exp_yyyy_select, {:id => "cc_exp_yyyy"})
    element(:submit, {:id => "submit_button"})

    # Public: update account's credit card information, but not update billing address.
    #
    # Example
    #   @bus_admin_console_page.change_payment_info_view.update_credit_card_info(credit_card_object)
    #
    # Returns nothing
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

    # Public: Messages for change payment information actions
    #
    # Example
    #  @bus_admin_console_page.change_payment_info_view.message_text
    #  # => "Your account is backup-suspended. You will not be able to access your account until your credit card is billed."
    #
    # Returns success or error message text
    def message_text
      message_div.text
    end
  end
end