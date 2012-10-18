module Bus
  # This class provides actions for add new user section
  class AddNewUserSection < SiteHelper::Section
    # Private elements
    #
    element(:name_tb, id: "user_name")
    element(:email_tb, id: "user_username")
    element(:user_group_search_img, xpath: "//img[@alt='Search-button-icon']")

    element(:server_licenses_tb, id: "requested_licenses_Server")
    element(:server_quota_tb, id: "requested_quota_Server")
    element(:desktop_licenses_tb, id: "requested_licenses_Desktop")
    element(:desktop_quota_tb, id: "requested_quota_Desktop")
    element(:save_changes_btn, id: "create_user-submit")
    element(:message_div, xpath: "//div[@id='user-new-errors']/ul")

    # Public: Add a new user
    #
    # Example
    #   @bus_admin_console_page.add_new_user_section.add_new_user(user_object)
    #
    # Returns nothing
    def add_new_user(user)
      name_tb.type_text(user.name)
      email_tb.type_text(user.email)
      user_group_search_img.click
      sleep 2
      find(:xpath, "//li[text()='#{user.user_group}']").click
      server_licenses_tb.type_text(user.server_licenses) unless user.server_licenses == 0
      server_quota_tb.type_text(user.server_quota) unless user.server_quota == 0
      desktop_licenses_tb.type_text(user.desktop_licenses) unless user.desktop_licenses == 0
      desktop_quota_tb.type_text(user.desktop_quota) unless user.desktop_quota == 0
      save_changes_btn.click
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
