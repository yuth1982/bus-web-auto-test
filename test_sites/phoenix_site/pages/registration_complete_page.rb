module Phoenix
  # This class provides actions for phoenix registration page
  class NewRegistrationComplete < SiteHelper::Page

    set_url("#{PHX_ENV['phx_host']}/registration")

    # Private elements
    #
    # Main elements within registration complete frame
    #
	element(:reg_comp_center_form, css: "div.center-form-container")
	element(:reg_comp_inner_center_form, css: "div.inner-center-form-box")
	element(:reg_comp_banner, css: "div.center-form-box > h2")
	element(:reg_comp_banner_txt, css: "div.inner-center-form-box > p")
	element(:reg_comp_txt_par_1, xpath: "//div[@id='main']/div/div/div/div/div[2]/div/div/p[2]")
	element(:reg_comp_txt_par_2, xpath: "//div[@id='main']/div/div/div/div/div[2]/div/div/p[3]")
    # home specific - may be related
  element(:reg_get_started_txt, xpath: "//div[@id='main']/div/div/div/div/div[2]/div/div/p[2]")
  element(:reg_referral_txt, css: "div.referrer-info > p")
  element(:reg_dl_win_btn, xpath: "//input[@value='Download for Win']")
  element(:reg_dl_mac_btn, xpath: "//input[@value='Download for Mac']")
  element(:reg_dl_mac2_btn, xpath: "(//input[@value='Download for Mac'])[2]")
  element(:logout_btn, xpath: "//a[text()='LOG OUT']")
  #element(:go_to_acct_lnk, link: "Go to Account")
    #
    #	Public : reg complete banner visible
    #
    #	required: nothing
    #
    #	Example
    #
    #		xx('yy')
    #
    #	Returns nothing
    def navigate_to_link(link)
      find_link(link).click
    end

    def partner_created(partner)
      find_link(partner.company_info.name).present?
    end

    def reg_comp_banner_present
      reg_comp_banner.present?
    end

    def reg_comp_text
      reg_comp_banner_txt.present?
    end

    def reg_get_started
      reg_get_started_txt.present?
    end

    def reg_referral_banner
      reg_referral_txt.present?
    end

    def reg_home_dl_buttons
      reg_dl_win_btn.present?
      reg_dl_mac_btn.present?
      reg_dl_mac2_btn.present?
    end

    def logout
      logout_btn.click
    end

    def reg_complete(partner)
      reg_comp_banner_present
      navigate_to_link("Go to Account")
      find_link("Don't Show This Again").click
      # couldn't get reference for admin_console_page.close_stash_invitation_popup correct, used above as temporary
      partner_created(partner)
      logout
    end

    def home_success(partner)
      reg_comp_banner_present
      reg_comp_text
      reg_get_started
      reg_referral_banner
      reg_home_dl_buttons
      find_link("account page").click
      reg_comp_banner_present
      find_link("Resend").click
      find_link("Back to Login Page").click
      logout
    end
  end
end