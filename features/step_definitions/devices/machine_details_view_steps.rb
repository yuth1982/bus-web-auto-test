Then /^the data shuttle machine details should be:$/ do |ds_table|
  actual = @bus_site.admin_console_page.machine_details_section.dso_hashes
  expected = ds_table.hashes
  expected.each do |col|
    col.each do |k,v|
      case k
        when 'Order Date'
          v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
        when 'Start'
          v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
        else
          # do nothing
      end
      v.replace ERB.new(v).result(binding)
    end
  end
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

When(/^I close machine details section$/) do
  @bus_site.admin_console_page.machine_details_section.close_bus_section
end

Then /^machine details should be:$/ do |md_table|
  actual = @bus_site.admin_console_page.machine_details_section.machine_info_hash
  expected = md_table.hashes[0]
  expected.each do |k,v|
      case k
        when 'Owner:'
          v.gsub!(/@user_email/, @new_users.first.email) unless @new_users.nil?
        when 'Product Key:'
          v.gsub!(/@client.license_key/, @client.license_key) unless @client.nil?
        else
          # do nothing
      end
      v.replace ERB.new(v).result(binding)
  end
  expected.keys.each{|key| actual[key].should == expected[key] }
end

And /^I get machine details info$/ do
  @machine_info = @bus_site.admin_console_page.machine_details_section.machine_info_hash
end

And /^I view machine (.+) details from user details section$/ do  |device_name|
  @bus_site.admin_console_page.user_details_section.view_device_details(device_name)
end

And /^I view deleted machine details from user details section$/ do
  @bus_site.admin_console_page.user_details_section.view_device_details(@client.machine_alias, deleted = true)
end

And /^I click manifest view link$/ do
  @bus_site.admin_console_page.machine_details_section.click_view_manifest
end

And /^view manifest window of machine (.+) is opened$/ do |device_name|
  @bus_site.manifest_view_page.view_manifest_window_visible(device_name).should > 0
end

Then /^the manifest window title should be (.+)$/ do |title|
  @bus_site.admin_console_page.get_new_window_page_title.should == title
end

And /^I click manifest raw link to download the manifest file$/ do
  @bus_site.admin_console_page.machine_details_section.click_raw_manifest
end

Then /^the (manifest|Logfile) file is downloaded$/ do  |_, file_table|
  attributes = file_table.hashes.first
  attributes.each do |header,attribute|
    attribute.replace ERB.new(attribute).result(binding)
    attributes[header] = nil if attribute == ''
  end
  @file_name = attributes["file name"]
  wait_until { FileHelper.file_exists?(@file_name) }
  FileHelper.file_exists?(@file_name).should be_true
end

And /^File size should be greater than 0$/ do
  wait_until{FileHelper.get_file_size(@file_name) > 0}
  (FileHelper.get_file_size(@file_name) > 0).should be_true
end

Then /^I delete the newly downloaded file$/ do
  FileHelper.delete_file(@file_name)
end

And /^I delete file (.+) if exist$/ do |file_name|
  FileHelper.delete_file(file_name)
end

Then /^I (delete|undelete) the machine$/ do |action|
  @bus_site.admin_console_page.machine_details_section.delete_undelete_machine(action)
end

And /^I click on the replace machine link$/ do
  @bus_site.admin_console_page.machine_details_section.click_replace_machine
end

And /^I select (.+) to be replaced$/ do |machine|
  if !(machine.match(/^@.+$/).nil?)
    machine =  '<%=' + machine + '%>'
  end
  machine.replace ERB.new(machine).result(binding)
  @bus_site.admin_console_page.replace_machine_section.replace_machine(machine)
end

Then /^The machines listed for replacement should be$/ do |machines_table|
  attributes = machines_table.raw
  actual = @bus_site.admin_console_page.replace_machine_section.get_replace_machine_list
  expected = attributes.map{ |attr|
    attr[0].replace ERB.new(attr[0]).result(binding)
  }
  actual.sort.should == expected.sort
end

And /^I close Sync section$/ do
  @bus_site.admin_console_page.machine_details_section.close_bus_section
end

When /^I set (.+) sync client region as (.+) and country as (.+)$/ do |user, region, country|
  user_email = @current_user[:email] if user == 'newly created user'
  user_password = CONFIGS['global']['test_pwd']
  machine_hash = "user_#{@user_id}_sync"
  country = 'US' if country == 'default'
  body = get_machine_info(@admin_id, user_email, user_password, machine_hash, 'sync', region, country)
  (body.downcase.include?('error')).should == false
end

And /^I refresh sync details section$/ do
  @bus_site.admin_console_page.machine_details_section.refresh_bus_section
end

Then /^I (should|should not) see data shuttle table in machine details section$/ do |type|
  if type.include? "not"
    @bus_site.admin_console_page.machine_details_section.data_shuttle_table_visible?.should be_false
  else
    @bus_site.admin_console_page.machine_details_section.data_shuttle_table_visible?.should be_true
  end
end

And /^I refresh Machine Details section$/ do
  @bus_site.admin_console_page.machine_details_section.refresh_bus_section
end

When /^I update the deleted at time to today minus (\S+) days$/ do |days|
  global_undelete_value = DBHelper.get_global_setting_value("machine_undelete_window_length").to_i
  if days == 'global_undelete_value'
    days = global_undelete_value
  elsif !(days.match(/global_undelete_value(\+|-)(\d+)/).nil?)
    array = days.match(/global_undelete_value(\+|-)(\d+)/)
    if array[1] == "+"
      days = global_undelete_value + array[2].to_i
    else
      days = global_undelete_value - array[2].to_i
    end
  end
  DBHelper.update_machine_deleted_at(@client.machine_id, days.to_i)
end

Then /^I (shouldnot|should) see Undelete Machine link$/ do |exist|
  actual_result = @bus_site.admin_console_page.machine_details_section.undelete_machine_link_exist
  expected = (exist == 'should'? true : false)
  actual_result.should == expected
end

Then /^retention period should be (\d+) days$/ do |days|
  @get_client_config_response["X-Data-Retention"].should == days
end

Then /^Machine action bar links should be$/ do |table|
   expected_links = table.rows.flatten
   @bus_site.admin_console_page.machine_details_section.get_machine_bar_actions.should == expected_links
end

And /^Backups section without backup history will show (.+)$/ do |text|
  @bus_site.admin_console_page.machine_details_section.get_backup_section_text.should == text
end

And /^Restores section without finished restores will show (.+)$/ do |text|
  @bus_site.admin_console_page.machine_details_section.get_restores_section_text.should == text
end

And /Backups table will display with text No results found.$/ do
  @bus_site.admin_console_page.machine_details_section.backup_table_empty.should == true
end

Then /^I click (.+) from machines details section$/ do |match|
  @bus_site.admin_console_page.machine_details_section.click_restore_files(match)
end

And /^(Backups|Restores|Virtual Machines) table will display as:$/ do |type, table|
  @bus_site.admin_console_page.machine_details_section.get_backup_restore_table(type).should == table.raw
end

And /^action links in the manifest will be$/ do |table|
  @bus_site.manifest_view_page.get_action_links.should == table.raw[0]
end

And /^manifest content will include$/ do |text|
  @bus_site.manifest_view_page.get_manifest_content.include?(text.strip).should == true
end

And /^manifest (.+) txt file should include:$/ do |file, text|
 FileHelper.read_file(file, "txt").include?(text).should == true
end

