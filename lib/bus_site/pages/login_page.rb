
module Bus
  # This class provides actions for bus login page
  class LoginPage < SiteHelper::Page

    set_url("#{Bus::BUS_HOST}/login/admin?old_school=1")

    # Private elements
    #
    element(:username_tb, id: "username")
    element(:password_tb, id: "password")
    element(:login_btn, css: "span.login_button")
    element(:logout_btn, link: "LOG OUT")

    # Public: login bus admin console
    #
    # Example
    #   @bus_login_page.login(admin_object)
    #
    # Returns nothing
    def login(admin)
      username_tb.set(admin[:user_name])
      password_tb.set(admin[:password])
      login_btn.click
    end

    def logout
      logout_btn.click
    end
  end
end

