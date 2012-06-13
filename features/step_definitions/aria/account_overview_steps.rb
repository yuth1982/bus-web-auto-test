
Then /^Taxpayer id should be (.+)$/ do |id|
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.account_overview_view.taxpayer_id_dd.text.should == id
end

Then /^Tax exemption status should be (.+)$/ do |status|
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.account_overview_view.tax_exempt_status_dd.text.should == status
end

When /^I set Exempt from State and Province taxes to (true|false)$/ do |status|
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.account_overview_view.set_state_exempt_taxes(status == "true")
end

When /^I set Exempt from Federal and National taxes to (true|false)$/ do |status|
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.account_overview_view.set_federal_exempt_taxes(status == "true")
end

When /^I change account master plan to (.+ plan)$/ do |account_plan|
  @aria_admin_console_page.accounts_page.account_overview_view.change_master_plan account_plan.plan_mapping
end

When /^I change account supplemental plan to (.+ plan)$/ do |account_plan|
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.account_overview_view.change_supplemental_plans account_plan.plan_mapping
end