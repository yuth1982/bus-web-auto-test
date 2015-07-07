module Freyja
  # This class provides actions for add new admin section
  class ChangePasswordSection < SiteHelper::Section
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
    # old_password - Freyja old password
    # new_password - Freyja new password
    #
    # Example
    #   @freyja_site.freyja_page.change_password_section.change_password(old_password, new_password)
    #
    # Returns nothing
    def change_password(old_password, new_password)
        sleep 3
        old_password_tb.type_text(old_password)
        new_password_tb.type_text(new_password)
        sleep 3
        password_confirm_tb.type_text(new_password)
        sleep 3
        change_pw_btn.click
        sleep 3
    end

    # Public: Messages for change password
    #
    # Example
    #  @freyja_site.freyja_page.change_password_section.password_changed_messages
    #  # => "Your password has been changed."
    #
    # Returns message text
    def password_changed_messages
      sleep 3
      pw_change_message.text
    end

    # Public: confirm password is changed
    #
    # Example
    #  @freyja_site.freyja_page.change_password_section.password_changed_confirm
    #
    # Returns  nothing
    def password_changed_confirm
      pw_change_confirm.click
    end

  end
end