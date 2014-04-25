module Freyja
  class ActionPanel < SiteHelper::Page

    element(:action_panel_toggle, css: 'div.panel-toggle.btn-panel-toggle')
    element(:restore_all_link, css: 'div.action-icon.action-icon-restore-all')


    def open_restore_all_files_link
      restore_all_link.click
    end

    def open_actions_panel
      action_panel_toggle.click
    end



  end
end