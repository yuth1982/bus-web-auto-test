module Freyja

  class LoginPage < SiteHelper::Page

    element(:username_tb, id: "username")
    element(:password_tb, id: "password")
    element(:home_login_btn, css: "input.img-button")
    element(:login_btn, css: "span.login_button")
    element(:restore_link, xpath: "//a[contains(text(),'Restore Files')]")
    element(:ent_restore_link, css: "i.icon-folder-open-alt.icon-2x")
    element(:username_freyja, css: "span.text.username")

    # Public: open login page
    #
    # Example
    #   @freyja_site.login_page.load
    #
    # Returns nothing
    def initialize(user)
      partnerType = user.partnerType
      keyType = user.keyType
      case  keyType
        when  'private_key'
          case partnerType
            when 'home'
              self.class.set_url("#{QA_ENV[partnerType+'_url_'+keyType]}/login")
            else
              self.class.set_url("#{QA_ENV[partnerType+'_url_'+keyType]}")
          end
        when  'ckey'
          case partnerType
            when 'home'
              self.class.set_url("#{QA_ENV[partnerType+'_url_'+keyType]}/login")
            else
              self.class.set_url("#{QA_ENV[partnerType+'_url_'+keyType]}")
          end
        else
          case partnerType
            when 'home'
              self.class.set_url("#{QA_ENV[partnerType+'_url']}/login")
            else
              self.class.set_url("#{QA_ENV[partnerType+'_url']}")
          end
      end
    end

    # Public: enter username and password, click to confirm
    #
    # Example
    #   @freyja_site.login_page.UserLogin(user)
    #
    # Returns nothing
    def UserLogin(user)
      username_tb.type_text(user.username)
      password_tb.type_text(user.password)
      partnerType = user.partnerType
      case partnerType
        when 'home'
          home_login_btn.click
        when 'pro'
          login_btn.click
          ent_restore_link.click
        when 'ent'
          login_btn.click
          ent_restore_link.click
        when 'oem'
          login_btn.click
          ent_restore_link.click
      end
    end

    def login_verify
      username_freyja.visible?
    end

  end

end