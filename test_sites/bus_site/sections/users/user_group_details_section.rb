module Bus
  # This class provides actions for user group details section
  class UserGroupDetailsSection < SiteHelper::Section

    # Private elements
    #
    element(:change_name_link, xpath: "//a[text()='Change Name']")
    element(:delete_user_group_link, xpath: "//a[text()='Delete User Group']")
    elements(:group_details_dls, xpath: "//div/dl")
    element(:stash_info_dl, xpath: "//form[starts-with(@id,'user_groups-stash-form')]")
    elements(:user_group_tables, css: "table.table-view")

    # Stash section
    element(:change_stash_link, xpath: "//a[contains(@onclick,'change_stash')]")
    element(:cancel_stash_link, xpath: "//a[contains(@onclick,'cancel_change')]")
    element(:stash_status_select, xpath: "//select[starts-with(@id,'user_groups-stash-status-')]")
    element(:stash_default_quota_tb, id: "stash_default_quota")
    element(:submit_stash_status_btn, xpath: "//input[contains(@onclick,'submit_stash_status')]")
    element(:add_stash_to_all_users_link, xpath: "//a[contains(@onclick,'enable_stash_for_all_confirm')]")
    element(:add_stash_to_all_link, xpath: "//a[text()='Add Stash to All Users']")

    # Public: User group details information
    #
    # Example:
    #   @bus_site.admin_console_page.user_group_details_section.group_details_hash
    #
    # Returns hash array
    def group_details_hash
      wait_until_bus_section_load
      output = group_details_dls.map{ |dl| dl.dt_dd_elements_text }.delete_if { |k| k.empty? }
      if has_stash_info_dl?
        stash = stash_info_dl.dt_dd_elements_text.delete_if{ |pair| pair.first.empty? }.map{ |row| [row.first, row[1..-1].join(' ')] }
        output = output + stash
      end
      Hash[*output.flatten]
    end

    # Public: User list details table headers text
    #
    # Example:
    #   @bus_site.admin_console_page.user_group_details_section.users_list_table_headers
    #
    # Returns array
    def users_list_table_headers
      user_group_tables[0].headers_text
    end

    # Public: User list details table rows text
    #
    # Example:
    #   @bus_site.admin_console_page.user_group_details_section.users_list_table_rows
    #
    # Returns array
    def users_list_table_rows
      user_group_tables[0].rows_text
    end

    def delete_user_group
      wait_until_bus_section_load
      # if user group contains users
      if users_list_table_rows[0].to_s != "[\"\"]"
        delete_user_group_link.click
        alert_accept
      else
        delete_user_group_link.click
      end
    end

    # Public: Enable stash for a partner
    #
    # Example:
    #   @bus_site.admin_console_page.user_group_details_section.enable_stash
    #
    # Returns nothing
    def enable_stash(quota)
      change_stash_link.click
      stash_status_select.select('Yes')
      stash_default_quota_tb.type_text(quota)
      submit_stash_status_btn.click
      wait_until{ !submit_stash_status_btn.visible? }
    end

    # Public: Cancel Disable stash for a partner
    #
    # Example:
    #   @bus_site.admin_console_page.user_group_details_section.disable_stash(true)
    #
    # Returns nothing
    def cancel_disable_stash
      change_stash_link.click
      cancel_stash_link.click
    end

    # Public: Disable stash for a partner
    #
    # Example:
    #   @bus_site.admin_console_page.user_group_details_section.disable_stash(true)
    #
    # Returns nothing
    def disable_stash
      change_stash_link.click
      stash_status_select.select('No')
      submit_stash_status_btn.click
    end

    def add_stash_to_all_user
      add_stash_to_all_link.click
    end

    def users_list_table_hashes
      wait_until_bus_section_load
      users_list_table_rows.map{ |row| Hash[*users_list_table_headers.zip(row).flatten] }
    end
  end
end
