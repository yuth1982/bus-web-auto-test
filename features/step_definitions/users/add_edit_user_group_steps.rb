
# Create a new bundled user group
#
# Bundled step available column names:
# | name      | storage_type | assigned | max      | server_support | enable_stash |
# Itemized step available column names:
# | name      | desktop_storage_type | desktop_assigned | desktop_max | desktop_device | enable_stash | server_storage_type | server assigned | server max | server device |
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
      hash_to_object(cells, @new_bundled_ug)
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
      hash_to_object(cells, @new_itemized_ug)
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
      @bus_site.admin_console_page.add_new_user_group_section.success_messages.should == "User Group #{group_name} has been successfully created"
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

Then /^(Add|Edit) user group error messages should be:$/ do |action, messages|
  case action
    when 'Add'
      @bus_site.admin_console_page.add_new_user_group_section.error_messages.should == messages.to_s
      # Clear previous message
      @bus_site.admin_console_page.add_new_user_group_section.refresh_bus_section
      @bus_site.admin_console_page.add_new_user_group_section.wait_until_bus_section_load
    when 'Edit'
      @bus_site.admin_console_page.edit_user_group_section.error_messages.should == messages.to_s
      # Clear previous message
      @bus_site.admin_console_page.edit_user_group_section.refresh_bus_section
      @bus_site.admin_console_page.edit_user_group_section.wait_until_bus_section_load
    else
      # Skipped
  end
end

Then /^I should see correct UI for (Bundled|Itemized) user group with:$/ do |type, ug_table|
  # Force to refresh add new user group section in case server enabled or stash enabled
  @bus_site.admin_console_page.add_new_user_group_section.refresh_bus_section
  @bus_site.admin_console_page.add_new_user_group_section.wait_until_bus_section_load
  cells = ug_table.hashes.first
  storage_type = cells['storage_type']
  enable_stash = cells['enable_stash'].downcase.eql?('yes')
  server_support = cells['server_support'].downcase.eql?('yes')
  case type
    when 'Bundled'
      @bus_site.admin_console_page.add_new_user_group_section.verify_add_bundled_user_group_ui(storage_type,enable_stash,server_support).should be_true
    when 'Itemized'
      @bus_site.admin_console_page.add_new_user_group_section.verify_add_itemized_user_group_ui(storage_type,enable_stash,server_support).should be_true
    else
      # Skipped
  end
end

