module Bus
  # This class provides actions for list user groups section
  class ListUserGroupsSection < SiteHelper::Section
    # Private elements
    #
    element(:filter_select, id: "user_group_filter")
    element(:user_groups_list_table, css: "div#user_groups-list-content table.table-view")
    element(:loading_link, xpath: "//a[contains(@onclick,'toggle_module')]")

    # Public: View user group detail by click user group's name
    #
    # Examples
    #
    #  list_user_groups_section.view_user_group_detail("Lego Company Group")
    #
    # Returns nothing
    def view_user_group_detail(search_key)
      find_link(search_key).click
    end

    # Public: User group list table header text
    #
    # Example:
    #
    # Returns array
    def user_group_list_table_headers
      user_groups_list_table.headers_text
    end

    # Public: User group list table rows text
    #
    # Example:
    #
    # Returns array
    def user_group_list_table_rows
      user_groups_list_table.rows_text
    end

    def stop_spining
      wait_until{ loading_link[:class] != "title loading" }
    end
  end
end
