module Phoenix
  class AddNewPhoenixPartner

    # set_url("#{PHX_ENV['host']}")

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
    #
    # Partner Company Info Page
    #
    element(:new_partner_name_tb, id: "partner_name")
    element(:contact_address_tb, id: "contact_address")
    element(:contact_city_tb, id: "contact_city")
    element(:contact_country_select, id: "contact_country")
    element(:contact_state_tb, id: "contact_state")
    element(:contact_state_us_select, id: "contact_state_us")
    element(:contact_zip_tb, id: "contact_zip")
    element(:contact_phone_tb, id: "contact_phone")
    element(:contact_partner_industry_select, id: "partner_industry")
    element(:contact_number_elpoyees_select, id: "partner_num_employees")
    element(:contact_response_select, id: "responses")
    #
    # Licensing Page Info
    #
    element(:interval_radio, id: "id=interval_")
    element(:vat_number_tb, id: "vat_num")
    element(:coupon_code_tb, id: "promo_code")
    #
    # Credit Card Info
    #
    element(:cc_type_select, id: "cc_type")
    element(:cc_no_tb, id: "cc_no")
    element(:cvv_tb, id: "cvv")
    element(:cc_exp_mm_select, id: "cc_exp_mm")
    element(:cc_exp_yyyy_select, id: "cc_exp_yyyy")
    element(:cc_first_name_tb, id: "cc_first_name")
    element(:cc_last_name_tb, id: "cc_last_name")
    element(:cc_company_tb, id: "cc_company")
    #
    # Billing Info
    #
    element(:use_company_info_cb, id: "use_company_info")
    element(:cc_address_tb, id: "cc_address")
    element(:cc_country_select, id: "cc_country")
    element(:cc_state_tb, id: "cc_state")
    element(:cc_state_us_select, id: "cc_state_us")
    element(:cc_state_ca_select, id: "cc_state_ca")
    element(:cc_city_tb, id: "cc_city")
    element(:cc_email_tb, id: "cc_email")
    element(:cc_phone_tb, id: "cc_phone")
    element(:cc_zip_tb, id: "cc_zip")
    #
    # Various elements
    #
    element(:next_btn, id: "next-button")
    elemnet(:continue_btn, css: "input.img-button")
    element(:message_div, xpath: "//div[@id='partner-new-errors']/ul")
    element(:back_btn, id: "back_button")

    #	Public : select dom
    #
    #	required: person_country - country for user/partner, controls dom
    #
    #	Example
    #
    #		select_country('dom')
    #
    #	Returns nothing
    def select_country(country)
      country_select.select(country)
      continue_btn.click
    end

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
    #		admin_info_fillout('adminname', 'username', 'password', 'country', 'zip')
    #
    #	Returns nothing
    def admin_info_fill_out(adminname, username, password, country, zip)
      new_admin_display_name_tb.type_text(adminname)
      new_admin_username_tb.type_text(username)
      password_tb.type_text(password)
      reenter_password_tb.type_text(password)
      new_admin_country_select.select(country)
      new_admin_zip_tb.type_text(zip)
      continue_btn.click
    end

    def navigate_to_link(link)
      find_link(link).click
    end

  end
end