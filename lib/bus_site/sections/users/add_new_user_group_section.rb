module Bus
  # This class provides actions for add new user group section
  class AddNewUserGroupSection < SiteHelper::Section
    # Private elements
    #
    element(:group_name_tb, id: "user_group_name")
    element(:billing_code_tb, id: "user_group_billing_code")
    element(:server_quota_tb, id: "default_quota_Server")
    element(:default_quota_tb, id: "default_quota_Desktop")
    element(:save_changes_btn, id: "//div[@id='user_groups-new-content']//input[@value='Save Changes']")
    element(:message_div, xpath: "//div[@id='user_groups-new-errors']/ul")

    # Public: Add a new user group
    #
    # Example
    #   @bus_admin_console_page.add_new_user_section.add_new_user(user_object)
    #
    # Returns nothing
    def add_new_user(user)
      name_tb.type_text(user.name)
      email_tb.type_text(user.email)
      server_licenses_tb.type_text(user.num_server_lic)
      server_quota_tb.type_text(user.server_quota)
      desktop_licenses_tb.type_text(user.num_desktop_lic)
      desktop_quota_tb.type_text(user.desktop_quota)
      save_changes_btn.click
    end

    # Public: Messages for add new user group sections
    #
    # Example
    #  @bus_admin_console_page.add_new_user_group_section.messages
    #  # => "Created new user group group test_group"
    #
    # Returns success or error message text
    def messages
      message_div.text
    end
  end
end
