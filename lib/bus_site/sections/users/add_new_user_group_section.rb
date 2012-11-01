module Bus
  # This class provides actions for add new user group section
  class AddNewUserGroupSection < SiteHelper::Section
    # Private elements
    #
    element(:group_name_tb, id: "user_group_name")
    element(:billing_code_tb, id: "user_group_billing_code")
    element(:server_quota_tb, id: "default_quota_Server")
    element(:desktop_quota_tb, id: "default_quota_Desktop")
    element(:save_changes_btn, xpath: "//input[@value='Save Changes']")
    element(:message_div, xpath: "//div[@id='user_groups-new-errors']/ul")

    # Public: Add a new user group
    #
    # Example
    #   @bus_admin_console_page.add_new_user_group_section(user_group_object)
    #
    # Returns nothing
    def add_new_user_group(user_group)
      group_name_tb.type_text(user_group.name)
      billing_code_tb.type_text(user_group.billing_code)
      server_quota_tb.type_text(user_group.default_server_quota)
      desktop_quota_tb.type_text(user_group.default_desktop_quota)
      save_changes_btn.click
    end

    def set_group_name(group_name)
      group_name_tb.type_text(group_name)
    end

    def save_changes
      save_changes_btn.click
    end



    # Public: Messages for add new user group sections
    #
    # Example
    #  @bus_admin_console_page.add_new_user_group_section.messages
    #  # => "Created new user group test_group"
    #
    # Returns success or error message text
    def messages
      message_div.text
    end
  end
end
