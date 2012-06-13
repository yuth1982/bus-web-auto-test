Then /^I should see (.+) invoice setting$/ do |setting|
  @bus_admin_console_page.account_details_view.invoice_settings_text.include?(setting).should == true
end

Then /^I should see Receive Mozy Account Statements option is set to (\w+)$/ do |status|
  @bus_admin_console_page.account_details_view.receive_statement_status.should == status
end

Then /^I should see Receive Mozy Pro Newsletter option is set to (\w+)$/ do |status|
  @bus_admin_console_page.account_details_view.receive_newsletter_status.should == status
end

Then /^I should see Receive Mozy Email Notifications option is set to (\w+)$/ do |status|
  @bus_admin_console_page.account_details_view.receive_email_status.should == status
end

Then /^I set Receive Mozy Account Statements option to (\w+)$/ do |status|
  @bus_admin_console_page.account_details_view.set_receive_statement_status status
end

Then /^I should see setting saved message is (.+)$/ do |message|
  @bus_admin_console_page.account_details_view.setting_saved_div.text.should == message.to_s

end