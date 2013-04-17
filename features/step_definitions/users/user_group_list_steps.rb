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
  @bus_site.admin_console_page.user_group_list_section.delete_user_group(group_name)
  @bus_site.admin_console_page.click_ok
  @bus_site.admin_console_page.user_group_list_section.wait_until_bus_section_load
end
