

When /^I navigate to the new user group details section$/ do
  @bus_site.admin_console_page.navigate_to_link(CONFIGS['bus']['menu']['list_user_groups'])
  @bus_site.admin_console_page.list_user_groups_section.view_user_group_detail(@user_group.name)
end

Then /^User group details should be:$/ do |details_table|

  actual = @bus_site.admin_console_page.user_group_details_section.group_details_hash
  expected = details_table.hashes.first
  actual['ID:'].length.should == expected['ID:'].length - 1
  actual['ID:'].match(/\d{6}/).nil?.should be_false
  actual[1..-1].should == expected[1..-1]
end

When /^I delete a group named (.+)$/ do |user_group|
  @bus_site.admin_console_page.list_user_groups_section.view_user_group_detail user_group
  @bus_site.admin_console_page.user_group_details_section.delete_user_group
end