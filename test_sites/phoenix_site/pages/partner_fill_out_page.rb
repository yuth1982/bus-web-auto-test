#!/bin/env ruby
# encoding: utf-8

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

    # Public method for selecting specific items based on locale
    # method requires the following:
    # selection item - ideally a selection list
    # @partner - partner specific info, namely country/partner type
    # localize item to select - label localized for language to be specifically selected.
    def localized_select(loc_item, partner, loc_select)
      loc_item.select("#{LANG[partner.company_info.country][partner.partner_info.type][loc_select]}")
    end

    # public method for clicking specific items based on locale
    # method requires the following:
    # @partner - partner specific info, namely country/partner type
    # localize item to click - label localized for language to be specifically selected.
    def localized_click(partner, loc_click)
      navigate_to_link("#{LANG[partner.company_info.country][partner.partner_info.type][loc_click]}")
    end

    # public : survey response methods
    # methods for filling out responses required for phoenix registration
    # response entries called from a yaml file and are localized.
    # format for reference #{<yaml-filename>[<country-reference>][<survey-item-reference>]}
    def survey_industry(partner)
      localized_select(contact_partner_industry_select, partner, 'survey_industry')
      # contact_partner_industry_select.select("#{LANG[partner.company_info.country][partner.partner_info.type]['survey_industry']}")
    end

    def survey_employees(partner)
      localized_select(contact_number_employees_select, partner, 'survey_num_employees')
      # contact_number_employees_select.select("#{LANG[partner.company_info.country][partner.partner_info.type]['survey_num_employees']}")
    end

    def survey_contact_response(partner)
      localized_select(contact_response_select, partner, 'survey_contact_res')
      # contact_response_select.select("#{LANG[partner.company_info.country][partner.partner_info.type]['survey_contact_res']}")
    end

    # Public : fill out partner info
    #
    # required: partner name - company name
    # required: address : location, city, state, country , post, zip
    # required: question 1: partner industry
    # optional: question 2: number employees
    # optional: question 3: contact response (how did you hear about us?)
    #
    # Example
    #
    #   admin_info_fillout('adminname', 'username', 'password', 'country', 'zip')
    #
    # Returns nothing    def fill_out_partner_info(partner)
    def fill_out_partner_info(partner)
      new_partner_name_tb.type_text(partner.company_info.name)
      contact_address_tb.type_text(partner.company_info.address)
      contact_city_tb.type_text(partner.company_info.city)
      if partner.company_info.country.eql?("United States")
          contact_state_us_select.select(partner.company_info.state_abbrev)
        else
          contact_state_tb.type_text(partner.company_info.state)
      end
      if partner.company_info.country.eql?("Germany")
        contact_country_select.select("Deutschland")
      else
        contact_country_select.select(partner.company_info.country)
      end
      contact_zip_tb.type_text(partner.company_info.zip)
      contact_phone_tb.type_text(partner.company_info.phone)
      #questionaire info
      #case statement keying on country, based on that selecting specific values from the survey drop down
      survey_industry(partner)
      survey_employees(partner)
      survey_contact_response(partner)
      continue_btn.click
    end
  end
end