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

  expected.each do |_, v|
    v.replace ERB.new(v).result(binding)
  end

  expected.keys.each do |header|
    case header
      when 'ID:'
        if expected[header].start_with?('@')
          actual[header].match(/\d+/).nil?.should be_false
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

When /^I enable stash (with|without) send email in user details section$/ do |condition|
  send_email =  condition == 'with' ? true : false
  @bus_site.admin_console_page.user_details_section.add_stash(send_email)
end

#When /^I add stash for the user with:$/ do |paras|
#  attributes = paras.hashes.first
#  stash_quota = attributes['stash quota'] || 'default'
#  send_email = (attributes['send email'] || "no").eql?("yes")
#  if stash_quota == 'default'
#    @bus_site.admin_console_page.user_details_section.add_stash(-1, send_email)
#  else
#    @bus_site.admin_console_page.user_details_section.add_stash(stash_quota, send_email)
#  end
#end


When /^I cancel add user stash$/ do
  @bus_site.admin_console_page.user_details_section.cancel_add_stash
end

When /^I (change|set) user stash quota to (\d+) GB$/ do |action, quota|
  if action == 'change'
    @bus_site.admin_console_page.user_details_section.change_stash_quota(quota)
  elsif action == 'set'
    @bus_site.admin_console_page.user_details_section.add_stash_quota(quota)
  end
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
  @bus_site.admin_console_page.click_yes
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

When /^I close User Details section$/ do
  @bus_site.admin_console_page.user_details_section.close_bus_section
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

Then /^user resources details rows should be:$/ do |resource_table|
  actual = @bus_site.admin_console_page.user_details_section.storage_device_info
  expected = resource_table.hashes.first

  expected.keys.each do |header|
    actual[header].should == expected[header]
  end
end

Then /^MozyHome user details should be:$/ do |user_table|
  # table is a | @country |
  actual = @bus_site.admin_console_page.user_details_section.user_details_hash
  expected = user_table.hashes.first
  expected.keys.each do |header|
    case header
      when 'Country:'
        actual[header].should == expected[header].gsub(/@country/, @partner.company_info.country)
      when 'Name:'
        actual[header].should == expected[header].gsub(/@user_name/, @partner.admin_info.full_name)
      when 'Partner:'
        actual[header].should == expected[header].gsub(/@partner/, @partner.partner_info.parent)
      else
        actual[header].should == expected[header]
    end
  end
end

Then /^MozyHome subscription details should be:$/ do |subscription_table|
  # table is a | mozyhome 50 gb, +0 gb |
  actual = @bus_site.admin_console_page.user_details_section.mozyhome_user_details_hash
  expected = subscription_table.hashes.first

  expected.each do |_, v|
    v.replace ERB.new(v).result(binding)
  end
  # iteration
  expected.keys.each do |header|
    actual[header].should == expected[header]
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
  next if ENV['BUS_ENV'] == 'qa3'
  @bus_site.admin_console_page.user_details_section.delete_user
end

Then /^I reassign the user to user group (.+)$/ do |new_user_group|
  next if ENV['BUS_ENV'] == 'qa3'
  @bus_site.admin_console_page.user_details_section.update_user_group(@user, new_user_group)
end

Then /^I reassign the user to partner (.+)$/ do |new_partner|
  #new_partner.replace(ERB.new(new_partner).result(binding))
  #The above statement cause strange problem, new partner is the former one
  new_partner = ERB.new(new_partner).result(binding)
  @bus_site.admin_console_page.user_details_section.update_partner(new_partner)
end

Then /^the user's partner should be (.+)$/ do |partner|
  @bus_site.admin_console_page.user_details_section.user_partner(partner).should be_true
end

Then /^the user's user group should be (.+)$/ do |user_group|
  next if ENV['BUS_ENV'] == 'qa3'
  @bus_site.admin_console_page.user_details_section.users_user_group(user_group).should be_true
end

Then /^device table in user details should be:$/ do |table|
  actual = @bus_site.admin_console_page.user_details_section.device_table_hashes
  expected = table.hashes
  expected.each_index { |index|
    expected[index].keys.each { |key|
      #depending on the performance of the testing env, the "Last Update" time could be different
      if !(expected[index][key].match(/^(1|< a|2) minute(s)* ago$/).nil?)
        actual[index][key].match(/^(1|< a|2) minute(s)* ago$/).nil?.should be_false
      else
        actual[index][key].should == expected[index][key]
      end
    }
  }
end

Then /^stash device table in user details should be:$/ do |table|
  actual = @bus_site.admin_console_page.user_details_section.stash_table_hashes
  expected = table.hashes.first
  expected.keys.each{ |header|
    if expected[header] == '< a minute ago'
      (actual[header].match(/^(< a|1) minute ago$/).nil?).should == false
    else
      actual[header].should == expected[header]
    end
  }
end

When /^I delete device by name: (.+)$/ do |device_name|
  @bus_site.admin_console_page.user_details_section.delete_device(device_name)
  @bus_site.admin_console_page.user_details_section.wait_until_bus_section_load
end

Then /^I view the user's product keys$/ do
  @bus_site.admin_console_page.user_details_section.click_view_product_keys_link
end

Then /^I update the user password to (.+)$/ do |password|
  next if ENV['BUS_ENV'] == 'qa3'
  password = rand.to_s if password == '@user_password'
  @user_password = password
  @bus_site.admin_console_page.user_details_section.edit_password(password)
end

Then /^I update user password to incorrect password (.+) and get the error message:$/ do |password,message|
  @bus_site.admin_console_page.user_details_section.edit_password_with_incorrect_pass(password).should == message
end

When(/^I get the machine_id by license_key$/) do
  @machine_id = DBHelper.get_machine_id_by_license_key(@license_key)
end

When /^I get the machine id for client (\d+) by license key (.+)$/ do |client_index, license_key|
  license_key.replace ERB.new(license_key).result(binding)
  @clients[client_index.to_i].machine_id = DBHelper.get_machine_id_by_license_key(license_key)
end

When(/^I update (.+) used quota to (\d+) GB$/) do |machine, quota|
  machine.replace ERB.new(machine).result(binding) if machine.to_s.match(/^[1-9]\d*$/).nil?
  if machine.to_s.match(/^[1-9]\d*$/).nil?
    machine = @bus_site.admin_console_page.user_details_section.get_machine_id(machine)
  else
    machine = machine.to_i
  end
  DBHelper.update_machine_info(machine, quota)
end

When /Available quota of (.+) should be (\d+) GB/ do |machine, quota|
  machine_id = machine.is_a?(Fixnum) ? machine : @bus_site.admin_console_page.user_details_section.get_machine_id(machine)
  DBHelper.machine_available_quota(machine_id).should == quota.to_i
end

When(/^I close user details section$/) do
  @bus_site.admin_console_page.user_details_section.close_bus_section
end

When /^edit user details:$/ do |info_table|
  next if ENV['BUS_ENV'] == 'qa3'
  # table is a | email          | name          | status     |
  new_info = info_table.hashes.first

  new_info.each do |header,attribute| #can use variable inside <%= %>
    attribute.replace ERB.new(attribute).result(binding)
    new_info[header] = nil if attribute == ''
  end

  new_info.keys.each do |header|
    case header
      when 'email'
        new_info[header] = @existing_user_email if new_info[header] == '@existing_user_email'
        new_info[header] = @existing_admin_email if new_info[header] == '@existing_admin_email'
        new_info[header] = @partner.admin_info.email if new_info[header] == '@mh_user_email'
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
  @bus_site.admin_console_page.user_details_section.messages.should == "Email has been changed to #{email}."
end

When /^edit user email error message to (.+) should be displayed$/ do |email|
  @bus_site.admin_console_page.user_details_section.messages.should == "Email address unchanged. The email address you entered is invalid or already in use: An account with email address \"#{email}\" already exists"
end

When /^edit user email error message should be:$/ do |message|
  @bus_site.admin_console_page.user_details_section.messages.should == message
end

When /^edit user email change confirmation message to (.+) should be displayed$/ do |email|
  @bus_site.admin_console_page.user_details_section.messages.should == "Your email change request requires verification. We sent an email to #{email}. Please open the email and click the verification link to confirm this change."
end
When /^I set device quota field to (\d+) and cancel$/ do |count|
  @bus_site.admin_console_page.user_details_section.device_edit_and_cancel(count)
end

When /^I edit user( Desktop| Server)* device quota to (\d+)$/ do |type, count|
  @bus_site.admin_console_page.user_details_section.change_device_quota(count, type)
  @bus_site.admin_console_page.user_details_section.wait_until_bus_section_load
end

Then /^The range of( Desktop| Server|) device by tooltips should be:$/ do | type, range |
  type =
    if type.empty?
      nil
    else
      type.strip
    end
  device_range = @bus_site.admin_console_page.user_details_section.device_range(type)
  range.hashes.first.each do |k, v|
    device_range[k.downcase].should == v
  end
end

Then /^Show error: (.+)$/ do |message|
  @bus_site.admin_console_page.user_details_section.messages.should == message
end

When /^users' device status should be:$/ do |device_status_table|
  actual = @bus_site.admin_console_page.user_details_section.device_status_hashes
  expected_hashes = device_status_table.hashes
  expected_hashes.each_with_index do |expected, i|
    expected.keys.each{ |header| actual[i][header.downcase].should == expected[header] }
  end
end


When(/^I (set|edit|remove|save|cancel) (user|machine) max for (.+)$/) do |action, type, name|
  @bus_site.admin_console_page.user_details_section.handle_max(action, type, name)
end

When(/^I input the (user|machine) max value for (.+) to (\d+) GB$/) do |type, name, quota|
  @bus_site.admin_console_page.user_details_section.set_max_value(type, name, quota)
end

Then(/^set max message should be:$/) do | msg|
  @bus_site.admin_console_page.user_details_section.messages.should == msg
end

Then(/^The range of machine max for (.+) by tooltips should be:$/) do |machine, range|
  # table is a | 0   | 12  |
  tooltip = @bus_site.admin_console_page.user_details_section.machine_max_range(machine)
  range.hashes.first.each do |k, v|
    tooltip[k.downcase].should == v
  end
end

When /^I view details of (.+)'s user group$/ do |user|
  step %{I search user by:}, table(%{
      | keywords |
      | #{user}  |
  })
  step %{I view user details by #{user}}
  @bus_site.admin_console_page.user_details_section.click_user_group_details_link
  @bus_site.admin_console_page.user_details_section.wait_until_bus_section_load
end

When /^I close the user detail page$/ do
  @bus_site.admin_console_page.user_details_section.close_bus_section
end

Then /^I display login information$/ do
  if @partner.partner_info.type == 'MozyHome'
    Log.info("un: #{@partner.admin_info.email}, pw: #{CONFIGS['global']['test_pwd']}")
  else
    Log.info("pn: #{@partner.admin_info.email}, un: #{@new_users.last.email}, pw: #{CONFIGS['global']['test_pwd']}")
  end
end

When /^I search and delete user account if it exists by (.+)/ do |account_name|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_users'])
  @bus_site.admin_console_page.search_list_users_section.search_user(account_name)
  @bus_site.admin_console_page.search_list_users_section.wait_until_bus_section_load
  rows = @bus_site.admin_console_page.search_list_users_section.search_results_table_rows
  unless rows.to_s.include?('No results found.')
    @bus_site.admin_console_page.search_list_users_section.view_user_details(account_name)
    @bus_site.admin_console_page.user_details_section.delete_user
  end
end

When /^I change user install override region to (.+)/ do |region|
  @bus_site.admin_console_page.user_details_section.change_region(region)
end

Then /^I will( not)? see the change user password link$/ do |t|
  if t.nil?
    @bus_site.admin_console_page.user_details_section.has_change_user_password_link.should be_true
  else
    @bus_site.admin_console_page.user_details_section.has_change_user_password_link.should be_false
  end
end

Then /^I click Send activation email again$/ do
  @bus_site.admin_console_page.user_details_section.click_send_activation_email_again
end

When /^the user has activated the account with (.+)$/ do |password|

    step %{I retrieve email content by keywords:}, table(%{
       | to                       |
       | <%=@new_users[0].email%> |
  })
    match = @mail_content.match(/https?:\/\/[\S]+.mozy[\S]+.[\S]+\/account\/set_password[\S]+/)
    @activate_email_query = match[0] unless match.nil?

  @bus_site.admin_console_page.open_admin_activate_page(@activate_email_query)
  @freyja_site = FreyjaSite.new
  @freyja_site.main_page.set_user_password(password)
  @user_password = password
end

When /^I click delete sync device icon for the user$/ do
  @bus_site.admin_console_page.user_details_section.click_delete_stash
end

And /^The button displayed on the pop up are (.+)$/ do |values|
  @bus_site.admin_console_page.get_popup_buttons.should == values.split(' ')
end

Then /^The sync device (should not|should) be deleted$/ do |result|
  exist = (result == 'should not'? true:false)
  @bus_site.admin_console_page.user_details_section.check_sync_exist.should == exist
end

Then /^I downgrade mozyhome user to (50GB|Free)$/ do |match|
  @bus_site.admin_console_page.user_details_section.expand_subscriptions
  @bus_site.admin_console_page.user_details_section.click_edit_plan
  @bus_site.admin_console_page.user_details_section.downgrade_user(match)
end

Then /^I verify mozyhome user plan is (50GB|Free) after downgrade$/ do |match|
  quota = @bus_site.admin_console_page.user_details_section.get_mozyhome_user_quota
  status = @bus_site.admin_console_page.user_details_section.get_mozyhome_user_status
  if match.eql?('50GB')
    quota.should == '50 GB'
    status.should include 'Active'
  else
    status.should include 'Cancelled on'
  end
end

Then /^I refund the user with (.+) amount$/ do |amount|
  @amount = @bus_site.admin_console_page.user_details_section.refund_user(amount)
end

Then /^I check the refund amount should be correct$/ do
  @bus_site.admin_console_page.user_details_section.refresh_bus_section
  refunded_amount = @bus_site.admin_console_page.user_details_section.get_refunded_amount
  refunded_amount[1..-1].to_f.should == - @amount.to_f
end

Then /^The current user should be billed$/ do
  @bus_site.admin_console_page.user_details_section.refresh_bus_section
  @bus_site.admin_console_page.user_details_section.wait_until_bus_section_load
  (@bus_site.admin_console_page.user_details_section.get_user_billed_info > 1).should be_true
end

