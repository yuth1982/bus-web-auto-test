module Bus
  # This class provides actions for bus login page
  class UserPartnerIDLoginPage < SiteHelper::Page

    # Private elements
    element(:username_tb, id: "username")
    element(:password_tb, id: "password")
    element(:home_login_btn, css: "input.img-button")
    element(:login_btn, css: "span.login_button")
    element(:restore_link, xpath: "//a[contains(text(),'Restore Files')]")
    element(:ent_restore_link, css: "i.icon-folder-open-alt.icon-2x")
    element(:username_freyja, css: "span.text.username")
    element(:set_dialect_select, id: "set_dialect")


    attr_accessor :pid , :partner_type

    # type could be ladp, horizon or mozy
    def initialize(pid, partner_type)
      @pid = pid
      @partner_type = partner_type
      case @partner_type
        when 'home'
          self.class.set_url("https://www.mozypro.com/login/")
        else
          self.class.set_url("https://www.mozypro.com/login/user?pid="+@pid)
      end
    end


    def user_login(username, password)
      username_tb.type_text(username)
      password_tb.type_text(password)
      login_btn.click
    end

    def login_verify
      username_freyja.visible?
    end


  end
end