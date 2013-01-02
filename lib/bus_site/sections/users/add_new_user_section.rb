module Bus
  # This class provides actions for add new user section
  class AddNewUserSection < SiteHelper::Section
    # Private elements
    #
    element(:name_tb, id: "user1_name")
    element(:email_tb, id: "user1_username")
    element(:user_group_search_img, css: "img[alt='Search-button-icon']")

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

    element(:save_changes_btn, css: "div.field.filed_input > button[type=\"button\"]")
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
      unless user.user_group.nil?
        user_group_search_img.click
        sleep 2
        find(:xpath, "//li[text()='#{user.user_group}']").click
      end
      name_tb.type_text(user.name)
      email_tb.type_text(user.email)
      desired_user_storage_tb.type_text(user.desired_user_storage) unless user.desired_user_storage.nil?
      device_count_tb.type_text(user.device_count) unless user.device_count.nil?
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
      unless user.user_group.nil?
        user_group_search_img.click
        sleep 2
        find(:xpath, "//li[text()='#{user.user_group}']").click
      end
      name_tb.type_text(user.name)
      email_tb.type_text(user.email)
      desired_user_storage_tb.type_text(user.desired_user_storage) unless user.desired_user_storage.nil?
      dt_device_count_tb.type_text(user.device_count) unless user.device_count.nil?
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
      unless user.user_group.nil?
        user_group_search_img.click
        sleep 2
        find(:xpath, "//li[text()='#{user.user_group}']").click
      end
      name_tb.type_text(user.name)
      email_tb.type_text(user.email)
      server_licenses_tb.type_text(user.server_licenses) unless user.server_licenses.nil?
      server_quota_tb.type_text(user.server_quota) unless user.server_quota.nil?
      desktop_licenses_tb.type_text(user.desktop_licenses) unless user.desktop_licenses.nil?
      desktop_quota_tb.type_text(user.desktop_quota) unless user.desktop_quota.nil?
      enable_stash_cb.check if user.enable_stash
      stash_quota_tb.type_text(user.stash_quota) unless user.stash_quota.nil?
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
  end
end
