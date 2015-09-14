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
        else
          # do nothing
      end
      v.replace ERB.new(v).result(binding)
  end
  expected.keys.each{|key| actual[key].should == expected[key]}
end

And /^I view machine (.+) details from user details section$/ do  |device_name|
  @bus_site.admin_console_page.user_details_section.view_device_details(device_name)
end

And /^I click manifest view link$/ do
  @bus_site.admin_console_page.machine_details_section.click_view_manifest
end

And /^view manifest window of machine (.+) is opened$/ do |device_name|
  @bus_site.manifest_view_page.view_manifest_window_visible(device_name).should > 0
end

And /^I click manifest raw link to download the manifest file$/ do
  @bus_site.admin_console_page.machine_details_section.click_raw_manifest
end

Then /^the manifest file is downloaded$/ do  |file_table|
  attributes = file_table.hashes.first
  attributes.each do |header,attribute|
    attribute.replace ERB.new(attribute).result(binding)
    attributes[header] = nil if attribute == ''
  end
  @file_name = attributes["file name"]
  @bus_site.admin_console_page.machine_details_section.wait_until_manifest_file_downloaded(@file_name).should be_true
end

Then /^I delete the newly downloaded file$/ do
  @bus_site.admin_console_page.machine_details_section.delete_manifest_file(@file_name)
end

Then /^I delete the machine$/ do
  @bus_site.admin_console_page.machine_details_section.delete_machine
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



