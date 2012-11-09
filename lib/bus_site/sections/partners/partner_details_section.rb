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
    element(:partner_root_role_change_link, xpath: "//span[starts-with(@id, 'partner-display-root-role')]/a")
    element(:partner_root_role_change_submit_btn, xpath: "//span[starts-with(@id, 'partner-change-root-role')]/input")
    element(:partner_root_role_change_dropdown, xpath: "//span[starts-with(@id, 'partner-change-root-role')]/select")

    # Delete partner hidden forms
    #
    element(:cancellation_submit_btn, xpath: "//div[starts-with(@id,'cancellation_reasons_')]//input[@value='Submit']")
    element(:delete_password_tb, xpath: "//div[starts-with(@id,'partner-show-') and contains(@id, '-delete_form')]//input[@name='password']")
    element(:delete_submit_btn, xpath: "//div[starts-with(@id,'partner-show-') and contains(@id, '-delete_form')]//input[@value='Submit']")

    # General information
    elements(:general_info_dls, xpath: "//div/dl")
    element(:stash_info_dl, xpath: "//div/dl/form")

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
    element(:contact_vat_tb, id: "vat_info_vat_number")

    # Account attribute table
    element(:account_attributes_table, css: "form#account_attributes_form table")

    # Resources table, for MozyPro
    element(:generic_resources_table, css: "form#generic_resources_form table")

    # License types table
    element(:license_types_table, xpath: "//div[starts-with(@id,'partner_license_types_')]/table")

    # Internal billing table
    element(:internal_billing_table, xpath: "//div[contains(@id,'internal-billing-content')]/table")

    # Subadmins
    element(:sub_admins_div, id: "subadminbox")
    element(:sub_admins_table, css: "div#subadminbox table")

    # Billing history
    element(:billing_history_table, css: "table.table-view")

    # Public: General information hash
    #
    #
    def general_info_hash
      output = general_info_dls[0].dt_dd_elements_text + general_info_dls[1].dt_dd_elements_text + stash_info_dl.dt_dd_elements_text.delete_if{ |pair| pair.first.empty?}
      Hash[*output.flatten]
    end

    # Public: Partner contact information hash
    #
    def contact_info_hash
      output = Hash[*contact_info_dls.map{ |el| el.dt_dd_elements_text.delete_if{ |pair| pair.first.empty?}}.delete_if{ |el| el.empty?}.flatten]
      output["Contact Address:"] = contact_address_tb.value
      output["Contact City:"] = contact_city_tb.value

      @state = ""
      case
        when contact_state_us_select.visible?
          @state = contact_state_us_select.first_selected_option.text
        when  contact_state_ca_select.visible?
          @state = contact_state_us_select.first_selected_option.text
        else
          @state = contact_state_select.value
      end
      output["Contact State:"] = @state

      output["Contact ZIP/Postal Code:"] = contact_zip_tb.value
      output["Contact Country:"] = contact_country_select.first_selected_option.text
      output["Phone:"] = contact_phone_tb.value
      output["Industry:"] = contact_industry_select.first_selected_option.text
      output["# of employees:"] = contact_employees_select.first_selected_option.text
      output["Contact Email:"] = contact_email_tb.value
      output["VAT Number:"] = contact_vat_tb.value unless output["VAT Number:"].nil?
      output
    end

    # Public: Partner Account attributes hash
    #
    # Example:
    #
    # Returns partner Account attributes hash
    def account_attributes_rows
      # Remove hidden column inside table
      account_attributes_table.rows_text.map{ |row| row[0..1] }
    end

    # Public: Generic resources table headers text
    #
    def generic_resources_table_headers
      generic_resources_table.headers_text
    end

    # Public: Generic resources table rows text
    #
    def generic_resources_table_rows
      # Remove hidden column inside table
      output = generic_resources_table.rows_text.map{ |row| row[0..3] }
      output[2] = output[2] + ['','']
      output
    end

    # Public: License types table headers text
    #
    #
    def license_types_table_headers
      license_types_table.headers_text
    end

    # Public: License types table rows text
    #
    #
    def license_types_table_rows
      license_types_table.rows_text
    end

    # Public: Internal billing tasub_admins_h4ble
    #
    #
    def internal_billing_table_rows
      internal_billing_table.rows_text
    end

    def sub_admins_text
      sub_admins_div.text
    end

    def sub_admins_table_headers
      sub_admins_table.headers_text
    end

    def sub_admins_table_rows
      sub_admins_table.rows_text
    end

    # Public: Billing history table headers text
    #
    #
    def billing_history_table_headers
      billing_history_table.headers_text
    end

    # Public: Billing history table rows text
    #
    #
    def billing_history_table_rows
      billing_history_table.rows_text
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
      wait_until{ delete_password_tb.visible? } # wait for load delete password div
      delete_password_tb.type_text(password)
      delete_submit_btn.click
      wait_until{ has_no_link?("Delete Partner") } # wait for delete partner
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

    def change_root_role(root_role)
      partner_root_role_change_link.click
      partner_root_role_change_dropdown.select(root_role)
      partner_root_role_change_submit_btn.click
    end
  end
end