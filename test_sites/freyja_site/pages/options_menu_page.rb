module Freyja

  class OptionsMenuPage < SiteHelper::Page

    element(:event_history, css: "#panel-action-event-history")
    element(:preference, css: "#panel-action-preferences")

    element(:log_out_action, id: "panel-action-sign-out")
    element(:log_out_yes_btn, xpath: "//*[@id='logout_confirm_dialog']//a//*[text()='Yes']")

    section(:change_password_section, ChangePasswordSection, xpath: "//li[@id='panel-action-change-password']")


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

    def open_event_history
      event_history.click
    end

    def open_preference
      preference.click
    end

    def logout
      sleep 1
      log_out_action.click
      sleep 1
      log_out_yes_btn.click
      sleep 1
    end

  end
end