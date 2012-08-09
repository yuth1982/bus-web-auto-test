When /^I navigate to (.+) view from Accounts page$/ do |link_name|
  @aria_admin_console_page.switch_to_work_frame
  @aria_admin_console_page.accounts_page.navigate_to_link(link_name)
end

# Taxpayer information steps
#
# Available columns names:
# | id | status |
#
Then /^(.+) taxpayer information should be:$/ do |account, info_table|
  step "I search aria account by #{account[:user_name]}"
  step "I navigate to Taxpayer Information view from Accounts page"
  @aria_admin_console_page.switch_to_inner_work_frame
  attributes = info_table.hashes.first
  @aria_admin_console_page.accounts_page.account_overview_section.taxpayer_section.vat_number_text.should == attributes["id"] unless attributes["id"].nil?
  @aria_admin_console_page.accounts_page.account_overview_section.taxpayer_section.tax_exempt_status_text.should == attributes["status"] unless attributes["status"].nil?
end

# Available columns names:
# | id | exempt state | exempt federal|
#
When /^I set (.+) taxpayer information to:$/ do |account, info_table|
  step "I search aria account by #{account[:user_name]}"
  step "I navigate to Taxpayer Information view from Accounts page"
  @aria_admin_console_page.switch_to_inner_work_frame
  attributes = info_table.hashes.first

  @aria_admin_console_page.accounts_page.account_overview_section.taxpayer_section.set_state_exempt_taxes(attributes["exempt state"].eql?("yes")) unless attributes["exempt state"].nil?
  @aria_admin_console_page.accounts_page.account_overview_section.taxpayer_section.set_federal_exempt_taxes(attributes["exempt federal"].eql?("yes")) unless attributes["exempt federal"].nil?

end


# Account status steps
#
When /^I change (.+) status to (.+)$/ do |account, status_code|
  step "I search aria account by #{account[:user_name]}"
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.account_overview_section.navigate_to_link("Status")
  @aria_admin_console_page.accounts_page.account_overview_section.account_status_section.change_account_status(status_code)
end

Then /^Status changed successful message should be (.+)$/ do |message|
  @aria_admin_console_page.accounts_page.account_overview_section.account_status_section.message_text.should == message
end

Then /^(.+) status should be (.+)$/ do |account, status|
  step "I search aria account by #{account[:user_name]}"
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.account_overview_section.account_status_text.should == status
end

# Account groups steps
When /I change (.+) CAG to (.+)$/ do |account, account_group|
  step "I search aria account by #{account[:user_name]}"
  step "I navigate to Account Groups view from Accounts page"
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.account_groups_section.change_cag(account_group)
end

Then /^CAG message should be (.+)$/ do |message|
  @aria_admin_console_page.accounts_page.account_groups_section.message_text == message
end

# General steps

When /^I navigate to notification method view$/ do
  @aria_admin_console_page.switch_to_work_frame
  @aria_admin_console_page.accounts_page.navigate_to_link("Notification Method")
end

