# Taxpayer information steps
#
Then /^Taxpayer id should be (.+)$/ do |id|
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.account_overview_view.taxpayer_view.taxpayer_id_dd.text.should == id
end

Then /^Tax exemption status should be (.+)$/ do |status|
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.account_overview_view.taxpayer_view.tax_exempt_status_dd.text.should == status
end

When /^I set Exempt from State and Province taxes to (true|false)$/ do |status|
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.account_overview_view.taxpayer_view.set_state_exempt_taxes(status == "true")
end

When /^I set Exempt from Federal and National taxes to (true|false)$/ do |status|
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.account_overview_view.taxpayer_view.set_federal_exempt_taxes(status == "true")
end

# Account status steps
#
When /^I change account status to (.+)$/ do |status_code|
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.account_overview_view.status_link.click
  @aria_admin_console_page.accounts_page.account_overview_view.account_status_view.change_account_status(status_code)
end

Then /^Status changed successful message should be (.+)$/ do |message|
  @aria_admin_console_page.accounts_page.account_overview_view.account_status_view.message_div.text.should == message
end

Then /^Account status should be (.+)$/ do |status|
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.account_overview_view.account_status
end
