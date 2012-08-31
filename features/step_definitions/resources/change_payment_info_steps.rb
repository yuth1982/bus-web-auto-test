Then /^Change payment information message should be (.+)$/ do |message|
  @bus_site.admin_console_page.change_payment_info_section.messages.should match(message)
end

When /^I update (.+) credit card information$/ do |account|
  step "I navigate to Change Payment Information section from bus admin console page"
  @new_cc_info = Bus::DataObj::CreditCard.new
  @bus_site.admin_console_page.change_payment_info_section.update_credit_card_info(@new_cc_info)
end

Then /^Credit card information should be updated$/ do
  @bus_site.admin_console_page.change_payment_info_section.messages.should == "Your billing information has been successfully updated. All future payments will be charged to your new credit card ending in #{@new_cc_info.last_four_digits}."
end