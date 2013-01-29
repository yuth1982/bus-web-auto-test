module Bus
  # This class provides actions for add new user section
  class AddNewUserSection < SiteHelper::Section
    # Private elements
    #
    element(:name_tb, id: "user1_name")
    element(:email_tb, id: "user1_username")
    element(:user_group_search_select, id: "user_user_group_id")

    element(:server_licenses_tb, id: "requested_licenses_Server")
    element(:server_quota_tb, id: "requested_quota_Server")
    element(:desktop_licenses_tb, id: "requested_licenses_Desktop")
    element(:desktop_quota_tb, id: "requested_quota_Desktop")
    element(:enable_stash_cb, id: "user_enable_stash")
    element(:stash_quota_tb, id: "requested_stash_quota")
    element(:send_stash_invite_cb, id: "send_stash_invite")
    element(:desired_user_storage_tb, id: "desired_user_storage")
    element(:device_count_tb, id: "device_count")
    element(:dt_device_count_tb, id: "requested_licenses_Desktop")
    element(:desktop_device_lbl, id: "Desktop_device")
    element(:server_device_lbl, id: "Server_device")

    element(:save_changes_btn, css: "div.div_col.field_input > button[type=\"button\"]")
    element(:message_div, xpath: "//div[@id='user-new_users_in_batch-errors']/ul/li")

    # Public: Add a new user
    #
    # @param [Object] user
    #
    # Example
    #   @bus_admin_console_page.add_new_user_section.add_new_user(user_object)
    #
    # @return nothing
    def add_new_user_to_partner(user)
      unless user.user_group.nil? || user.user_group == ""
        select_user_group(user.user_group)
      end
      wait_until_bus_section_load
      name_tb.type_text(user.name)
      email_tb.type_text(user.email)
      desired_user_storage_tb.type_text(user.desired_user_storage) unless user.desired_user_storage == 0
      device_count_tb.type_text(user.device_count) unless user.device_count == 0
      enable_stash_cb.check if user.enable_stash
      stash_quota_tb.type_text(user.stash_quota) unless user.stash_quota == 0
      send_stash_invite_cb.check if user.send_stash_invite
      save_changes_btn.click
      wait_until_bus_section_load
    end

    # Public: Add a new user
    #
    # @param [Object] user
    #
    # Example
    #   @bus_admin_console_page.add_new_user_section.add_new_user(user_object)
    #
    # @return nothing
    def add_new_user_to_enterprise_partner(user)
      unless user.user_group.nil? || user.user_group == ""
        select_user_group(user.user_group)
      end
      name_tb.type_text(user.name)
      email_tb.type_text(user.email)
      desired_user_storage_tb.type_text(user.desired_user_storage) unless user.desired_user_storage == 0
      dt_device_count_tb.type_text(user.device_count) unless user.device_count == 0
      enable_stash_cb.check if user.enable_stash
      stash_quota_tb.type_text(user.stash_quota) unless user.stash_quota == 0
      send_stash_invite_cb.check if user.send_stash_invite
      save_changes_btn.click
      wait_until_bus_section_load
    end

    # Public: Add a new user to an Itemized partner
    #
    # Example
    #   @bus_admin_console_page.add_new_user_section.add_new_user_to_itemized_partner(user_object)
    #
    # Returns nothing
    def add_new_user_to_itemized_partner(user)
      unless user.user_group.nil? || user.user_group == ""
        select_user_group(user.user_group)
      end
      name_tb.type_text(user.name)
      email_tb.type_text(user.email)
      if user.server_licenses.to_i > 0 && user_enable_server_support_cb.visible?
        user_enable_server_support_cb.click
      end
      server_licenses_tb.type_text(user.server_licenses) unless user.server_licenses == 0
      server_quota_tb.type_text(user.server_quota) unless user.server_quota == 0
      desktop_licenses_tb.type_text(user.desktop_licenses) unless user.desktop_licenses == 0
      desktop_quota_tb.type_text(user.desktop_quota) unless user.desktop_quota == 0
      desired_user_storage_tb.type_text(user.desired_user_storage) unless user.desired_user_storage == 0
      device_count_tb.type_text(user.device_count) unless user.device_count == 0
      enable_stash_cb.check if user.enable_stash
      stash_quota_tb.type_text(user.stash_quota) unless user.stash_quota == 0
      send_stash_invite_cb.check if user.send_stash_invite
      save_changes_btn.click
      wait_until_bus_section_load
    end

    # Public: Messages for add new user sections
    #
    # Example
    #  @bus_admin_console_page.add_new_user_section.messages
    #  # => "Created new user test@mozy.com"
    #
    # Returns success or error message text
    def messages
      message_div.text
    end
    
    # Public: Select a user group
    #
    # @param [String] user_group
    #
    # Example
    #   @bus_admin_console_page.add_new_user_section.select_user_group("User Group 1")
    #
    # @return nothing
    def select_user_group(user_group)
      if has_user_group_search_select?
        user_group_search_select.select(user_group)
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
