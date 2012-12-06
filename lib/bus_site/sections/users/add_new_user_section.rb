module Bus
  # This class provides actions for add new user section
  class AddNewUserSection < SiteHelper::Section
    # Private elements
    #
    element(:name_tb, id: "user_name")
    element(:email_tb, id: "user_username")
    element(:user_group_search_img, css: "img[alt='Search-button-icon']")

    element(:server_licenses_tb, id: "requested_licenses_Server")
    element(:server_quota_tb, id: "requested_quota_Server")
    element(:desktop_licenses_tb, id: "requested_licenses_Desktop")
    element(:desktop_quota_tb, id: "requested_quota_Desktop")
    element(:enable_stash_cb, id: "user_enable_stash")
    element(:stash_quota_tb, id: "requested_stash_quota")
    element(:send_stash_invite_cb, id: "send_stash_invite")

    element(:save_changes_btn, id: "create_user-submit")
    element(:message_div, css: "div#user-new-errors ul")

    # Public: Add a new user
    #
    # Example
    #   @bus_admin_console_page.add_new_user_section.add_new_user(user_object)
    #
    # Returns nothing
    def add_new_user(user)
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
