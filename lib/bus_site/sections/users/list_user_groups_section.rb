module Bus
  # This class provides actions for list user groups section
  class ListUserGroupsSection < SiteHelper::Section

    # Public: View user group detail by click user group's name
    #
    # Examples
    #
    #  @bus_admin_console_page.list_user_groups_section.view_user_group_detail("Lego Company Group")
    #
    # Returns nothing
    def view_user_group_detail(search_key)
      find_element(:link, search_key).click
    end
  end
end
