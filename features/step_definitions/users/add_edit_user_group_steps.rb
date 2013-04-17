
# Create a new bundled user group
#
# Bundled step available column names:
# | name      | storage type | assigned | max      | server support | enable stash |
# Itemized step available column names:
# | name      | desktop storage type | desktop assigned | desktop max | desktop device | enable stash | server storage type | server assigned | server max | server device |
#
When /^I (add|edit) (.+) (Bundled|Itemized) user group:$/ do |action, group_name, type, ug_table|
  cells = ug_table.hashes.first
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['user_group_list'])

  case action
    when 'add'
      @bus_site.admin_console_page.user_group_list_section.view_add_group_section
    when 'edit'
      @bus_site.admin_console_page.user_group_list_section.view_user_group(group_name)
    else
      # Skipped
  end

  case type
    when 'Bundled'
      @new_bundled_ug = Bus::DataObj::BundledUserGroup.new
      # Use obj default value if no name column
      @new_bundled_ug.name = cells['name'] unless cells['name'].nil?
      # Use page default value if you don't specific a column
      @new_bundled_ug.generic_storage_type = cells['storage type']
      @new_bundled_ug.generic_assigned = cells['assigned']
      @new_bundled_ug.generic_max = cells['max']
      @new_bundled_ug.generic_server_support = cells['server support']
      @new_bundled_ug.enable_stash = cells['enable stash']
      case action
        when 'add'
          @bus_site.admin_console_page.add_new_user_group_section.add_edit_bundled_user_group(@new_bundled_ug)
        when 'edit'
          @bus_site.admin_console_page.edit_user_group_section.add_edit_bundled_user_group(@new_bundled_ug)
        else
          # Skipped
      end
    when 'Itemized'
      @new_itemized_ug = Bus::DataObj::ItemizedUserGroup.new
      # Use obj default value if no name column
      @new_itemized_ug.name = cells['name'] unless cells['name'].nil?
      # Use page default value if you don't specific a column
      @new_itemized_ug.desktop_storage_type = cells['desktop storage type']
      @new_itemized_ug.desktop_assigned = cells['desktop assigned']
      @new_itemized_ug.desktop_max = cells['desktop max']
      @new_itemized_ug.desktop_device = cells['desktop devices']
      @new_itemized_ug.enable_stash = cells['enable stash']
      @new_itemized_ug.server_storage_type = cells['server storage type']
      @new_itemized_ug.server_assigned = cells['server assigned']
      @new_itemized_ug.server_max = cells['server max']
      @new_itemized_ug.server_device = cells['server devices']
      case action
        when 'add'
          @bus_site.admin_console_page.add_new_user_group_section.add_edit_itemized_user_group(@new_itemized_ug)
        when 'edit'
          @bus_site.admin_console_page.edit_user_group_section.add_edit_itemized_user_group(@new_itemized_ug)
        else
          # Skipped
      end
    else
      # Skipped
  end
end

Then /^(.+) user group should be (created|updated)$/ do |ug, action|
  case ug
    when 'Bundled'
      group_name = @new_bundled_ug.name
    when 'Itemized'
      group_name = @new_itemized_ug.name
    else
      group_name = ug
  end

  case action
    when 'created'
      @bus_site.admin_console_page.add_new_user_group_section.success_messages.should == "User Group #{group_name} has been successfully updated"
      # Clear previous message
      @bus_site.admin_console_page.add_new_user_group_section.refresh_bus_section
      @bus_site.admin_console_page.add_new_user_group_section.wait_until_bus_section_load
    when 'updated'
      @bus_site.admin_console_page.edit_user_group_section.success_messages.should == "User Group #{group_name} has been successfully updated"
      # Clear previous message
      @bus_site.admin_console_page.edit_user_group_section.refresh_bus_section
      @bus_site.admin_console_page.edit_user_group_section.wait_until_bus_section_load
    else
      # Skipped
  end

end

