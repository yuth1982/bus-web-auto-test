module Bus
  # This class provides actions for add new user group section
  class AddNewUserGroupSection < SiteHelper::Section
    # Private elements
    #
    element(:group_name_tb, id: "user_group_name")
    element(:billing_code_tb, id: "user_group_billing_code")
    element(:server_quota_tb, id: "default_quota_Server")
    element(:desktop_quota_tb, id: "default_quota_Desktop")
    element(:stash_quota_tb, id: "user_group_stash_default_quota")
    element(:save_changes_btn, css: "input[value='Save Changes']")
    element(:message_div, css: "div#user_groups-new-errors ul")
    element(:help_img, css: "img.tooltip")

    # Public: Add a new user group
    #
    # Example:
    #   add_new_user_group_section.add_new_user_group(user_group_object)
    #
    # Returns nothing
    def add_new_user_group(user_group)
      group_name_tb.type_text(user_group.name)
      billing_code_tb.type_text(user_group.billing_code) unless user_group.billing_code.nil?
      server_quota_tb.type_text(user_group.server_quota) unless user_group.server_quota.nil?
      desktop_quota_tb.type_text(user_group.desktop_quota) unless user_group.desktop_quota.nil?
      stash_quota_tb.type_text(user_group.stash_quota) unless user_group.stash_quota.nil?
      save_changes_btn.click
    end

    # Public: Messages for add new user group sections
    #
    # Example:
    #  add_new_user_group_section.messages
    #  # => "Created new user group test_group"
    #
    # Returns success or error message text
    def messages
      message_div.text
    end

    # Public: Help icon visible?
    #
    # Example:
    #   # => add_new_user_group_section.help_icon_visible?
    #
    # Returns bool
    def help_icon_visible?
      help_img.visible?
    end

    # Public: Help icon message
    #
    # Example:
    #   # => add_new_user_group_section.help_icon_messages
    #
    # Returns text
    def help_icon_messages
      help_img['data-tooltip']
    end
  end
end
