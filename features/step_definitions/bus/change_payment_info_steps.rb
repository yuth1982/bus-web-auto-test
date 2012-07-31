Then /^Message displayed on change payment information view should match (.+)$/ do |message|
  @bus_admin_console_page.change_payment_info_view.message_text.should match(message)
end

When /^I update partner credit card information with new test info$/ do
  @bus_admin_console_page.change_payment_info_view.update_credit_card_info(Bus::CreditCard.new)
end