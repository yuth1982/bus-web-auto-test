module Aria
  # This class provides actions for aira login page
  class LoginPage < SiteHelper::Page

    set_url(ARIA_ENV['host'])

    # Private elements
    #
    element(:username_tb, id: 'username')
    element(:password_tb, id: 'password')
    element(:login_btn, css: "input[value='Login']")

    # Public: Login aria admin console
    #
    # username - Aria admin console login user name
    # password - Aria admin console login password
    #
    # Example
    #   login('username', 'password')
    #
    # Returns nothing
    def login(username, password)
      username_tb.type_text(username)
      password_tb.type_text(password)
      login_btn.click
    end
  end
end

