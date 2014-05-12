module Freyja
  # This class manage all sections for Freyja page
  class FreyjaPage < SiteHelper::Page

    # sections
    section(:menu_user_section, MenuUserSection, id: "menu-user")
    #section(:devices_section, DevicesSection, id: "backup_tab")
    #section(:synced_section, SyncedSection, id: "stash_tab")

    # Private element
    # Backup element
    element(:devices_tab_btn, id: "backup_tab_button")
    element(:backup_view_actions_pane_btn, xpath: "//*[@id='backup_tab']//*[@title='View Actions pane']")
    element(:device_checkbox, xpath: "//*[starts-with(@id,'4565:Folder:')][1]/td[1]/div/span")

    # Sync element
    element(:synced_tab_btn, id: "stash_tab_button")
    element(:synced_view_actions_pane_btn, xpath: "//*[@id='stash_tab']//*[@title='View Actions pane']")

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

    # Public: Click Devices tab
    #
    # Example
    #   @freyja_site.freyja_page.click_devices_tab
    #
    # Returns nothing
    def click_devices_tab
      devices_tab_btn.click
    end

    # Public: Click Synced tab
    #
    # Example
    #   @freyja_site.freyja_page.click_synced_tab
    #
    # Returns nothing
    def click_synced_tab
      synced_tab_btn.click
    end

    # Public: Click one device
    #
    # Example
    #   @freyja_site.freyja_page.choose_one_device
    #
    # Returns nothing
    def choose_one_device
      device_checkbox.click
    end

    # Public: Click View Actions pane
    #
    # Example
    #   @freyja_site.freyja_page.click_backup_view_actions_pane
    #
    # Returns nothing
    def click_backup_view_actions_pane
      backup_view_actions_pane_btn.click
    end

    # Public: Click View Actions pane
    #
    # Example
    #   @freyja_site.freyja_page.click_sync_view_actions_pane
    #
    # Returns nothing
    def click_sync_view_actions_pane
      synced_view_actions_pane_btn.click
    end

  end
end
