module Phoenix
  class NewPartnerProDirectFillout < SiteHelper::Page

    set_url("#{PHX_ENV['phx_host']}/registration/business")

    #Country Select Page
    element(:country_select, id: "person_country")
    element(:continue_btn, css: "input.img-button")
    #Sign Up Page: Login Information
    element(:new_admin_display_name_tb, id: "admin_display_name")
    element(:new_admin_username_tb, id: "admin_username")
    element(:password_tb, id: "admin_password")
    element(:reenter_password_tb, id: "admin_password_confirmation")
    element(:new_partner_name, id: "partner_name")
    element(:new_contact_address, id: "contact_address")
    element(:new_contact_city, id: "contact_city")
    element(:new_contact_state_us, id: "contact_state_us")
    element(:new_contact_country, id: "contact_country")
    element(:new_contact_zip, id: "contact_zip")
    element(:new_contact_phone, id: "contact_phone")
    element(:new_partner_industry, id: "partner_industry")
    element(:new_partner_num_employees, id: "partner_num_employees")
    element(:new_responses, id: "responses")

    def select_country(partner)
      country_select.select(partner.company_info.country)
      continue_btn.click
    end

    def pro_fill_out(partner)
      new_admin_display_name_tb.type_text(partner.admin_info.full_name)
      new_admin_username_tb.type_text(partner.admin_info.email)
      password_tb.type_text(CONFIGS['global']['test_pwd'])
      reenter_password_tb.type_text(CONFIGS['global']['test_pwd'])
      new_partner_name.type_text(partner.company_info.name)

      new_contact_address.type_text(partner.company_info.address)
      new_contact_city.type_text(partner.company_info.city)
      new_contact_state_us.select(partner.company_info.state_abbrev)
      new_contact_country.select(partner.company_info.country)
      new_contact_zip.type_text(partner.company_info.zip)
      new_contact_phone.type_text(partner.company_info.phone)
      #I don't think these are important but if we want a case statement I can change it.
      new_partner_industry.select('Tech/Computer Related')
      new_partner_num_employees.select('6-20')
      new_responses.select('Radio')
      continue_btn.click
    end

  end
end