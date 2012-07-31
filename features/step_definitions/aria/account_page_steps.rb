When /^I navigate to (.+) view from Accounts page$/ do |link_name|
  @aria_admin_console_page.switch_to_work_frame
  @aria_admin_console_page.accounts_page.navigate_to_link(link_name)
end

# Taxpayer information steps
#
Then /^Taxpayer id should be (.+)$/ do |id|
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.account_overview_view.taxpayer_view.taxpayer_id_text.should == id
end

Then /^Tax exemption status should be (.+)$/ do |status|
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.account_overview_view.taxpayer_view.tax_exempt_status_text.should == status
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
  @aria_admin_console_page.accounts_page.account_overview_view.navigate_to_change_status_view
  @aria_admin_console_page.accounts_page.account_overview_view.account_status_view.change_account_status(status_code)
end

Then /^Status changed successful message should be (.+)$/ do |message|
  @aria_admin_console_page.accounts_page.account_overview_view.account_status_view.message_text.should == message
end

Then /^Account status should be (.+)$/ do |status|
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.account_overview_view.account_status_text.should == status
end

# Account groups steps
When /I change collections account group to (.+)$/ do |account_group|
  step "I navigate to Account Groups view from Accounts page"
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.account_groups_view.change_to_cag(account_group)
end

Then /^Change account group message should be (.+)$/ do |message|
  @aria_admin_console_page.accounts_page.account_groups_view.message_text == message
end

# General steps

When /^I navigate to notification method view$/ do
  @aria_admin_console_page.switch_to_work_frame
  @aria_admin_console_page.accounts_page.navigate_to_link("Notification Method")
end

