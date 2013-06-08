#!/bin/env ruby
# encoding: utf-8

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
    element(:start_using_mozy, id: "btn_start_using")
    # adding a few items for quick and dirty acct verification, if items present and value good - acct=good.
    # additional verification being done @ admin level in admin console
    element(:h3_section, css: "h3") # partner detail info section
    element(:partner_server_setting, css: "span.partner_generic_resource_shown.info")
    element(:h4_section, css: "h4") # renewal heading in billing info
    element(:bill_info_plan_amnt, css: "strong") # billing info - plan size in bold
    element(:man_resource_plan_size, css: "span.value") # manage resources section - 'total account storage'
    element(:man_resource_server_value , xpath: "//div[@id='resource-available_key_list-content']/div[2]/div[3]/div/span[6]") # manage resources section "server enabled" value
    #
    # Public : reg complete banner visible
    #
    # required: nothing
    #
    # Example
    #
    #   xx('yy')
    #
    # Returns nothing
    def navigate_to_link(link)
      find_link(link).click
    end

    # public method for clicking specific items based on locale
    # method requires the following:
    # @partner - partner specific info, namely country/partner type
    # localize item to click - label localized for language to be specifically selected.
    def localized_click(partner, loc_click)
      navigate_to_link("#{LANG[partner.company_info.country][partner.partner_info.type][loc_click]}")
    end

    def logout(partner)
      localized_click(partner, 'logout')
    end
    # pro section
    # code here relates
    # to mozypro related items

    def partner_created(partner)
      find_link(partner.company_info.name).present?
    end

    def go_to_partner_info(partner)
      navigate_to_link(partner.company_info.name)
    end

    def reg_comp_banner_present
      reg_comp_banner.present?
    end

    def reg_comp_text
      reg_comp_banner_txt.present?
    end

    # partner info verification - if specific values are present, section should be good
    # additional verification being done @ admin level in admin console
    def partner_info_section(partner)
      go_to_partner_info(partner)
      h3_section.eql?(partner.company_info.name).present?
      partner_server_setting.eql?(partner.has_server_plan).present?
    end

    # billing info verification - if specific values are present, section should be good
    # additional verification being done @ admin level in admin console
    def billing_info_section(partner)
      localized_click(partner, 'bill_info')
      h4_section.present?
      bill_info_plan_amnt.eql?(partner.base_plan).present?
    end

    # manage resources info verification - if specific values are present, section should be good
    # additional verification being done @ admin level in admin console
    def manage_resources_section(partner)
      localized_click(partner, 'man_res')
      man_resource_plan_size.eql?(partner.base_plan).present?
      man_resource_server_value.eql?(partner.has_server_plan).present?
    end

    # pro registration complete
    def reg_complete(partner)
      reg_comp_banner_present
      localized_click(partner, 'go_to_acct')
#      start_using_mozy.click
      #localized_click(partner, 'start_using_mozy')
      partner_created(partner)
      localized_click(partner, 'logout')
    end

    # home section
    # code here relates
    # to mozyhome related items

    def reg_get_started
      reg_get_started_txt.present?
    end

    def reg_referral_banner
      reg_referral_txt.present?
    end

    # here we check for windows and both mac client download buttons
    def reg_home_dl_buttons
      reg_dl_win_btn.present?
      reg_dl_mac_btn.present?
      reg_dl_mac2_btn.present?
    end

    # home registration complete
    def home_success(partner)
      reg_comp_banner_present
      reg_comp_text
      reg_get_started
      reg_referral_banner
      reg_home_dl_buttons
      localized_click(partner, 'acct_page_link')
      reg_comp_banner_present
      localized_click(partner, 'resend_verify_email_link')
      localized_click(partner, 'back_2_login_link')
      #logout(partner)
    end

    # user/partner verification section
    # code here relates to
    # partner/user verification
    def new_partner_verify(partner)
      partner_created(partner)
      partner_info_section(partner)
      billing_info_section(partner)
      manage_resources_section(partner)
    end
  end
end