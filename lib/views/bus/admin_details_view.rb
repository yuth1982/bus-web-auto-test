module Bus
  # This class provides actions for admin details view
  class AdminDetailsView < PageObject

    # Private elements
    #
    element(:act_as_link, {:partial_link_text => "Act as"})
    element(:activate_admin_link, {:link => "Activate Admin"})
    element(:new_pwd_txt, {:id => "new_password"})
    element(:pwd_confirm_txt, {:id => "new_password_confirmation"})
    element(:submit, {:xpath => "//div[starts-with(@id, 'admin-pass-change-')]/form//input[@value='Save Changes']"})

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
  end
end