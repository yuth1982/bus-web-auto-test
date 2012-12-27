When /^I view (.+) user group details$/ do |user_group|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['list_user_groups'])
  @bus_site.admin_console_page.list_user_groups_section.view_user_group_detail(user_group)
end

When /^I search and delete (.+) user group$/ do |group_name|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['list_user_groups'])
  @bus_site.admin_console_page.list_user_groups_section.view_user_group_detail(group_name)
  @bus_site.admin_console_page.user_group_details_section.delete_user_group
  @bus_site.admin_console_page.list_user_groups_section.wait_until_bus_section_load
end

#
# External ID 	Name 	Users 	Admins 	Stash Users 	Server Keys 	Server Quota 	Desktop Keys 	Desktop Quota
# (default user group) * 	1 	1 	1 	0 / 0 	0.0 (0.0 assigned) / 0.0 	0 / 10 	0.0 (12.0 assigned) / 250.0
#
#
Then /^User groups list table should be:$/ do |user_group_table|
  @bus_site.admin_console_page.list_user_groups_section.wait_until_bus_section_load
  actual = @bus_site.admin_console_page.list_user_groups_section.user_group_list_table_hashes
  expected = user_group_table.hashes
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

When /^I refresh List User Group section$/ do
  @bus_site.admin_console_page.list_user_groups_section.refresh_bus_section
end