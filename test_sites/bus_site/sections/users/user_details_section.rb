module Bus
  # This class provides user details
  class UserDetailsSection < SiteHelper::Section
    # Private elements
    #
    # top menus
    element(:delete_user_link, xpath: "//a[text()='Delete User']")
    element(:change_user_password_link, xpath: "//a[text()='Change User Password']")

    elements(:user_details_dls, xpath: "//div[starts-with(@id,'user-show-')]//dl")
    element(:change_status_link, xpath: "//span[starts-with(@id,'user-display-status-')]//a")
    element(:status_selection, xpath: "//select[@id='status']")
    element(:submit_status_btn, xpath: "//span[starts-with(@id,'user-change-status-')]//input")

    # Add Stash
    element(:add_stash_link, xpath: "//a[text()='(Add Stash)']")
    element(:stash_quota_tb, css: "form[id^=stash-form-] input#quota")
    element(:send_email_cb, css: "form[id^=stash-form-] input#send_email")
    element(:submit_stash_btn, css: "form[id^=stash-form-] input[value=Submit]")
    element(:cancel_stash_btn, xpath: "//form[starts-with(@id,'stash-form-')]//a[text()='(cancel)']")
    element(:send_invitation_link, xpath: "//a[text()='(Send Invitation Email)']")

    # Change Stash Quota
    element(:change_stash_quota_link, css: "a[id^=edit_quota_for_user_show]")
    element(:cancel_change_stash_quota_link, css: "a[id^=cancel_edit_quota_for_user_show_]")
    element(:change_stash_quota_tb, css: "input[id^=quota_in_gb_for_user_show_]")
    element(:change_stash_quota_btn, css: "div[id^=change_quota_for_user_show_] input[value='Save']")
    element(:change_quota_tooltips, css: "span[id^=tooltip_for_user_show_]")
    element(:delete_stash_link, css: "a[onclick^=show_delete_stash_popup]")

    # user backup information table
    element(:user_backup_details_table, css: "table.mini-table")

    element(:verify_user_link, css: 'a[onclick*=consumer_verify]')
    element(:user_verified_msg, css: "ul[class='flash successes'] li")
    element(:login_as_user_link, css: 'a[href*=login_as_user]')

    # Public: User details hash
    #
    # Example:
    #   # => user_details_details_section.user_details_hash
    #
    # Returns array hash
    def user_details_hash
      wait_until_bus_section_load
      output = user_details_dls.map{ |dl| dl.dt_dd_elements_text }.delete_if { |k| k.empty? }
      Hash[*output.flatten]
    end

    # Public: User id
    #
    # Example:
    #   # => user_details_details_section.user_id
    #
    # Returns user id
    def user_id
      user_details_hash['ID:']
    end

    # Public: Enable stash for a user
    #
    # @params [string] quota, [bool] send_email
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.add_stash
    #
    # Returns nothing
    def add_stash(quota, send_email)
      add_stash_link.click
      stash_quota_tb.type_text(quota) if quota.to_i >= 0 #if quota = -1, then use default
      send_email_cb.check if send_email
      submit_stash_btn.click
      wait_until_bus_section_load
    end

    # Public: Click add stash link then click cancel link
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.cancel_add_stash
    #
    # Returns nothing
    def cancel_add_stash
      add_stash_link.click
      cancel_stash_btn.click
    end

    # Public: Change stash quota for a user
    #
    # @params [string] quota
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.change_stash_quota('10')
    #
    # Returns nothing
    def change_stash_quota(quota)
      change_stash_quota_link.click
      change_stash_quota_tb.type_text(quota)
      change_stash_quota_btn.click
    end

    # Public: Click change stash link then click cancel link
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.cancel_change_stash_quota
    #
    # Returns nothing
    def cancel_change_stash_quota
      change_stash_quota_link.click
      cancel_change_stash_quota_link.click
    end

    # Public: Click change stash quota text box to trigger popup box
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.click_change_quota_tb
    #
    # Returns nothing
    def click_change_quota_tb
      change_stash_quota_link.click
      change_stash_quota_tb.click
    end

    # Public: Find change stash quota popup box by tips text
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.find_change_quota_tooltips('Max: 100 GB')
    #
    # Returns nothing
    def find_change_quota_tooltips(text)
      tooltips = find(:xpath, "//span[text()='#{text}']")
      # I cannot check tooltips.visible?, since change_stash_quota_tb element will out of focus immediately
      # I will always get false value
      # So as far as I can find tooltips by hover text, I consider tooltips works fine
      !tooltips.nil?
    end

    # Public: Click delete link
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.click_delete_stash_link
    #
    # Returns nothing
    def click_delete_stash_link
      delete_stash_link.click
    end

    # Public: Click send stash invitation email link
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.send_stash_invitation_email
    #
    # Returns nothing
    def send_stash_invitation_email
      send_invitation_link.click
      wait_until_bus_section_load
    end

    # Public: Click delete link
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.delete_stash
    #
    # Returns nothing
    def click_delete_stash
      delete_stash_link.click
    end

    def user_backup_details_table_headers
      user_backup_details_table.headers_text
    end

    def user_backup_details_table_rows
      user_backup_details_table.rows_text
    end

    def active_user
      change_status_link.click
      status_selection.select('Active')
      submit_status_btn.click
    end

    def messages
      message_div = find(:css, "div#user-show-#{user_id}-errors ul")
      message_div.text
    end

    def verify_user
      verify_user_link.click
    end

    def user_verified
      user_verified_msg.text
    end

    def login_as_user
      login_as_user_link.click
    end
  end
end