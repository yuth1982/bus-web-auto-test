When /^I navigate to accounts page$/ do
  @aria_admin_console_page.accounts_link.click
end

When /^I navigate to search account view$/ do
  @aria_admin_console_page.accounts_page.search_link.click
end

When /^I navigate to create account view$/ do
  @aria_admin_console_page.accounts_page.create_accounts_link.click
end

When /^I navigate to taxpayer information view$/ do
  @aria_admin_console_page.switch_to_work_frame
  @aria_admin_console_page.accounts_page.taxpayer_information_link.click
end

When /^I navigate to notification method view$/ do
  @aria_admin_console_page.switch_to_work_frame
  @aria_admin_console_page.accounts_page.notify_method_link.click
end




