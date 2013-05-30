When /^I navigate to Add User Group section$/ do
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['user_group_list'])
  @bus_site.admin_console_page.user_group_list_section.view_add_group_section
end

When /^I view user group details by name: (.+)$/ do |group_name|
  @bus_site.admin_console_page.user_group_list_section.view_user_group(group_name)
end

Then /^(Bundled|Itemized) user groups table should be:$/ do |type, ug_table|
  case type
    when 'Bundled'
      actual = @bus_site.admin_console_page.user_group_list_section.bundled_ug_list_rows
    when 'Itemized'
      actual = @bus_site.admin_console_page.user_group_list_section.itemized_ug_list_rows
    else
      # Skipped
  end
  actual.should == ug_table.rows
end

When /^I delete user group details by name: (.+)$/ do |group_name|
  admin_console_page = @bus_site.admin_console_page
  admin_console_page.user_group_list_section.delete_user_group(group_name)
  admin_console_page.user_group_list_section.wait_until_bus_section_load
end

When /^I click (Group Name|Stash|Server Enabled|Device Used|Storage Used|Desktop Storage Used|Desktop Device Total|Server Storage Used|Server Device Total) table header$/ do |name|
  @bus_site.admin_console_page.user_group_list_section.ug_table_header(name).click
end

Then /^Column (Group Name|Stash|Server Enabled|Device Used|Storage Used|Desktop Storage Used|Desktop Device Total|Server Storage Used|Server Device Total) sorts in (ascending|descending) order$/ do |name, order|
  class_expected = "sorting_#{order[0..-7]}"
  @bus_site.admin_console_page.user_group_list_section.ug_table_header(name)[:class].should =~ /#{class_expected}/
end

When /^I refresh User Group list section$/ do
  @bus_site.admin_console_page.user_group_list_section.refresh_bus_section
end
