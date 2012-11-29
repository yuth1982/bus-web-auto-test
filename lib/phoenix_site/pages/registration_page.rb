module Phoenix
  class AddNewPhoenixPartner < SiteHelper::Page

    set_url("#{PHX_ENV['phx_host']}")

    # Private elements
    #
    # Select dom page
    #
    element(:country_select, id: "person_country")
    #
    # Admin Info Page
    # Entry points
    element(:new_admin_display_name_tb, id: "person_display_name")
    element(:new_admin_username_tb, id: "person_username")
    element(:new_admin_zip_tb, id: "person_zip")
    element(:new_admin_country_select, id: "person_country")
    element(:password_tb, id: "person_password")
    element(:reenter_password_tb, id: "person_password_confirmation")
    element(:mozypro_radio, id: "product_mozypro")
    element(:mozyhome_radio, id: "product_mozyhome")
    #
    # Labeled Elements
    element(:su_form_lbl, css: "div.center-form-box.vertical-align > h2")
    element(:name_lbl, css: "dt.input_label")
    element(:email_lbl, xpath: "//div[@id='main']/div/div/div/div/div[2]/div/div/form/dl/dt[2]")
    element(:password_lbl, xpath: "//div[@id='main']/div/div/div/div/div[2]/div/div/form/dl/dt[3]")
    element(:password_info_lbl, css: "span.field-info")
    element(:password_again_lbl, xpath: "//div[@id='main']/div/div/div/div/div[2]/div/div/form/dl/dt[4]")
    element(:country_lbl, xpath: "//div[@id='main']/div/div/div/div/div[2]/div/div/form/dl/dt[5]")
    element(:zip_post_code_lbl, xpath: "//div[@id='main']/div/div/div/div/div[2]/div/div/form/dl/dt[6]")
    element(:plan_note_lbl, css: "div.inner-center-form-box > form > p")
    element(:plan_choice_lbl, css: "dl.clear > dt")
    element(:home_supports_lbl, xpath: "//div[@id='main']/div/div/div/div/div[2]/p[2]")
    element(:pro_supports_lbl, xpath: "//div[@id='main']/div/div/div/div/div[2]/p[3]")
    #
    # Various elements
    element(:next_btn, id: "next-button")
    element(:continue_btn, css: "input.img-button")
    element(:back_btn, id: "back_button")
    element(:submit_btn, id: "submit_button")
    #	Public : fill out admin info
    #
    #	required: admin name - name of primary admin on acct
    #	required: email - email adddress for admin, becomes user name
    #	required: password - must be @ least 2 chars
    #	required: re-entry password - same password re-entered
    #	required: country - country for admin (usually same as dom)
    #	optional: zip - postal code for admin
    #
    #	Example
    #
    #		admin_info_fillout(partner)
    #
    #	Returns nothing

    #
    # page element verification
    #   code verifies availability (via items visibility for use)
    #   of all text/data entry and field label elements.
    def verify_registration_page_elements
      su_form_lbl.visible?
      name_lbl.visible?
      new_admin_display_name_tb.visible?
      email_lbl.visible?
      new_admin_username_tb.visible?
      password_lbl.visible?
      password_tb.visible?
      password_info_lbl.visible?
      password_again_lbl.visible?
      reenter_password_tb.visible?
      country_lbl.visible?
      new_admin_country_select.visible?
      zip_post_code_lbl.visible?
      new_admin_zip_tb.visible?
      plan_choice_lbl.visible?
      mozypro_radio.visible?
      mozyhome_radio.visible?
      plan_note_lbl.visible?
      home_supports_lbl.visible?
      pro_supports_lbl.visible?
      continue_btn.visible?
    end
    #		plan choice(partner)
    #     base on home / pro plan, select right radio
    #
    def plan_choice(partner)
      if partner.partner_info.type.eql?("MozyHome")
        mozyhome_radio.click
      else
        mozypro_radio.click
      end
    end

    #		acct admin info fill out(partner)
    #     fill out required admin info from partner.admin_info
    #
    def acct_admin_info_fill_out(partner)
      new_admin_display_name_tb.type_text(partner.admin_info.full_name)
      new_admin_username_tb.type_text(partner.admin_info.email)
      password_tb.type_text(CONFIGS['global']['test_pwd'])
      reenter_password_tb.type_text(CONFIGS['global']['test_pwd'])
      new_admin_country_select.select(partner.company_info.country)
      new_admin_zip_tb.type_text(partner.company_info.zip)
    end

    #		admin info fill out(partner)
    #     fill out admin page based on method call for info
    def admin_info_fill_out(partner)
      verify_registration_page_elements
      # admin info fill out
      acct_admin_info_fill_out(partner)
      # pro/home selection
      plan_choice(partner)
      continue_btn.click
    end
  end
end