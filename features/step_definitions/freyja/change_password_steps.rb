And /^I change password from (.+) to (.+)$/ do |old_pw, new_pw|
  @freyja_site.freyja_page.menu_user_section.change_password(old_pw, new_pw)
  sleep 2
end

And /^I change password successfully$/ do
  @freyja_site.freyja_page.menu_user_section.password_changed_confirm
end

Then /^Password changed message should be (.+)$/ do |message|
  @freyja_site.freyja_page.menu_user_section.password_changed_messages.should == message
end
