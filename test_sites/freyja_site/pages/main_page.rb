module Freyja

  class MainPage < SiteHelper::Page

    element(:backupDevice, css: "a[onclick*=ACCESS_CONTROLLER_BACKUP]")
    element(:syncDevice, css: "a[onclick*=ACCESS_CONTROLLER_SYNC]")
    element(:action_panel_toggle, css: 'div.panel-toggle.btn-panel-toggle')
    element(:options_menu, xpath: "//div[@id='menu-user']")
    element(:latest_version_radio, css: 'span.radio.radio-off')

    # Activate user element
    element(:user_password_set_text, xpath: "//input[@id='password']")
    element(:user_password_set_again_text, xpath: "//input[@id='password_confirmation']")
    element(:user_continue_activate_btn, xpath: "//div[text()='Activate account']")

    def select_options_panel
      wait_until{options_menu.visible?}
      options_menu.click
    end

    def set_user_password (password)
      user_password_set_text.type_text(password)
      user_password_set_again_text.type_text(password)
      user_continue_activate_btn.click
    end

  end
end