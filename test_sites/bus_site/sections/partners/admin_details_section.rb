module Bus
  # This class provides actions for admin details page section
  class AdminDetailsSection < SiteHelper::Section

    # Private elements
    #
    element(:act_as_link, css: "a:contains('Act as')")
    element(:activate_admin_link, xpath: "//a[text()='Activate Admin']")
    element(:new_pwd_txt, id: "new_password")
    element(:pwd_confirm_txt, id: "new_password_confirmation")
    element(:submit, xpath: "//div[starts-with(@id, 'admin-pass-change-')]/form//input[@value='Save Changes']")
    element(:delete_admin_btn, xpath: "//a[text() = 'Delete Admin']")
    element(:pw_tb, xpath: "//input[@name='password']")
    element(:submit_btn, xpath: "//div[@class='popup-window-footer']//input[@Value='Submit']")
    element(:admin_name_tb, id: "target_admin_display_name")
    element(:admin_email_tb, id: "target_admin_username")
    element(:admin_parent_select, xpath: "//select[@name='target_admin[parent_admin_id]']")
    element(:admin_info_submit_btn, xpath: "//div[contains(@id, 'admininfobox')]//input[@value='Save Changes']")
    element(:admin_info_message_txt, xpath: "//div[contains(@id, 'admininfobox')]//ul/li")
    element(:admin_id_txt, xpath: "//div[contains(@id, 'admin-show-')]//dt[text()='ID:']/../dd")

    # change admin password
    element(:change_admin_password_link, xpath: "//div[contains(@id,'admin-show')]//li//a[text()='Change Password']")
    element(:new_password_tb, xpath: "//input[@id='new_password']")
    element(:new_password_confirm_tb, xpath: "//input[@id='new_password_confirmation']")
    element(:new_password_change_btn, xpath: "//div[contains(@id,'admin-pass-change')]//input[@value='Save Changes']")
    element(:change_admin_pwd_msg_txt, xpath: "//div[contains(@id,'admin-show')]/ul/li")

    #
    # new_pwd - a password for account
    # pwd_confirm - password confirmation
    #
    # Examples
    #
    #   activate_admin("test1234","test1234")
    #
    # Returns nothing

    def activate_admin(new_pwd,pwd_confirm)
      activate_admin_link.click
      new_pwd_txt.type_text(new_pwd)
      pwd_confirm_txt.type_text(pwd_confirm)
      submit.click
      sleep 10 # Wait for admin to be activated
    end

    def has_activate_admin_link?
      all(:xpath, "//a[text()='Activate Admin']").size > 0
    end

    # Public: As as admin
    #
    # Returns nothing
    def act_as_admin
      act_as_link.click
      alert_accept if alert_present?
    end

    def partner
      partners = all(:xpath, "//div[@class='show-details']/dl[dt='Partner:']/dd")
      { :name => partners.first.text } if partners.size > 0
    end

    def delete_admin(admin_password)
      delete_admin_btn.click
      alert_accept
      pw_tb.set(admin_password)
      submit_btn.click
      text = ""
      if alert_present?
        text = alert_text
        alert_accept
      end
      return text
    end

    def set_admin_email(email)
      admin_email_tb.type_text email
    end

    def set_admin_name(name)
      admin_name_tb.type_text name
    end

    def set_admin_parent(parent)
      admin_parent_select.select parent
    end

    def save_admin_info_changes
      admin_info_submit_btn.click
    end

    def admin_info_box_message
      admin_info_message_txt.text
    end

    def admin_id
      admin_id_txt.text
    end

    def change_admin_pwd(password)
      change_admin_password_link.click
      wait_until_bus_section_load
      new_password_tb.type_text(password)
      new_password_confirm_tb.type_text(password)
      new_password_change_btn.click
      wait_until_bus_section_load
    end

    def change_admin_pwd_msg
      change_admin_pwd_msg_txt.text
    end

  end
end
