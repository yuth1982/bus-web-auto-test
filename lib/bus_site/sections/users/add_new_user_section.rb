module Bus
  # This class provides actions for add new user section
  class AddNewUserSection < SiteHelper::Section
    # Private elements
    #
    
    # Section 1
    element(:error_message_div, xpath: "//div[@id='user-new_users_in_batch-errors']/ul/li")
    element(:user_group_search_select, id: "user_user_group_id")
    element(:desktop_device_lbl, id: "Desktop_device")
    element(:server_device_lbl, id: "Server_device")

    # Section 2
    element(:success_message_div, css: "ul.flash.successes > li")
    element(:name_tb, id: "user1_name")
    element(:email_tb, id: "user1_username")
    
    # Section 3
    element(:user_type_select, id: "user_types")
    element(:desired_user_storage_tb, id: "desired_user_storage")
    element(:server_licenses_tb, id: "requested_licenses_Server")
    element(:desktop_licenses_tb, id: "requested_licenses_Desktop")
    element(:device_count_tb, id: "device_count")
    #element(:server_quota_tb, id: "requested_quota_Server")
    #element(:desktop_quota_tb, id: "requested_quota_Desktop")
    #element(:enable_stash_cb, id: "user_enable_stash")
    #element(:stash_quota_tb, id: "requested_stash_quota")
    #element(:send_stash_invite_cb, id: "send_stash_invite")
    #element(:dt_device_count_tb, id: "requested_licenses_Desktop")

    # Section 4
    element(:send_email_to_users_cb, id: "send_email_to_users")
    element(:save_changes_btn, css: "div.div_col.field_input > button[type=\"button\"]")

    # Public: Add a new user
    #
    # @param [Object] user
    #
    # Example
    #   @bus_admin_console_page.add_new_user_section.add_new_user(user_object)
    #
    # @return [] nothing
    def add_new_user_to_partner(user)
      unless user.user_group.nil? || user.user_group == ""
        select_user_group(user.user_group)
        sleep 2
      end
      
      unless user.user_type.nil?
        select_user_type(user.user_type)
        sleep 2
      end
      
      name_tb.type_text(user.name)
      email_tb.type_text(user.email)
      desired_user_storage_tb.type_text(user.desired_user_storage) unless user.desired_user_storage == 0
      device_count_tb.type_text(user.device_count) unless user.device_count == 0

      save_changes_btn.click
      wait_until_bus_section_load
    end

    # Public: Add a new user to an enterprise partner
    #
    # @param [Object] user
    #
    # Example
    #   @bus_admin_console_page.add_new_user_section.add_new_user_to_enterprise_partner(user_object)
    #
    # @return [] nothing
    def add_new_user_to_enterprise_partner(user)
      unless user.user_group.nil? || user.user_group == ""
        select_user_group(user.user_group)
        sleep 2
      end
      
      unless user.user_type.nil?
        select_user_type(user.user_type)
        sleep 2
      end
            
      name_tb.type_text(user.name)
      email_tb.type_text(user.email)
      desired_user_storage_tb.type_text(user.desired_user_storage) unless user.desired_user_storage == 0
      server_licenses_tb.type_text(user.server_licenses) unless user.server_licenses == 0
      desktop_licenses_tb.type_text(user.desktop_licenses) unless user.desktop_licenses == 0

      save_changes_btn.click
      wait_until_bus_section_load
    end

    # Public: Add a new user to an Itemized partner
    #
    # @param [Object] user
    #
    # Example
    #   @bus_admin_console_page.add_new_user_section.add_new_user_to_itemized_partner(user_object)
    #
    # @return [] nothing
    def add_new_user_to_itemized_partner(user)
      unless user.user_group.nil? || user.user_group == ""
        select_user_group(user.user_group)
        sleep 2
      end
      
      unless user.user_type.nil?
        select_user_type(user.user_type)
        sleep 2
      end
      
      name_tb.type_text(user.name)
      email_tb.type_text(user.email)
      server_licenses_tb.type_text(user.server_licenses) unless user.server_licenses == 0
      desktop_licenses_tb.type_text(user.desktop_licenses) unless user.desktop_licenses == 0
      desired_user_storage_tb.type_text(user.desired_user_storage) unless user.desired_user_storage == 0
      device_count_tb.type_text(user.device_count) unless user.device_count == 0

      save_changes_btn.click
      wait_until_bus_section_load
    end

    # Public: Error messages for add new user sections
    #
    # @param [None]
    # 
    # Example
    #  @bus_admin_console_page.add_new_user_section.error_messages
    #  # => "Failed to create (1) users"
    #
    # @return [String] success or error message text
    def error_messages
      error_message_div.text
    end
    
    # Public: Success messages for add new user sections
    #
    # @param [] none
    # 
    # Example
    #  @bus_admin_console_page.add_new_user_section.success_messages
    #  # => "Created new user test@mozy.com"
    #
    # @return [String] success message text
    def success_messages
      success_message_div.text
    end
    
    # Public: Select a user group
    #
    # @param [String] user_group
    #
    # Example
    #   @bus_admin_console_page.add_new_user_section.select_user_group("User Group 1")
    #
    # @return [] nothing
    def select_user_group(user_group)
      if has_user_group_search_select?
        user_group_search_select.select(user_group)
      end
    end
    
    # Public: Select a user type
    #
    # @param [String] user_type
    #
    # Example
    #   @bus_admin_console_page.add_new_user_section.("Desktop Only")
    #
    # @return [] nothing
    def select_user_type(user_type)
      if has_user_type_select?
        user_type_select.select(user_type)
      end
    end
    
    # Public: Return desktop device value
    #
    # @param [] none
    #
    # Example
    #   @bus_admin_console_page.add_new_user_section.desktop_device_lbl.to_i
    #
    # @return [String]
    def desktop_device
      desktop_device_lbl.text
    end
    
    # Public: Return server device value
    #
    # @param [] none
    #
    # Example
    #   @bus_admin_console_page.add_new_user_section.server_device_lbl.to_i
    #
    # @return [String]
    def server_device
      server_device_lbl.text
    end
  end
end
