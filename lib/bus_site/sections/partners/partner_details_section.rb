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
    add_existence_checker(:stash_info_dl, xpath: "//div/dl/form")

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

    # Stash section
    element(:change_stash_link, xpath: "//a[contains(@onclick,'change_stash')]")
    element(:cancel_stash_link, xpath: "//a[contains(@onclick,'cancel_change')]")
    element(:stash_status_select, xpath: "//select[starts-with(@id,'partner-stash-status-')]")
    element(:stash_default_quota_tb, id: "stash_default_quota")
    element(:submit_stash_status_btn, xpath: "//input[contains(@onclick,'submit_stash_status')]")
    element(:add_stash_to_all_users_link, xpath: "//a[contains(@onclick,'enable_stash_for_all_confirm')]")
    element(:submit_delete_stash_btn, xpath: "//div[@class='popup-window-footer']/input[@value='Submit']")
    element(:cancel_delete_stash_btn, xpath: "//div[@class='popup-window-footer']/input[@value='Cancel']")
    element(:stash_status_span, xpath: "//span[starts-with(@id,'partner-display-stash-status-']")

    # Public: General information hash
    #
    # Example:
    #   partner_details_section.general_info_hash
    #   # => Hash table
    #   | ID:   | External ID: | Aria ID: | Approved:  | Status:         | Root Admin:            | Root Role:                  | Parent: | Next Charge:  | Marketing Referrals:             | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
    #   | 123456 | (change)    | 1234567  | 11/10/12   | Active (change) | test@mozy.com (act as) | SMB Bundle Limited (change) | MozyPro | 12/10/12      | test@mozy.com [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
    #
    # Returns hash table
    def general_info_hash
      output = general_info_dls[0].dt_dd_elements_text + general_info_dls[1].dt_dd_elements_text
      if has_stash_info_dl?
        stash = stash_info_dl.dt_dd_elements_text.delete_if{ |pair| pair.first.empty? }.map{ |row| [row.first, row[1..-1].join(' ')] }
        output = output + stash
      end
      Hash[*output.flatten]
    end

    # Public: Partner contact information hash
    #
    # Example:
    #   partner_details_section.contact_info_hash
    #   # => Hash table
    #   | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Industry: | # of employees: | Contact Email: |
    #   | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 |           |                 | test@mozy.com  |
    #
    # Returns hash table
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
    #   partner_details_section.account_attributes_rows
    #   # => "[["Backup Licenses", "200"], ["Backup License Soft Cap", "Enabled"], ["Server Enabled", "Disabled"], ["Cloud Storage (GB)", "10"], ["Stash Users:", ""], ["Default Stash Storage:", ""]]"
    #
    # Returns array
    def account_attributes_rows
      # Remove hidden column inside table
      account_attributes_table.rows_text.map{ |row| row[0..1] }
    end

    # Public: Generic resources table headers text
    #
    # Example:
    #   # => "["", "Used", "Allocated", "Limit"]"
    #
    # Return array
    def generic_resources_table_headers
      generic_resources_table.headers_text
    end

    # Public: Generic resources table rows text
    #
    # Example:
    #   # => "[["Backup Licenses", "0", "10", "200"], ["Cloud Storage (GB)", "0", "10", "10"], ["Server Enabled", "Disabled", "", ""]]"
    #
    # Returns array
    def generic_resources_table_rows
      # Remove hidden column inside table
      output = generic_resources_table.rows_text.map{ |row| row[0..3] }
      output[2] = output[2] + ['','']
      output
    end

    # Public: License types table headers text
    #
    # Example:
    #   # => "["", "Licenses:", "Licenses Used:", "Quota:", "Quota Used:", "Resource Policy:"]"
    #
    # Returns array
    def license_types_table_headers
      license_types_table.headers_text
    end

    # Public: License types table rows text
    #
    # Example:
    #   # => "[["Desktop", "100", "0", "2500 GB", "0 bytes", "Enabled"], ["Server", "0", "0", "0 GB", "0 bytes", "Enabled"]]"
    #
    # Returns array
    def license_types_table_rows
      license_types_table.rows_text
    end

    # Public: Internal billing table row text
    #
    # Example:
    #   # => "[["Account Type:", "Credit Card", "Current Period:", "Yearly"], ["Unpaid Balance:", "$0.00", "Collect On:", "N/A"], ["Renewal Date:", "11/19/13", "Renewal Period:", "Use Current Period"]]"
    #
    # Returns array
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
    #   partner_details_section.act_as_partner
    #
    # Returns nothing
    def act_as_partner
      act_as_link.click
    end

    # Public: Delete the current partner
    #
    # Example
    #   partner_details_section.delete_partner("test1234")
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

    # Public: Enable stash for a partner
    #
    # Example:
    #   # => partner_details_section.enable_stash
    #
    # Returns nothing
    def enable_stash(quota = 2)
      change_stash_link.click
      stash_status_select.select('Yes')
      stash_default_quota_tb.type_text(quota)
      submit_stash_status_btn.click
      wait_until{ !submit_stash_status_btn.visible? }
    end

    # Public: Disable stash for a partner
    #
    # Example:
    #   # => partner_details_section.disable_stash
    #
    # Returns nothing
    def disable_stash
      change_stash_link.click
      stash_status_select.select('No')
      submit_stash_status_btn.click
      submit_delete_stash_btn.click
      wait_until{ !submit_stash_status_btn.visible? }
    end

    # Public: Create the api_key
    #
    # Example
    #   partner_details_section.create_api_key
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