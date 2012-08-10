module Zimbra
  # This class provides actions for zimbra logi page
  class LoginPage < PageObject

    # Private elements
    #
    element(:username_tb, {:id => "username"})
    element(:password_tb, {:id => "password"})
    element(:login_btn, {:xpath => "//input[@value='Log In']"})

    # Public: login zimbra mail main page
    #
    # Example
    #   @@zimbra_login_page.login(admin_object)
    #
    # Returns nothing
    def login(admin)
      username_tb.type_text(admin[:user_name])
      password_tb.type_text(admin[:password])
      login_btn.click
    end
  end
end