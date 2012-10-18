module Bus
  # This class provides actions for partner details page section
  class PartnerDetailsSection < SiteHelper::Section

    # Private elements
    #
    element(:billing_info_link, xpath: "//a[text()='Billing Info']")
    element(:act_as_link, xpath: "//a[text()='act as']")
    element(:change_name_link, xpath: "//a[text()='Change Name']")
    element(:delete_partner_link, xpath: "//a[text()='Delete Partner']")
    element(:view_in_aria_link, xpath: "//a[text()='View in Aria']")
    element(:export_to_excel_link, xpath: "//a[text()='Export to Excel (CSV)']")
    element(:create_api_key_link, xpath: "//a[text()='(create)']")
    element(:api_key_text, xpath: '//fieldset//div[1]//span')
    element(:partner_id_text, xpath: "//div[starts-with(@id,'partner-show-')]/div/div[2]/dl[1]/dd[1]")

    # Delete partner hidden forms
    #
    element(:cancellation_submit_btn, xpath: "//div[starts-with(@id,'cancellation_reasons_')]//input[@value='Submit']")
    element(:delete_password_tb, xpath: "//div[starts-with(@id,'partner-show-') and contains(@id, '-delete_form')]//input[@name='password']")
    element(:delete_submit_btn, xpath: "//div[starts-with(@id,'partner-show-') and contains(@id, '-delete_form')]//input[@value='Submit']")

    # General information
    elements(:general_info_dls, xpath: "//div/dl")
    # Contact information
    elements(:contact_info_dls, xpath: "//div/form/dl")
    element(:contact_address_tb, id: "contact_address")
    element(:contact_city_tb, id: "contact_city")
    element(:contact_state_select, id: "contact_state")
    element(:contact_state_us_select, id: "contact_state_us")
    element(:contact_state_ca_select, id: "contact_state_ca")
    element(:contact_zip_tb, id: "contact_zip")
    element(:contact_country_select, id: "contact_country")
    element(:contact_phone_tb, id: "partner_contact_phone")
    element(:contact_industry_select, id: "partner_industry")
    element(:contact_employees_select, id: "partner_num_employees")
    element(:contact_email_tb, id: "contact_email")

    def general_info_hash
      delete_partner_link.visible?
      output = {}
      general_info_dls[0..-2].map{ |dl| output = output.merge(dl.dl_hashes) }
      output
    end

    # Public: Partner contact information hash
    #
    def contact_info_hash
      delete_partner_link.visible?
      output = {}
      contact_info_dls.map{ |dl| output = output.merge(dl.dl_hashes) }
      output["Contact Address:"] = contact_address_tb.value
      output["Contact City:"] = contact_city_tb.value
      output["Contact State:"] = contact_state_us_select.first_selected_option.text
      output["Contact ZIP/Postal Code:"] = contact_zip_tb.value
      output["Contact Country:"] = contact_country_select.first_selected_option.text
      output["Phone:"] = contact_phone_tb.value
      output["Industry:"] = contact_industry_select.first_selected_option.text
      output["# of employees:"] = contact_employees_select.first_selected_option.text
      output["Contact Email:"] = contact_email_tb.value
      output.delete_if { |k, _| k.empty? }
    end
    # Public: Click act as partner link
    #
    # Example
    #   @bus_admin_console_page.partner_details_section.act_as_partner
    #
    # Returns nothing                ""
    def act_as_partner
      act_as_link.click
    end

    # Public: Delete the current partner
    #
    # Example
    #   @bus_admin_console_page.partner_details_section.delete_partner("test1234")
    #
    # Returns nothing
    def delete_partner(password)
      delete_partner_link.click
      cancellation_submit_btn.click
      sleep 2 # wait for load delete password div
      delete_password_tb.type_text(password)
      delete_submit_btn.click
      sleep 5 # wait for delete partner
    end

    # Public: Create the api_key
    #
    # Example
    #   @bus_admin_console_page.partner_details_section.create_api_key
    #
    # Returns nothing
    def create_api_key
      if page.has_link?('(create)')
        create_api_key_link.click
      end
    end

    def get_api_key
      unless page.has_link?('(delete)')
        Log.debug('create')
        create_api_key_link.click
      end
      if page.has_link?('(delete)')
        api_key = api_key_text.text[0..-10].strip
      end
    end

    def get_partner_id
      partner_id_text.text
    end

    def close_partner_detail_section_by_id(partner_id)
      find(:xpath, "//div[@id='partner-show-#{partner_id}']//a[@class='mod-button'][1]").click
    end
  end
end