When /^I navigate to (.+) view from side menu$/ do |link_name|
  @aria_site.admin_tools_page.switch_to_work_frame
  @aria_site.accounts_page.side_menu_section.navigate_to_link(link_name)
end

# Taxpayer information steps
#
# Available columns: id, status
#
Then /^(.+) taxpayer information should be:$/ do |account, info_table|
  step "I search aria account by #{account[:user_name]}"
  step "I navigate to Taxpayer Information view from side menu"
  attributes = info_table.hashes.first
  @aria_site.admin_tools_page.switch_to_inner_work_frame
  @aria_site.accounts_page.taxpayer_section.vat_number.should == attributes["id"] unless attributes["id"].nil?
  @aria_site.accounts_page.taxpayer_section.tax_exempt_status.should == attributes["status"] unless attributes["status"].nil?
end

# Available columns names:
# | id | exempt state | exempt federal|
#
When /^I set (.+) taxpayer information to:$/ do |account, info_table|
  step "I search aria account by #{account[:user_name]}"
  step "I navigate to Taxpayer Information view from side menu"
  attributes = info_table.hashes.first
  @aria_site.admin_tools_page.switch_to_inner_work_frame
  @aria_site.accounts_page.taxpayer_section.set_state_exempt_taxes(attributes["exempt state"].eql?("yes")) unless attributes["exempt state"].nil?
  @aria_site.accounts_page.taxpayer_section.set_federal_exempt_taxes(attributes["exempt federal"].eql?("yes")) unless attributes["exempt federal"].nil?

end

# Account status steps
#
When /^I change (.+) status to (.+)$/ do |account, status_code|
  step "I search aria account by #{account[:user_name]}"
  @aria_site.admin_tools_page.switch_to_inner_work_frame
  @aria_site.accounts_page.account_overview_section.navigate_to_link("Status")
  @aria_site.accounts_page.account_status_section.change_account_status(status_code)
end

Then /^Account status should be changed$/ do
  @aria_site.admin_tools_page.switch_to_inner_work_frame
  @aria_site.accounts_page.account_status_section.messages.should == "Account status changed"
end

Then /^(.+) account status should be (.+)$/ do |account, status|
  step "I search aria account by #{account[:user_name]}"
  @aria_site.admin_tools_page.switch_to_inner_work_frame
  @aria_site.accounts_page.account_overview_section.account_status.should == status
end

# Account groups steps
When /I change (.+) CAG to (.+)$/ do |account, account_group|
  step "I search aria account by #{account[:user_name]}"
  step "I navigate to Account Groups view from side menu"
  @aria_site.admin_tools_page.switch_to_inner_work_frame
  @aria_site.accounts_page.account_groups_section.change_cag(account_group)
end

Then /^CAG message should be (.+)$/ do |message|
  @aria_site.accounts_page.account_groups_section.messages == message
end

Then /^Collections account groups should be changed$/ do
  @aria_site.accounts_page.account_groups_section.messages == "Account group changes saved."
end

# Notification methods steps

Then /^(.+) notification methods should be:$/ do |account, notify_table|
  step "I search aria account by #{account[:user_name]}"
  step "I navigate to Notification Method view from side menu"
  @aria_site.admin_tools_page.switch_to_inner_work_frame
  @aria_site.accounts_page.notification_method_section.notify_methods.should == notify_table.rows.map{ |row| row.first }
end

Then /^(.+) current notification method is set to (.+)$/ do |account, method|
  step "I search aria account by #{account[:user_name]}"
  step "I navigate to Notification Method view from side menu"
  @aria_site.admin_tools_page.switch_to_inner_work_frame
  @aria_site.accounts_page.notification_method_section.messages.should == "This account is currently notified via method \"#{method}\"."
end

When /^I set (.+) notification method to (.+)$/ do |account, notification_method|
  step "I search aria account by #{account[:user_name]}"
  step "I navigate to Notification Method view from side menu"
  @aria_site.admin_tools_page.switch_to_inner_work_frame
  @aria_site.accounts_page.notification_method_section.change_notify_method(notification_method)
end

Then /^Notification message should be (.+)$/ do |message|
  @aria_site.admin_tools_page.switch_to_inner_work_frame
  @aria_site.accounts_page.notification_method_section.messages.should == message
end

When /^I set notification method to (.+)$/ do |notification_method|
  @aria_site.admin_tools_page.switch_to_inner_work_frame
  @aria_site.accounts_page.notification_method_section.change_notify_method(notification_method)
end

