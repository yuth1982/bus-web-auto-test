Then /^Change payment information message should be (.+)$/ do |message|
  @bus_admin_console_page.change_payment_info_section.message_text.should match(message)
end

When /^I update partner credit card information with new test info$/ do
  @bus_admin_console_page.change_payment_info_section.update_credit_card_info(Bus::CreditCard.new)
end