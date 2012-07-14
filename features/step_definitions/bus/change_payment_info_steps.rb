Then /^Message displayed on change payment information view should be (.+)$/ do |message|
  @bus_admin_console_page.change_payment_view.message_div.text.should == message
end