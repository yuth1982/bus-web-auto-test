module Bus
  class AddEditUserGroupSection < SiteHelper::Section
    # Private elements
    #
    # Messages
    element(:succ_msg_div, css: 'ul.flash.successes')
    element(:err_msg_div, css: 'ul.flash.errors')
    # Common
    element(:group_name_tb, id: 'name')
    # For bundled
    element(:generic_storage_type_select, css: 'select[id^=Generic_storage_pool_type_]')
    element(:generic_assigned_tb, id: 'Generic_storage_assigned')
    element(:generic_max_tb, id: 'Generic_storage_max')
    element(:generic_device_tb, id: 'Generic_device_count')
    element(:generic_server_support_cb, id: 'server_support')
    # For itemized
    element(:server_storage_type_select, css: 'select[id^=Server_storage_pool_type_]')
    element(:server_assigned_tb, id: 'Server_storage_assigned')
    element(:server_max_tb, id: 'Server_storage_max')
    element(:server_device_tb, id: 'Server_device_count')
    element(:desktop_storage_type_select, css: 'select[id^=Desktop_storage_pool_type_]')
    element(:desktop_assigned_tb, id: 'Desktop_storage_assigned')
    element(:desktop_max_tb, id: 'Desktop_storage_max')
    element(:desktop_device_tb, id: 'Desktop_device_count')
    # Common
    element(:enable_stash_cb, id: 'stash')
    element(:save_ug_btn, css: 'button[onclick*=user_groups]')

    # Public: Add a new or edit bundled user group
    #
    # @ug [Object] user group object
    #
    # Example:
    #   @bus_admin_console_page.add_new_user_group_section.add_edit_bundled_user_group(user_group_object)
    #
    # @return [] nothing
    def add_edit_bundled_user_group(ug)
      group_name_tb.type_text(ug.name)
      generic_storage_type_select.select(ug.generic_storage_type) # mandatory
      generic_max_tb.type_text(ug.generic_max) unless ug.generic_max.nil?
      generic_assigned_tb.type_text(ug.generic_assigned) unless ug.generic_assigned.nil?
      unless ug.generic_server_support.nil?
        if ug.generic_server_support.downcase.eql?('yes')
          generic_server_support_cb.check
        else
          generic_server_support_cb.uncheck
        end
      end
      unless ug.enable_stash.nil?
        if ug.enable_stash.downcase.eql?('yes')
          enable_stash_cb.check
        else
          enable_stash_cb.uncheck
        end
      end
      save_ug_btn.click
    end

    # Public: Add a new or edit itemized user group
    #
    # @ug [Object] user group object
    #
    # Example:
    #   @bus_admin_console_page.add_new_user_group_section.add_edit_itemized_user_group(user_group_object)
    #
    # @return [] nothing
    def add_edit_itemized_user_group(ug)
      group_name_tb.type_text(ug.name)

      desktop_storage_type_select.select(ug.desktop_storage_type) unless ug.desktop_storage_type.nil?
      desktop_assigned_tb.type_text(ug.desktop_assigned) unless ug.desktop_assigned.nil?
      desktop_max_tb.type_text(ug.desktop_max) unless ug.desktop_max.nil?
      desktop_device_tb.type_text(ug.desktop_device) unless ug.desktop_device.nil?

      server_storage_type_select.select(ug.server_storage_type) unless ug.server_storage_type.nil?
      server_assigned_tb.type_text(ug.server_assigned) unless ug.server_assigned.nil?
      server_max_tb.type_text(ug.server_max) unless ug.server_max.nil?
      server_device_tb.type_text(ug.server_device) unless ug.server_device.nil?

      unless ug.enable_stash.nil?
        if ug.enable_stash
          enable_stash_cb.check
        else
          enable_stash_cb.uncheck
        end
      end
      save_ug_btn.click
      wait_until_bus_section_load
    end

    # Public: Successful messages for add new or edit user group sections
    #
    # Example:
    #  @bus_admin_console_page.add_new_user_group_section.success_messages
    #  # => "Created new user group test_group"
    #
    # @return [String]
    def success_messages
      succ_msg_div.text
    end

    # Public: Error messages for add new or edit user group sections
    #
    # Example:
    #  @bus_admin_console_page.add_new_user_group_section.error_messages
    #  # => "Whole positive integer required for Desktop device count"
    #
    # @return [String]
    def error_messages
      err_msg_div.text
    end

  end
end
