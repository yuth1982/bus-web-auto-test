module Phoenix
  class NewPartnerFillout < SiteHelper::Page

    set_url("#{PHX_ENV['phx_host']}")
  
    # Private elements
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
    element(:contact_number_employees_select, id: "partner_num_employees")
    element(:contact_response_select, id: "responses")
    element(:reseller_link, id: "Sign up here.")
    #
    # Various elements
    #
    element(:next_btn, id: "next-button")
    element(:continue_btn, css: "input.img-button")
    element(:back_btn, id: "back_button")
    element(:submit_btn, id: "submit_button")
    #	Public : fill out partner info
    #
    #	required: partner name - company name
    #	required: address : location, city, state, country , post, zip
    #	required: question 1: partner industry
    #	optional: question 2: number employees
    #	optional: question 3: contact response (how did you hear about us?)
    #
    #	Example
    #
    #		admin_info_fillout('adminname', 'username', 'password', 'country', 'zip')
    #
    #	Returns nothing    def fill_out_partner_info(partner)
    def fill_out_partner_info(partner)
      new_partner_name_tb.type_text(partner.company_info.name)
      contact_address_tb.type_text(partner.company_info.address)
      contact_city_tb.type_text(partner.company_info.city)
      if partner.company_info.country.eql?("United States")
          contact_state_us_select.select(partner.company_info.state_abbrev)
        else
          contact_state_tb.type_text(partner.company_info.state)
      end
      contact_country_select.select(partner.company_info.country)
      contact_zip_tb.type_text(partner.company_info.zip)
      contact_phone_tb.type_text(partner.company_info.phone)
      #questionaire info
      contact_partner_industry_select.select("Financial Services")
      contact_number_employees_select.select("251-500")
      contact_response_select.select("Online Other")
      continue_btn.click
    end
  end
end