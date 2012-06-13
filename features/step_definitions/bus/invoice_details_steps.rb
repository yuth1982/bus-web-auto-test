Then /^The invoice in partner details view should display in a new window$/ do
  before_url = @bus_admin_console_page.partner_details_view.top_one_invoice_link.href
  driver.switch_to_last_opened_window
  driver.current_url.should == before_url
end

Then /^The invoice in billing history view should display in a new window$/ do
  before_url = @bus_admin_console_page.billing_history_view.top_one_invoice_link.href
  driver.switch_to_last_opened_window
  driver.current_url.should == before_url
end

Then /^The invoice details should be (.+)$/ do |page_info|
  driver.switch_to_last_opened_window
  @bus_invoice_page = Bus::InvoicePage.new driver
  @bus_invoice_page.logo.should_not be_nil
end