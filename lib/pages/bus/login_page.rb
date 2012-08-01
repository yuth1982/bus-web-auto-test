module Bus
  # This class provides actions for bus login page
  class LoginPage < PageObject

    # Private elements
    #
    element(:username_tb, {:id => "username"})
    element(:password_tb, {:id => "password"})
    element(:login_btn, {:css => "span.login_button"})

    # Public: login bus admin console
    #
    # Example
    #   @bus_login_page.login(admin_object)
    #
    # Returns nothing
    def login(admin)
      username_tb.type_text(admin[:user_name])
      password_tb.type_text(admin[:password])
      login_btn.click
    end
  end
end

