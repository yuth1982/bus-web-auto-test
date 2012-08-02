Then /^Notification methods should be:$/ do |methods_table|
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.notification_method_section.notify_methods_text.should == methods_table.rows.map{ |row| row.first }
end

Then /^Notification message should be (.+)$/ do |message|
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.notification_method_section.message_text.should == message
end

When /^I set notification method to (.+)$/ do |notification_method|
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.notification_method_section.change_notify_method(notification_method)
end
