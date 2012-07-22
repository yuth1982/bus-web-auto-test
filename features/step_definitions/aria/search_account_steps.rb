When /^I search aria account by (.+)$/ do |search_key|
  step "I navigate to accounts page"
  @aria_admin_console_page.accounts_page.search_link.click
  @aria_admin_console_page.switch_to_work_frame
  @aria_admin_console_page.accounts_page.search_account_view.search_account search_key
end