module Freyja
  # This class provides actions for menu user section
  class MenuUserSection < SiteHelper::Section

    #private elements
    #change password
    element(:change_pw_action, id: "panel-action-change-password")
    element(:old_password_tb, xpath: "//*[@id='change_password_dialog']//*[@id='old-pw']")
    element(:new_password_tb, xpath: "//*[@id='change_password_dialog']//*[@id='new-pw']")
    element(:password_confirm_tb, xpath: "//*[@id='change_password_dialog']//*[@id='pw-confirm']")
    element(:change_pw_btn, xpath: "//*[@id='change_password_dialog']//a//*[text()='Change password']")
    element(:pw_change_message, xpath: "//*[@id='flash']//*[@id='noid']//span")
    element(:pw_change_confirm, xpath: "//*[@id='flash']//a//*[text()='OK']")
    #log out
    element(:log_out_action, id: "panel-action-sign-out")
    element(:log_out_yes_btn, xpath: "//*[@id='logout_confirm_dialog']//a//*[text()='Yes']")
    #event history
    element(:event_history_action, id: "panel-action-event-history")

    # Public: Change user login password
    #
    # old_pw - Freyja old password
    # new_pw - Freyja new password
    #
    # Example
    #   @freyja_site.freyja_page.menu_user_section.change_password(old_pw, new_pw)
    #
    # Returns nothing
    def change_password(old_pw, new_pw)
      change_pw_action.click
      old_password_tb.type_text(old_pw)
      new_password_tb.type_text(new_pw)
      password_confirm_tb.type_text(new_pw)
      change_pw_btn.click
    end

    # Public: Logout freyja
    #
    # Example
    #   @freyja_site.freyja_page.menu_user_section.logout
    #
    # Returns nothing
    def logout
      log_out_action.click
      log_out_yes_btn.click
    end

    # Public: Messages for change password
    #
    # Example
    #  @freyja_site.freyja_page.menu_user_section.password_changed_messages
    #  # => "Your password has been changed."
    #
    # Returns message text
    def password_changed_messages
      pw_change_message.text
    end

    # Public: confirm password is changed
    #
    # Example
    #  @freyja_site.freyja_page.menu_user_section.password_changed_confirm
    #
    # Returns  nothing
    def password_changed_confirm
      pw_change_confirm.click
    end

    # Public: click event history tab in user menu
    #
    # Example
    #  @freyja_site.freyja_page.menu_user_section.click_event_history
    #
    # Returns  nothing
    def click_event_history
      event_history_action.click
    end

  end
end
