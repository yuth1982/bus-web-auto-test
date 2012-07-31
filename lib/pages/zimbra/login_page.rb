module Zimbra
  # This class provides actions for zimbra logi page
  class LoginPage < PageObject
    # Private elements
    #
    element(:username_tb, {:id => "username"})
    element(:password_tb, {:id => "password"})
    element(:login_btn, {:xpath => "//input[@value='Log In']"})

    def login_as_default_account
      username_tb.type_text(Zimbra::USER_NAME)
      password_tb.type_text(Zimbra::PASSWORD)
      login_btn.click
    end
  end
end