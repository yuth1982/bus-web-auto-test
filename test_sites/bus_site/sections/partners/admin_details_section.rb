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
    element(:pw_tb, id: "password")
    element(:submit_btn, xpath: "//div[contains(@id, 'delete_form')]//input[@Value='Submit']")



    # Public: activate an admin account
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

    # Public: As as admin
    #
    # Returns nothing
    def act_as_admin
      act_as_link.click
    end

    def delete_admin(admin_password)
      delete_admin_btn.click
      alert_accept
      pw_tb.set(admin_password)
      submit_btn.click
    end
  end
end