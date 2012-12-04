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

    # Stash
    element(:add_stash_link, xpath: "//form[contains(@id,'stash-form-')]//a[text()='(Add Stash)']")
    element(:stash_quota_tb, xpath: "//form[contains(@id,'stash-form-')]//input[@id='quota']")
    element(:send_email_cb, xpath: "//form[contains(@id,'stash-form-')]//input[@id='send_email']")
    element(:submit_stash_btn, xpath: "//form[contains(@id,'stash-form-')]//input[@value='Submit']")
    element(:cancel_stash_btn, xpath: "//form[contains(@id,'stash-form-')]//a[text()='(cancel)']")
    element(:send_invitation_link, xpath: "//a[text()='(Send Invitation Email)']")

    # user backup information table
    element(:user_backup_details_table, css: "table.mini-table")

    # Public: User details hash
    #
    # Example:
    #   # => user_details_details_section.user_details_hash
    #
    # Returns array hash
    def user_details_hash
      has_change_user_password_link? # Wait until user details section loaded
      output = user_details_dls.map{ |dl| dl.dt_dd_elements_text }.delete_if { |k| k.empty? }
      Hash[*output.flatten]
    end

    # Public: Partner user id
    #
    # Example:
    #   # => user_details_details_section.user_id
    #
    # Returns user id
    def user_id
      user_details_hash['ID:']
    end

    # Public: Enable stash for a partner
    #
    # Example:
    #   # => user_details_details_section.add_stash
    #
    # Returns nothing
    def add_stash(quota, send_email)
      add_stash_link.click
      stash_quota_tb.type_text(quota) if quota.to_i >= 0
      send_email_cb.check if send_email
      submit_stash_btn.click
    end

    def cancel_add_stash
      add_stash_link.click
      cancel_stash_btn.click
    end

    def stash_enabled?
      wait_until{ send_invitation_link.visible? }
      user_details_hash['Enable Stash:'].include?('Yes')
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

  end
end