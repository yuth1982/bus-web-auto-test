module Aria
  class NotificationMethodView < PageObject

    NOTIFY_METHODS_TXT_LOC = "//table[@class='data-table']/tbody/tr/td[1]"

    element :notify_msg_div, {:xpath => "//div[@class='error-box']"}
    element :change_notify_method_btn, {:xpath => "//input[@value='Change Notify Method']"}
    elements :notify_methods_td, {:xpath => "#{NOTIFY_METHODS_TXT_LOC}"}
    elements :notify_methods_rb, {:xpath => "#{NOTIFY_METHODS_TXT_LOC}/input"}

    def notify_methods_text
      notify_methods_td.map { |cell| cell.text }
    end

    def change_notify_method method
      index = notify_methods_text.index method
      notify_methods_rb[index].click
      change_notify_method_btn.click
    end
  end
end