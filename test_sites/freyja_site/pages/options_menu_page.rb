module Freyja

  class OptionsMenuPage < SiteHelper::Page

    element(:event_history, css: "#panel-action-event-history")
    element(:preference, css: "#panel-action-preferences")
    element(:notification, css: "#notifications-count")
    element(:product_download, css: "div[title='Product Downloads'] > a")

    element(:log_out_action, xpath: "//li[@id='panel-action-sign-out']")
    element(:log_out_yes_btn, xpath: "//div[@id='logout_confirm_dialog']/div[3]/div/a[2]/span")
    section(:change_password_section, ChangePasswordSection, xpath: "//li[@id='panel-action-change-password']")

    # Public: launch change password wizard
    #
    # Example
    #   @freyja_site.options_menu_page.change_password_wizard
    #
    # Returns nothing
    def change_password_wizard(section_id, use_quick_link = false)
      # Looking for link in navigation menu
      find(:xpath, section_id)
      # calling all method does not require to wait
      sections = all(:xpath, section_id)
      el = use_quick_link ? sections.first : sections.last
      if sections.first.element_parent[:class].match(/active/).nil? && sections.last.element_parent[:class].match(/active/).nil?
        el.click
      end
    end

    def logout
      log_out_action.click
      log_out_yes_btn.click
    end

  end
end