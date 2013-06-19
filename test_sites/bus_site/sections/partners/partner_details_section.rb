module Bus
  # This class provides actions for partner details page section
  class PartnerDetailsSection < SiteHelper::Section

    # Private elements
    #
    element(:msg_div, css: 'ul.flash.successes')
    element(:billing_info_link, xpath: "//a[text()='Billing Info']")
    element(:act_as_link, xpath: "//a[text()='act as']")
    element(:change_name_link, xpath: "//a[text()='Change Name']")
    element(:delete_partner_link, xpath: "//a[text()='Delete Partner']")
    element(:view_in_aria_link, xpath: "//a[text()='View in Aria']")
    element(:export_to_excel_link, xpath: "//a[text()='Export to Excel (CSV)']")

    # Change partner external id
    element(:external_id_tb, id: 'external_id')
    element(:change_external_id_link, css: 'dd.view>form>span.view a')
    element(:cancel_external_id_link, css: 'dd.edit>form>span.edit a')
    element(:submit_external_id_btn, css: 'dd.edit>form>span.edit input[value=Submit]')

    # Change partner status
    element(:change_status_link, css: 'span[id^=partner-display-status-] a')
    element(:change_status_select, css: 'span[id^=partner-change-status-] select')
    element(:submit_change_status_btn, css: 'span[id^=partner-change-status-] input')
    element(:cancel_change_status_link, css: 'span[id^=partner-change-status-] a')

    # Change partner root role
    element(:partner_root_role_change_link, css: 'span[id^=partner-display-root-role] a')
    element(:partner_root_role_type_select, css: 'span[id^=partner-change-root-role] select')
    element(:partner_root_role_submit_btn, css: 'span[id^=partner-change-root-role] input')
    element(:partner_root_role_cancel_btn, css: 'span[id^=partner-change-root-role] a')

    # General information
    elements(:general_info_dls, css: 'div>dl')
    element(:stash_info_dl, css: 'div>dl>form')

    # Contact information
    elements(:contact_info_dls, css: 'div>form>dl')
    element(:contact_address_tb, id: 'contact_address')
    element(:contact_city_tb, id: 'contact_city')
    element(:contact_state_select, id: 'contact_state')
    element(:contact_state_us_select, id: 'contact_state_us')
    element(:contact_state_ca_select, id: 'contact_state_ca')
    element(:contact_zip_tb, id: 'contact_zip')
    element(:contact_country_select, id: 'contact_country')
    element(:contact_phone_tb, id: 'partner_contact_phone')
    element(:contact_industry_select, id: 'partner_industry')
    element(:contact_employees_select, id: 'partner_num_employees')
    element(:contact_email_tb, id: 'contact_email')
    element(:contact_vat_tb, id: 'vat_info_vat_number')
    element(:save_changes_btn, css: 'input.button')

    # API Key
    element(:api_key_div, css: 'div[id^=api-key-box-] fieldset div:nth-child(1)')
    element(:create_or_delete_api_key_link, css: 'div[id^=api-key-box-] fieldset div:nth-child(1) a')
    element(:ip_whitelist_div, css: 'div[id^=api-key-box-] fieldset div:nth-child(2)')

    # Account attribute table
    element(:account_attributes_table, css: 'form[id^=account_attributes_form] table')

    # Pooled Storage
    element(:pooled_resources_table, css: 'form[id^=pooled_resources_form] table')

    # Resources table, for MozyPro
    element(:generic_resources_table, css: 'form[id^=generic_resources_form] table')

    # Pooled Resources table, for Pooled partner
    element(:pooled_resources_table, css: 'form[id^=pooled_resources_form] table')

    # License types table
    element(:license_types_table, css: 'div[id^=partner_license_types] table')

    # Stash table
    element(:stash_info_table, css: 'div.show-details>table.form-box2')

    # Internal billing table
    element(:internal_billing_table, css: 'div[id$=internal-billing-content] table')

    # Subadmins
    element(:sub_admins_div, id: 'subadminbox')
    element(:sub_admins_table, css: 'div#subadminbox table')

    # Billing history
    element(:billing_history_table, css: 'table.table-view')

    # Stash section
    element(:change_stash_link, css: 'a[onclick*=change_stash]')
    element(:cancel_stash_link, css: 'a[onclick*=cancel_change]')
    element(:stash_status_select, css: 'select[id^=partner-stash-status-]')
    element(:submit_stash_status_btn, css: 'input[onclick*=submit_stash_status]')
    element(:add_stash_to_all_users_link, css: 'a[onclick*=enable_stash_for_all_confirm]')

    #autogrow section
    element(:change_autogrow_status_link, css: 'a[onclick*=partner-display-overdraft-status]')
    element(:autogrow_status_select, css: 'select[id^=overdraft_status]')
    element(:submit_autogrow_status_btn, css: 'span[id^=partner-change-overdraft-status-] input[value=Submit]')

    # Subdomain
    element(:change_subdomain_link, css: "a[onclick*='/partner/subdomain']")

    # Public: Partner Id
    #
    # Return string
    def partner_id
      general_info_hash['ID:']
    end

    def partner
      { :id => general_info_hash['ID:'],
        :name => find(:css, "div.header-bar > h3").text }
    end

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
      wait_until_bus_section_load
      output = general_info_dls[0,2].inject([]){ |sum, dls| sum + dls.dt_dd_elements_text}
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
      wait_until_bus_section_load
      output = Hash[*contact_info_dls.map{ |el| el.dt_dd_elements_text.delete_if{ |pair| pair.first.empty?}}.delete_if{ |el| el.empty?}.flatten]
      output['Contact Address:'] = contact_address_tb.value
      output['Contact City:'] = contact_city_tb.value

      @state = ""
      case
        when contact_state_us_select.visible?
          @state = contact_state_us_select.first_selected_option.text
        when  contact_state_ca_select.visible?
          @state = contact_state_ca_select.first_selected_option.text
        else
          @state = contact_state_select.value
      end
      output['Contact State:'] = @state

      output['Contact ZIP/Postal Code:'] = contact_zip_tb.value
      output['Contact Country:'] = contact_country_select.first_selected_option.text
      output['Phone:'] = contact_phone_tb.value
      output['Industry:'] = contact_industry_select.first_selected_option.text
      output['# of employees:'] = contact_employees_select.first_selected_option.text
      output['Contact Email:'] = contact_email_tb.value
      output['VAT Number:'] = contact_vat_tb.value unless output['VAT Number:'].nil?
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

    def pooled_resource_table_rows
      pooled_resources_table.rows_text
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

    # Public: Stash info table row text
    #
    # Returns array
    def stash_info_table_rows
      stash_info_table.rows_text
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

    # Public: Sub admins text
    #
    # Return string
    def sub_admins_text
      sub_admins_div.text
    end

    # Public: Sub admins table headers text
    #
    # Returns array
    def sub_admins_table_headers
      sub_admins_table.headers_text
    end

    # Public: Sub admins table rows text
    #
    # Returns array
    def sub_admins_table_rows
      sub_admins_table.rows_text
    end

    # Public: Billing history hashes
    #         Converts results table into an Array of Hash where the keys of each Hash are the headers in the table.                                                                                               # Example
    #
    #  @bus_admin_console_page.partner_details_section.billing_history_hashes
    #
    # Returns hash array
    def billing_history_hashes
      billing_history_table.rows_text.map{ |row| Hash[*billing_history_table.headers_text.zip(row).flatten] }
    end

    # Public: Click act as partner link
    #
    # Example
    #   @bus_site.admin_console_page.partner_details_section.act_as_partner
    #
    # Returns nothing
    def act_as_partner
      act_as_link.click
    end

    # Public: Delete the current partner
    #
    # Example
    #   @bus_site.admin_console_page.partner_details_section.delete_partner("test1234")
    #
    # Returns nothing
    def delete_partner(password, expect_pass = true)
      wait_until_bus_section_load
      delete_partner_link.click

      submit_btn = find(:css, 'div[id^=cancellation_reasons_] input[value=Submit]')
      password_tb = find(:css, 'div[id$=-delete_form] input[name=password]')
      submit_delete_btn = find(:css, 'div[id$=-delete_form] input[name=commit]')

      submit_btn.click
      wait_until{ password_tb.visible? } # wait for load delete password div
      password_tb.type_text(password)
      submit_delete_btn.click
      if expect_pass
        wait_until{ has_no_link?("Delete Partner") } # wait for delete partner
      else
        return_text = alert_text
        alert_accept
        cancel_btn = find(:xpath, "//a[text() = 'Cancel']")
        cancel_btn.click
        return_text
      end
    end

    # Public: Enable stash for a partner
    #
    # Example:
    #   @bus_site.admin_console_page.partner_details_section.enable_stash
    #
    # Returns nothing
    def enable_stash
      change_stash_link.click
      stash_status_select.select('Yes')
      submit_stash_status_btn.click
      wait_until_bus_section_load
    end

    # Public: Disable stash for a partner
    # Note: Still Need to click submit button on popup window
    #
    # Example:
    #   @bus_site.admin_console_page.partner_details_section.disable_stash
    #
    # Returns nothing
    def disable_stash
      change_stash_link.click
      stash_status_select.select('No')
      submit_stash_status_btn.click
      wait_until_bus_section_load
    end

    # Public: Enable autogrow for a partner
    #
    # Example:
    #   @bus_site.admin_console_page.partner_details_section.enable_autogrow
    #
    # Returns nothing
    def enable_autogrow
      change_autogrow_status_link.click
      autogrow_status_select.select('Yes')
      submit_autogrow_status_btn.click
      wait_until{ success_messages == "Overdraft protection enabled." }
    end

    # Public: Disable autogrow for a partner
    #
    # Example:
    #   @bus_site.admin_console_page.partner_details_section.disable_autogrow
    #
    # Returns nothing
    def disable_autogrow
      change_autogrow_status_link.click
      autogrow_status_select.select('No')
      submit_autogrow_status_btn.click
      wait_until{ success_messages == "Overdraft protection disabled." }
    end

    # Public: Add stash to all users
    #
    # Example:
    #   @bus_site.admin_console_page.partner_details_section.add_stash_to_all_users
    #
    # Returns nothing
    def add_stash_to_all_users
      add_stash_to_all_users_link.click
    end

    # Public: Change partner root role
    #
    # Example:
    #   @bus_site.admin_console_page.partner_details_section.change_root_role('Enterprise')
    #
    # Returns nothing
    def change_root_role(root_role)
      partner_root_role_change_link.click
      partner_root_role_type_select.select(root_role)
      partner_root_role_submit_btn.click
    end

    # Public: Create API Key
    # Skipped, ff API key existed
    #
    # Example
    #   @bus_site.admin_console_page.partner_details_section.create_api_key
    #
    # Returns nothing
    def create_api_key
      wait_until_bus_section_load
      locator =  "//a[text()='(create)']"
      find_any = api_key_div.all(:xpath, locator)
      if find_any.size > 0
        api_key_div.find(:xpath, locator).click
        wait_until_bus_section_load
      end
    end

    # Public: Get API key
    #
    # Example
    #  @bus_site.admin_console_page.partner_details_section.api_key
    #
    # Returns API key string
    def api_key
      api_key_div.text.gsub(/API Key:/,'').gsub(/\(create\)/,'').gsub(/\(delete\)/,'').strip
    end

    # Public: IP whitelist
    #
    def ip_whitelist
      ip_whitelist_div.text.gsub(/API IP Whitelist:/,'').gsub(/\(change\)/,'').gsub(/\(cancel\)/,'').strip
    end

    def add_ip_whitelist(ip)
      refresh_bus_section
      ip_whitelist_div.find(:css, 'a:first-child').click
      ip_whitelist_div.find(:css, 'input#api_allowed_ips').type_text(ip.to_s)
      ip_whitelist_div.find(:css, 'input[value=Submit]').click
    end

    # Public: Close partner details frame
    #
    # @param [string] partner_id
    #
    # Example
    #  @bus_site.admin_console_page.partner_details_section.close_partner_detail_section_by_id("317669")
    #
    # @return nothing
    def close_partner_detail_section_by_id(partner_id)
      find(:xpath, "//div[@id='partner-show-#{partner_id}']//a[@class='mod-button'][1]").click
    end

    # Public: Change Partner status from Active to Suspended
    #
    # @param none
    #
    # Example
    #  @bus_site.admin_console_page.partner_details_section.suspend_partner
    #
    # @return nothing
    def suspend_partner
      wait_until { change_status_link.visible? }
      change_status_link.click
      # wait for edit view
      wait_until { change_status_select.visible? }
      change_status_select.select('Suspended')
      submit_change_status_btn.click
      wait_until{ change_status_link.visible? }
    end

    # Public: Change Partner status from Suspended to Active
    #
    # @param none
    #
    # Example
    #  @bus_site.admin_console_page.partner_details_section.activate_partner
    #
    # @return nothing
    def activate_partner
      wait_until { change_status_link.visible? }
      change_status_link.click
      # wait for edit view
      wait_until { change_status_select.visible? }
      change_status_select.select('Active')
      submit_change_status_btn.click
      wait_until{ change_status_link.visible? }
    end

    # Public: Change Partner External ID
    #    #
    # Example
    #  @bus_site.admin_console_page.partner_details_section.change_external_id('Test_EID_12345')
    #
    # Return nothing
    def change_external_id(id)
      change_external_id_link.click
      external_id_tb.type_text(id)
      submit_external_id_btn.click
      wait_until_bus_section_load
    end

    # Public: Click the link to change the subdomain name
    #
    # @param none
    #
    # Example
    #  @bus_site.admin_console_page.partner_details_section.change_subdomain
    #
    # @return nothing
    def change_subdomain
      change_subdomain_link.click
    end

    def subdomain
      change_subdomain_link.text
    end

    # Public: Change the contact email
    #
    # @param email
    #
    # Example
    #  @bus_site.admin_console_page.partner_details_section.set_contact_email email
    #
    # @return nothing
    def set_contact_email email
      contact_email_tb.type_text email
    end

    def set_contact_address address
      contact_address_tb.type_text address
    end

    def set_contact_city city
      contact_city_tb.type_text city
    end

    def set_contact_state state
      case
        when contact_state_us_select.visible?
          contact_state_us_select state
        when  contact_state_ca_select.visible?
          contact_state_ca_select.select state
        else
          contact_state_select.type_text state
      end
    end

    def set_contact_zip zip
      contact_zip_tb.type_text zip
    end

    def set_contact_country country
      contact_country_select.select country
    end

    def save_changes
      save_changes_btn.click
    end

    # Public: Success messages for partner details section
    #
    # Example
    #  @bus_admin_console_page.partner_details_section.success_messages
    #  # => "API IP whitelist has been updated"
    #
    # @return [String]
    def success_messages
      msg_div.text
    end

  end
end
