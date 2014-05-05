module Freyja
  # This class provides actions for freyja login page
  class FreyjaPage < SiteHelper::Page

    section(:menu_user_section, MenuUserSection, id: "menu-user")
    #section(:devices_section, DevicesSection, id: "backup_tab")
    #section(:synced_section, SyncedSection, id: "stash_tab_button")

    # Public: Navigate to menu item on admin console page
    # Note: if bus module is opened, menu will not be clicked
    #
    # @section_name          [String] link name
    # @use_quick_link     [Boolean] click link in Quick Links if link exists
    #
    # @return [nothing]
    def navigate_to_menu(section_name, use_quick_link = false)
      # Looking for link in navigation menu
      find(:id, section_name)
      # calling all method does not require to wait
      sections = all(:id, section_name)
      el = use_quick_link ? sections.first : sections.last
      if sections.first.element_parent[:class].match(/active/).nil? && sections.last.element_parent[:class].match(/active/).nil?
        el.click
      end
    end

  end
end
