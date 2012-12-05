module Bus
  # This class provides actions for user group details section
  class UserGroupDetailsSection < SiteHelper::Section

    # Private elements
    #
    element(:change_name_link, xpath: "//a[text()='Change Name']")
    element(:delete_user_group_link, xpath: "//a[text()='Delete User Group']")
    elements(:group_details_dls, xpath: "//div/dl")
    element(:stash_info_dl, xpath: "//form[starts-with(@id,'user_groups-stash-form')]")
    add_existence_checker(:stash_info_dl, xpath: "//form[starts-with(@id,'user_groups-stash-form')]")
    elements(:user_group_tables, css: "table.table-view")
    element(:loading_link, xpath: "//a[contains(@onclick,'toggle_module')]")

    # Stash section
    element(:change_stash_link, xpath: "//a[contains(@onclick,'change_stash')]")
    element(:cancel_stash_link, xpath: "//a[contains(@onclick,'cancel_change')]")
    element(:stash_status_select, xpath: "//select[starts-with(@id,'user_groups-stash-status-')]")
    element(:stash_default_quota_tb, id: "stash_default_quota")
    element(:submit_stash_status_btn, xpath: "//input[contains(@onclick,'submit_stash_status')]")
    element(:add_stash_to_all_users_link, xpath: "//a[contains(@onclick,'enable_stash_for_all_confirm')]")

    element(:submit_delete_stash_btn, xpath: "//div[@class='popup-window-footer']//input[@value='Submit']")
    element(:cancel_delete_stash_btn, xpath: "//div[@class='popup-window-footer']//input[@value='Cancel']")

    element(:add_stash_to_all_link, xpath: "//a[text()='Add Stash to All Users']")

    # Public: User group details information
    #
    # Example:
    #   # => user_group_details_section.group_details_hash
    #
    # Returns hash array
    def group_details_hash
      has_change_name_link?
      output = group_details_dls.map{ |dl| dl.dt_dd_elements_text }.delete_if { |k| k.empty? }
      if has_stash_info_dl?
        stash = stash_info_dl.dt_dd_elements_text.delete_if{ |pair| pair.first.empty? }.map{ |row| [row.first, row[1..-1].join(' ')] }
        output = output + stash
      end
      Hash[*output.flatten]
    end

    def users_list_table_headers
      user_group_tables[0].headers_text
    end

    def users_list_table_rows
      user_group_tables[0].rows_text
    end

    def delete_user_group
      delete_user_group_link.click
      alert_accept
      wait_until{ !has_delete_user_group_link? }
    end

    def stop_spining
      wait_until{ loading_link[:class] != "title loading" }
    end

    # Public: Enable stash for a partner
    #
    # Example:
    #   # => user_group_details_section.enable_stash
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
    #   # => user_group_details_section.disable_stash(true)
    #
    # Returns nothing
    def disable_stash(confirm_delete = true)
      change_stash_link.click
      stash_status_select.select('No')
      submit_stash_status_btn.click
      if confirm_delete
        submit_delete_stash_btn.click
      else
        cancel_delete_stash_btn.click
        cancel_stash_link.click
      end
      wait_until{ !submit_stash_status_btn.visible? }
    end

    def add_stash_to_all_user
      add_stash_to_all_link.click
    end
  end
end
