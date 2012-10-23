When /^The user status should be (.+)$/ do |status|
  @bus_site.admin_console_page.user_details_section.status_is.should == status
end

When /^I get the user id$/ do
  @user_id = @bus_site.admin_console_page.user_details_section.user_id
  Log.debug("user id is #{@user_id}")
end

When /^I active the user$/ do
  @bus_site.admin_console_page.user_details_section.active_user
end