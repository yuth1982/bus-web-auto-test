Then /^Notification methods should be (.+)$/ do |expected_text|
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.notification_method_view.notify_methods_text.join(",").should == expected_text
end

Then /^Notification message should be (.+)$/ do |message|
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.notification_method_view.notify_msg_div.text.should == message
end

When /^I set notification method to (.+)$/ do |notification_method|
  @aria_admin_console_page.switch_to_inner_work_frame
  @aria_admin_console_page.accounts_page.notification_method_view.change_notify_method(notification_method)
end
