module Bus
  # This class provides actions for partner details page section
  class PartnerDetailsSection < SiteHelper::Section

    # Private elements
    #
    element(:billing_info_link, link: "Billing Info")
    element(:act_as_link, link: "act as")
    element(:change_name_link, link: "Change Name")
    element(:delete_partner_link, link: "Delete Partner")
    element(:view_in_aria_link, link: "View in Aria")
    element(:export_to_excel_link, link: "Export to Excel (CSV)]")
    element(:create_api_key_link, link: '(create)')
    element(:api_key_text, xpath: '//fieldset//div[1]//span')
    element(:partner_id_text, xpath: "//div[starts-with(@id,'partner-show-')]/div/div[2]/dl[1]/dd[1]")

    # Delete partner hidden forms
    #
    element(:cancellation_submit_btn, xpath: "//div[starts-with(@id,'cancellation_reasons_')]//input[@value='Submit']")
    element(:delete_password_tb, xpath: "//div[starts-with(@id,'partner-show-') and contains(@id, '-delete_form')]//input[@name='password']")
    element(:delete_submit_btn, xpath: "//div[starts-with(@id,'partner-show-') and contains(@id, '-delete_form')]//input[@value='Submit']")

    # Public: Click act as partner link
    #
    # Example
    #   @bus_admin_console_page.partner_details_section.act_as_partner
    #
    # Returns nothing
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
      find_element(:xpath, "//div[@id='partner-show-#{partner_id}']//a[@class='mod-button'][1]").click
    end
  end
end