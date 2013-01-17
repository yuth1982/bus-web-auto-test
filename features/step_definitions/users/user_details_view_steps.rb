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

Then /^user details should be:$/ do |user_table|
  actual = @bus_site.admin_console_page.user_details_section.user_details_hash
  expected = user_table.hashes.first

  expected.keys.each do |header|
    case header
      when 'ID:'
        if expected[header].start_with?('@')
          actual[header].length.should == expected[header].length - 1
          actual[header].match(/\d{8}/).nil?.should be_false
        else
          actual[header].should == expected[header]
        end
      when 'Name:'
        if @user.nil?
          actual[header].should == expected[header]
        else
          actual[header].should == expected[header].gsub(/@user/,@user.name)
        end
      when ''
        if expected[header] == "today"
          actual[header].should == Chronic.parse(expected[header]).strftime("%m/%d/%y %H:%M")
        else
          actual[header].should == expected[header]
        end
      else
        actual[header].should == expected[header]
    end
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

When /^I cancel add user stash$/ do
  @bus_site.admin_console_page.user_details_section.cancel_add_stash
end

When /^I change user stash quota to (\d+) GB$/ do |quota|
  @bus_site.admin_console_page.user_details_section.change_stash_quota(quota)
end

When /^I cancel change user stash quota$/ do
  @bus_site.admin_console_page.user_details_section.cancel_change_stash_quota
end

Then /^User backup details table should be:$/ do |details_table|
  @bus_site.admin_console_page.user_details_section.user_backup_details_table_headers.should == details_table.headers
  @bus_site.admin_console_page.user_details_section.user_backup_details_table_rows.should == details_table.rows
end

Then /^User backup details table should not have stash record$/ do
  @bus_site.admin_console_page.user_details_section.wait_until_bus_section_load
  stash_record = @bus_site.admin_console_page.user_details_section.user_backup_details_table_rows.select{ |row| row.join(' ').start_with?('Stash') }
  stash_record.empty?.should be_true
end

When /^I delete stash container for the user$/ do
  @bus_site.admin_console_page.user_details_section.click_delete_stash
end

When /^I click change stash quota text box$/ do
  @bus_site.admin_console_page.user_details_section.click_change_quota_tb
end

Then /^Change stash quota hover message should be (.+)$/ do |message|
  @bus_site.admin_console_page.user_details_section.find_change_quota_tooltips(message).should be_true
end

When /^I refresh User Details section$/ do
  @bus_site.admin_console_page.user_details_section.refresh_bus_section
end

When /^I send stash invitation email$/ do
  @bus_site.admin_console_page.user_details_section.send_stash_invitation_email
end

Then /^User stash quota changed successfully$/ do
  @bus_site.admin_console_page.user_details_section.messages.should == 'Quota changed successfully.'
end

Then /^User details changed message should be (.+)$/ do |message|
  @bus_site.admin_console_page.user_details_section.messages.should == message
end

And /^user resources details headers should be:$/ do |resource_table|
  @bus_site.admin_console_page.user_details_section.user_resource_details_table_headers.should == resource_table.headers
end

And /^user resources details rows should be:$/ do |resource_table|
  @bus_site.admin_console_page.user_details_section.user_resource_details_table_rows.should == resource_table.rows
end