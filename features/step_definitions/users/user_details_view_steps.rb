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
  @bus_site.admin_console_page.user_details_section.user_details_hash[text].should == nil
end

When /^I add stash for the user with:$/ do |paras|
  attributes = paras.hashes.first
  stash_quota = attributes['stash quota'] || 'default'
  send_email = (attributes['send email'] || "no").eql?("yes")
  if stash_quota == 'default'
    @bus_site.admin_console_page.user_details_section.add_stash(-1, send_email)
  else
    @bus_site.admin_console_page.user_details_section.add_stash(stash_quota, send_email)
  end
end

When /^I cancel add stash for the user$/ do
  @bus_site.admin_console_page.user_details_section.cancel_add_stash
end

Then /^Stash should be enabled for the user$/ do
  @bus_site.admin_console_page.user_details_section.stash_enabled?.should be_true
end

Then /^User backup details table should be:$/ do |details_table|
  @bus_site.admin_console_page.user_details_section.user_backup_details_table_headers.should == details_table.headers
  @bus_site.admin_console_page.user_details_section.user_backup_details_table_rows.should == details_table.rows
end