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
    #
    element(:new_admin_display_name_tb, id: "person_display_name")
    element(:new_admin_username_tb, id: "person_username")
    element(:new_admin_zip_tb, id: "person_zip")
    element(:new_admin_country_select, id: "person_country")
    element(:password_tb, id: "person_password")
    element(:reenter_password_tb, id: "person_password_confirmation")
    element(:mozypro_radio, id: "product_mozypro")
    element(:mozyhome_radio, id: "product_mozyhome")
    #
    # Various elements
    #
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
    def admin_info_fill_out(partner)
      new_admin_display_name_tb.type_text(partner.admin_info.full_name)
      new_admin_username_tb.type_text(partner.admin_info.email)
      password_tb.type_text(CONFIGS['global']['test_pwd'])
      reenter_password_tb.type_text(CONFIGS['global']['test_pwd'])
      new_admin_country_select.select(partner.company_info.country)
      new_admin_zip_tb.type_text(partner.company_info.zip)
      # need stub for pro/home selection
      if partner.partner_info.type.eql?("MozyHome")
          mozyhome_radio.click
      else
          mozypro_radio.click
      end
      continue_btn.click
    end
  end
end