# Manage Resources Section
#
Then /^Partner resources general information should be:$/ do |general_info_hash|
  actual =  @bus_site.admin_console_page.manage_resources_section.resources_general_info_hash
  expected = general_info_hash.hashes.first
  expected.keys.each do |header|
    actual[header].should == expected[header]
  end
end

Then /^Partner total resources details table should be:$/ do |resource_details_table|
  @bus_site.admin_console_page.manage_resources_section.storage_details_table_headers.should == resource_details_table.headers
  @bus_site.admin_console_page.manage_resources_section.storage_details_table_rows.should == resource_details_table.rows
end

Then /^Partner total license details table should be:$/ do |license_details_table|
  @bus_site.admin_console_page.manage_resources_section.license_details_table_headers.should == license_details_table.headers
  @bus_site.admin_console_page.manage_resources_section.license_details_table_rows.should == license_details_table.rows
end

Then /^Partner user groups table should be:$/ do |groups_table|
  @bus_site.admin_console_page.manage_resources_section.user_groups_table_headers.should == groups_table.headers
  @bus_site.admin_console_page.manage_resources_section.user_groups_table_rows.should == groups_table.rows
end

When /^I allocate (\d+) GB (Server|Desktop) quota to MozyPro partner$/ do |quota, type|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['manage_resources'])
  case type
    when 'Desktop'
      @bus_site.admin_console_page.manage_resources_section.allocate_mozypro_desktop_quota(quota)
    when 'Server'
      @bus_site.admin_console_page.manage_resources_section.allocate_mozypro_server_quota(quota)
    else
      raise 'Error resource type'
  end
end

Then /^MozyPro resource quota should be changed$/ do
  @bus_site.admin_console_page.manage_resources_section.messages.should == "Quota changed."
end

When /^I batch assign MozyPro partner (Server|Desktop) keys (with|without) send emails:$/ do |type, send_email, keys_table|
  batch_text = keys_table.rows.map{|row| row.join(",")}.join("\n")
  @bus_site.admin_console_page.manage_resources_section.batch_assign_mozypro_keys(batch_text, type, send_email=='with')
end

Then /^Manage Resources section should be active$/ do
  @bus_site.admin_console_page.manage_resources_section.has_manage_resource_content_div?.should be_true
end

Then /^I refresh Manage Resources section$/ do
  @bus_site.admin_console_page.manage_resources_section.refresh_bus_section
end

# Manage Group Resource Section
#
Then /User group general information should be:$/ do |general_info_hash|
  actual =  @bus_site.admin_console_page.manage_user_group_resources_section.user_group_general_info_hash
  expected = general_info_hash.hashes.first
  expected.keys.each do |header|
    actual[header].should == expected[header]
  end
end

Then /^User group resources details table should be:$/ do |resource_details_table|
  @bus_site.admin_console_page.manage_user_group_resources_section.storage_details_table_headers.should == resource_details_table.headers
  @bus_site.admin_console_page.manage_user_group_resources_section.storage_details_table_rows.should == resource_details_table.rows
end

Then /^User group license details table should be:$/ do |license_details_table|
  @bus_site.admin_console_page.manage_user_group_resources_section.license_details_table_headers.should == license_details_table.headers
  @bus_site.admin_console_page.manage_user_group_resources_section.license_details_table_rows.should == license_details_table.rows
end

When /^I allocate (\d+) GB (Server|Desktop) quota with (.+) user group to Reseller partner$/ do |quota, type, user_group|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['manage_resources'])
  @bus_site.admin_console_page.manage_resources_section.select_group(user_group)
  case type
    when 'Desktop'
      @bus_site.admin_console_page.manage_user_group_resources_section.allocate_reseller_desktop_quota(quota)
    when 'Server'
      @bus_site.admin_console_page.manage_user_group_resources_section.allocate_reseller_server_quota(quota)
    else
      raise 'Error resource type'
  end
end

Then /^Reseller resource quota should be changed$/ do
  @bus_site.admin_console_page.manage_user_group_resources_section.messages.should == "Quota changed."
end

When /^I create (\d+) new (Server|Desktop) keys for Reseller partner$/ do |num_keys, license_type|
  @bus_site.admin_console_page.manage_user_group_resources_section.create_new_keys(license_type, num_keys)
end

When /^I batch assign (MozyEnterprise|Reseller) partner (Server|Desktop) keys to (.+) user group (with|without) send emails:$/ do |company_type, license_type, user_group, send_email, keys_table|
  case company_type
    when 'MozyEnterprise'
      @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['assign_keys'])
    when 'Reseller'
      @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['manage_resources'])
    else
      raise 'Error resource type'
  end
  @bus_site.admin_console_page.manage_resources_section.select_group(user_group)
  batch_text = keys_table.rows.map{|row| row.join(",")}.join("\n")
  @bus_site.admin_console_page.manage_user_group_resources_section.batch_assign_keys(batch_text, license_type, send_email=='with')
end

Then /^I refresh Manage User Group Resources section$/ do
  @bus_site.admin_console_page.manage_user_group_resources_section.refresh_bus_section
end
