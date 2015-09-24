#
# Available columns:
# | ID:     | External ID: | Billing code: | Status:        | Available Keys: | Available Quota: | Default quota for new installs:           | Default user group: |
# | 1234567 | (change)     | (change)      | Active(change) | 0               | 0 GB             | 2 GB (Desktop) and 2 GB (Server) (change) |
#
Then /^User group details should be:$/ do |details_table|
  actual = @bus_site.admin_console_page.user_group_details_section.group_details_hash
  expected = details_table.hashes.first
  expected.keys.each do |header|
    case header
      when 'ID:'
        if expected[header].start_with?('@')
          actual[header].length.should == expected[header].length - 1
          actual[header].match(/\d{6}/).nil?.should be_false
        else
          actual[header].should == expected[header]
        end
      else
        actual[header].should == expected[header]
    end
  end
end

Then /^User group users list details should be:$/ do |users_list_table|
  actual = @bus_site.admin_console_page.user_group_details_section.users_list_table_hashes
  expected = users_list_table.hashes
  expected.each do |col|
    col.each do |k,v|
      case k
        when 'Created'
          v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
        else
          # do nothing
      end
    end
  end
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

Then /^I should not see (.+) text on user group details section$/ do |text|
  @bus_site.admin_console_page.user_group_details_section.has_change_name_link?
  @bus_site.admin_console_page.user_group_details_section.has_no_content?(text).should be_true
end

When /^I enable stash for the user group$/ do
  @bus_site.admin_console_page.user_group_details_section.enable_stash
end

When /^I disable stash for the user group$/ do
  @bus_site.admin_console_page.user_group_details_section.disable_stash
  @bus_site.admin_console_page.click_submit
  @bus_site.admin_console_page.user_group_details_section.wait_until_bus_section_load
end

When /^I cancel disable stash for the user group$/ do
  @bus_site.admin_console_page.user_group_details_section.cancel_disable_stash
end

When /^I enable stash for all users$/ do
  @bus_site.admin_console_page.user_group_details_section.add_stash_to_all_user
end

When /^I refresh User Group Details section$/ do
  @bus_site.admin_console_page.user_group_details_section.refresh_bus_section
end

When /^I close the user group detail page$/ do
  @bus_site.admin_console_page.user_group_details_section.close_bus_section
end

When /^I delete the user group$/ do
  @bus_site.admin_console_page.user_group_details_section.delete_user_group
  @bus_site.admin_console_page.list_user_groups_section.wait_until_bus_section_load
end

When /^I search and delete (.+) user group$/ do |group_name|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['list_user_groups'])
  @bus_site.admin_console_page.list_user_groups_section.view_user_group_detail(group_name)
  @bus_site.admin_console_page.user_group_details_section.delete_user_group
  @bus_site.admin_console_page.list_user_groups_section.wait_until_bus_section_load
end


When /^I view user group details by clicking group name: (.+)$/ do |group_name|
  @bus_site.admin_console_page.user_group_list_section.view_user_group(group_name)
end

When /^I open (.+) tab$/ do |tab_name|
  @bus_site.admin_console_page.user_group_details_section.click_tab(tab_name)
end

Then /^(.+) client configuration should be (.+)$/ do |type, config_value|
  case type
    when 'Server'
      @bus_site.admin_console_page.user_group_details_section.server_config_value == config_value
    when 'Desktop'
      @bus_site.admin_console_page.user_group_details_section.desktop_config_value == config_value
  end
end

Then /^The key appears marked as a data shuttle order$/ do
  @bus_site.admin_console_page.user_group_details_section.get_data_shuttle_keys.sort.should == @order.license_key.sort
end

