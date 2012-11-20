When /^The user status should be (.+)$/ do |status|
  @bus_site.admin_console_page.user_details_section.user_details_hash['Status:'].should include(status)
end

When /^I get the user id$/ do
  @user_id = @bus_site.admin_console_page.user_details_section.user_id
  Log.debug("user id is #{@user_id}")
end

When /^I active the user$/ do
  @bus_site.admin_console_page.user_details_section.active_user
end

Then /^User details should be:$/ do |user_table|
  actual = @bus_site.admin_console_page.user_details_section.user_details_hash
  expected = user_table.hashes.first

  expected.keys.each do |header|
    actual[header].should == expected[header]
  end
end

Then /^I should not see (.+) setting on user details section$/ do |text|
  @bus_site.admin_console_page.user_details_section.has_delete_user_link?
  @bus_site.admin_console_page.user_details_section.user_details_hash.keys[text].should == nil
end