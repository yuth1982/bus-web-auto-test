When /^I view (.+) user group details$/ do |user_group|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['list_user_groups'])
  @bus_site.admin_console_page.list_user_groups_section.view_user_group_detail(user_group)
end

Then /^User groups list table should be:$/ do |user_group_table|
  @bus_site.admin_console_page.list_user_groups_section.wait_until_bus_section_load
  actual = @bus_site.admin_console_page.list_user_groups_section.user_group_list_table_hashes
  expected = user_group_table.hashes
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

Then /^User groups list should not have (.+) user group$/ do |group_name|
  @bus_site.admin_console_page.list_user_groups_section.wait_until_bus_section_load
  actual = @bus_site.admin_console_page.list_user_groups_section.user_group_list_table_hashes
  expected_group = actual.select{ |row| row['Name' == group_name] }
  expected_group.size.should > 0
end

When /^I refresh List User Group section$/ do
  @bus_site.admin_console_page.list_user_groups_section.refresh_bus_section
end