When /^The user status should be (.+)$/ do |status|
  @bus_site.admin_console_page.user_details_section.user_details_hash['Status:'].should include(status)
end

When /^I get the user id$/ do
  @user_id = @bus_site.admin_console_page.user_details_section.user_id
  Log.debug("user id is #{@user_id}")
end

When /^I activate the user$/ do
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

Then /^user resources details headers should be:$/ do |resource_table|
  @bus_site.admin_console_page.user_details_section.user_resource_details_table_headers.should == resource_table.headers
end

Then /^user resources details rows should be:$/ do |resource_table|
  @bus_site.admin_console_page.user_details_section.user_resource_details_table_rows.should == resource_table.rows
end

Then /^MozyHome user details should be:$/ do |user_table|
  # table is a | @country |
  actual = @bus_site.admin_console_page.user_details_section.user_details_hash
  expected = user_table.hashes.first
  expected.keys.each do |header|
    case header
      when 'Country:'
        actual[header].should == expected[header].gsub(/@country/, @partner.company_info.country)
      else
        actual[header].should == expected[header]
    end
  end
end

When /^I verify the user$/ do
  @bus_site.admin_console_page.user_details_section.verify_user
end
Then /^The user is verified$/ do
  @bus_site.admin_console_page.user_details_section.user_verified.should == 'User verified.'
end
When /^I Log in as the user$/ do
  @bus_site.admin_console_page.user_details_section.login_as_user
end

Then /^I delete user$/ do
  @bus_site.admin_console_page.user_details_section.delete_user
end

Then /^I reassign the user to user group (.+)$/ do |new_user_group|
  @bus_site.admin_console_page.user_details_section.update_user_group(@user, new_user_group)
end

Then /^I reassign the user to partner (.+)$/ do |new_partner|
  @bus_site.admin_console_page.user_details_section.update_partner(new_partner)
end

Then /^the user's partner should be (.+)$/ do |partner|
  @bus_site.admin_console_page.user_details_section.user_partner(partner).should be_true
end

Then /^the user's user group should be (.+)$/ do |user_group|
  @bus_site.admin_console_page.user_details_section.users_user_group(user_group).should be_true
end

Then /^device table in user details should be:$/ do |table|
  actual = @bus_site.admin_console_page.user_details_section.device_table_hashes
  expected = table.hashes
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

Then /^stash device table in user details should be:$/ do |table|
  actual = @bus_site.admin_console_page.user_details_section.stash_table_hashes
  expected = table.hashes.first
  expected.keys.each{ |header| actual[header].should == expected[header] }
end

When /^I delete device by name: (.+)$/ do |device_name|
  @bus_site.admin_console_page.user_details_section.delete_device(device_name)
  @bus_site.admin_console_page.user_details_section.wait_until_bus_section_load
end

Then /^I view the user's product keys$/ do
  @bus_site.admin_console_page.user_details_section.click_view_product_keys_link
end

Then /^I store the user's product key$/ do
  @key = @bus_site.admin_console_page.user_details_section.product_key
  Log.debug("product key is #{@key}")
end

Then /^I update the user password to (.+)$/ do |password|
  password = rand.to_s if password == '@user_password'
  @user_password = password
  @bus_site.admin_console_page.user_details_section.edit_password(password)
end

When(/^I get the machine_id by license_key$/) do
  @machine_id = DBHelper.get_machine_id_by_license_key(@license_key)
end

When(/^I update the newly created machine used quota to (\d+) GB$/) do |quota|
  DBHelper.update_machine_info(@machine_id, quota)
end

When(/^I close user details section$/) do
  @bus_site.admin_console_page.user_details_section.close_bus_section
end

When /^edit user details:$/ do |info_table|
  # table is a | email          | name          | status     |
  new_info = info_table.hashes.first
  new_info.keys.each do |header|
    case header
      when 'email'
        new_info[header] = @existing_user_email if new_info[header] == '@existing_user_email'
        new_info[header] = @existing_admin_email if new_info[header] == '@existing_admin_email'
        @bus_site.admin_console_page.user_details_section.set_user_email(new_info[header])
      when 'name'
        @bus_site.admin_console_page.user_details_section.set_user_name(new_info[header])
      when 'status'
        @bus_site.admin_console_page.user_details_section.set_user_status(new_info[header]) #cancelled or active
      else
        raise "Unexpected header for #{new_info[header]}"
    end
  end
end

When /^edit user email success message to (.+) should be displayed$/ do |email|
  @bus_site.admin_console_page.user_details_section.messages.should == "Email address unchanged. The email address you entered is invalid or already in use: Please enter a valid email address"
end

When /^edit user email error message to (.+) should be displayed$/ do |email|
  @bus_site.admin_console_page.user_details_section.messages.should == "Email address unchanged. The email address you entered is invalid or already in use: An account with email address \"#{email}\" already exists"
end

When /^edit user email change confirmation message to (.+) should be displayed$/ do |email|
  @bus_site.admin_console_page.user_details_section.messages.should == "Your email change request requires verification. We sent an email to #{email}. Please open the email and click the verification link to confirm this change."
end
When /^I set device quota field to (\d+) and cancel$/ do |count|
  @bus_site.admin_console_page.user_details_section.device_edit_and_cancel(count)
end

When /^I edit user device quota to (\d+)$/ do |count|
  @bus_site.admin_console_page.user_details_section.change_device_quota(count)
end

Then /^The range of device by tooltips should be:$/ do | range |
  @bus_site.admin_console_page.user_details_section.check_device_range(range.hashes.first)
end

Then /^Show error: (.+)$/ do |message|
  @bus_site.admin_console_page.user_details_section.messages.should == message
end

When /^users' device status should be:$/ do |device_status_table|
  device_status = @bus_site.admin_console_page.user_details_section.device_status_text
  actual = {}
  actual['storage_type'] = device_status[/\b(\w*):/, 1]
  actual['used'] = device_status[/(\d+) Used/, 1]
  actual['available'] = device_status[/(\d+) Available/, 1]
  expected = device_status_table.hashes.first
  expected.keys.each{ |header| actual[header.downcase].should == expected[header] }
end