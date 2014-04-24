module Freyja
  # This class provides actions for freyja login page
  class LoginPage < SiteHelper::Page
    def initialize(partnertype = 'MozyHome')
      @partnertype = partnertype
      case @partnertype
        when 'MozyHome'
          self.class.set_url("#{QA_ENV['freyja_home_host']}/login")
        when 'MozyPro'
          self.class.set_url("#{QA_ENV['freyja_pro_host']}")
        when 'MozyEnterprise'
          self.class.set_url("#{QA_ENV['freyja_ent_host']}")
        when 'OEM'
          self.class.set_url("#{QA_ENV['freyja_oem_host']}")
          end
    end

    # Private elements
    element(:username_tb, id: "username")
    element(:password_tb, id: "password")
    element(:home_login_btn, css: "input.img-button")
    element(:login_btn, css: "span.login_button")
    element(:user_btn, id: "menu-user")
    element(:restore_files_link, xpath: "//a[text()='Restore Files']")
    element(:restore_files_icon, xpath: "//a[@title='Restore Files']")
    element(:access_files_link, xpath: "//a[text()='Access Files']")

    # Public: Login freyja
    #
    # username - Freyja login username
    # password - Freyja login password
    #
    # Example
    #   @freyja_site.login_page.login('username', 'password')
    #
    # Returns nothing
    def login(username, password)
      username_tb.type_text(username)
      password_tb.type_text(password)
      case @partnertype
        when 'MozyHome'
          home_login_btn.click
        when 'MozyPro'
          login_btn.click
          restore_files_link.click
        when 'MozyEnterprise'
          login_btn.click
          restore_files_icon.click
        when 'OEM'
          login_btn.click
          access_files_link.click
      end
    end

    # Public: Check if user menu is present (implies user is logged in)
    #
    # @param none
    #
    # Example
    #   @freyja_site.login_page.logged_in
    #
    # @return [Boolean]
    def logged_in
      user_btn.visible?
    end

    # Public: Check if login button exist
    #
    # @param none
    #
    # Example
    #   @freyja_site.login_page.logged_in
    #
    # @return [Boolean]
    def login_button_visible
      case @partnertype
        when 'MozyHome'
          home_login_btn.visible?
        else
          login_btn.visible?
      end
    end

  end
end

