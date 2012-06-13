When /^I add the new aria account with (.+)$/ do |account_plan|
  step "I navigate to accounts page"
  step "I navigate to create account view"
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.create_account_view.add_new_account account_plan
end

