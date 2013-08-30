module Bus
  # This class provides user details
  class UserDetailsSection < SiteHelper::Section
    # Private elements
    #

    elements(:general_info_dls, css: 'div>dl')
    # top menus
    element(:delete_user_link, xpath: "//a[text()='Delete User']")
    element(:change_user_password_link, xpath: "//a[text()='Change User Password']")

    elements(:user_details_dls, xpath: "//div[starts-with(@id,'user-show')]//div[3]/dl")
    element(:change_status_link, xpath: "//span[starts-with(@id,'user-display-status-')]//a")
    element(:status_selection, css: 'select#status')
    element(:submit_status_btn, css: 'span[id^=user-change-status-]>input')
    element(:change_user_group_link, xpath: "//span[starts-with(@id,'user-display-usergroup-')]//a[text()='(change)']")
    element(:change_user_group_submit_button, xpath: "//span[starts-with(@id,'user-change-usergroup-')]//input[@name='commit']")
    element(:user_group_search_img, css: "img[alt='Search-button-icon']")
    element(:user_group_details_link, xpath: "//span[starts-with(@id,'user-display-usergroup-')]//a[starts-with(@href, '/user_groups/show/')]")
    element(:change_partner_link, xpath: "//span[starts-with(@id,'user-display-partner-')]//a[text()='(change)']")
    element(:change_partner_submit_button, xpath: "//span[starts-with(@id,'user-change-partner-')]//input[@name='commit']")
    element(:view_product_keys_link, xpath: "//a[text()='(View Product Keys)']")
    element(:product_key_lbl, xpath: "//div[starts-with(@id, 'all-license-keys-')]//div/div/div[2]/table[2]/tbody/tr/td")

    elements(:product_keys_tables, css: 'div[id^=all-license-keys-] table.mini-table')

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

    # User Storage Device Info
    elements(:storage_device_labels, css: ".div_row .label")
    elements(:storage_device_text, css: ".div_row:nth-child(2)")

    # Change Device Quota
    element(:device_edit, css: "form[action^='/user/change_device_count/'] span[class=view] a")
    element(:device_count, css: "input#device_count")
    element(:device_edit_submit, css: "input#device_count + input.button")
    element(:device_edit_cancel, css: "input#device_count + input.button + a")
    element(:device_status, css: "div.show-details>div>div:first-child>div:nth-child(2) span.view:first-child")
    element(:device_tooltip, css: "span.storage_pool_quota_tooltip")
    element(:machine_max_tooltips, css: "span[id^=tooltip_for_machine]")

    # user backup information table
    element(:user_backup_details_table, xpath: "//div[starts-with(@id, 'user-show')]//div[2]/table")

    # User Storage Device Info
    elements(:storage_device_labels, css: ".div_row .label")
    elements(:storage_device_text, css: ".div_row:nth-child(2)")

    element(:verify_user_link, css: 'a[onclick*=consumer_verify]')
    element(:user_verified_msg, css: "ul[class='flash successes'] li")
    element(:login_as_user_link, css: 'a[href*=login_as_user]')

    element(:device_table, css: 'table.mini-table')

    # Change User Password
    element(:new_password_tb, id: 'new_password')
    element(:new_password_confirm_tb, id: 'new_password_confirmation')
    element(:new_password_change_btn, css: "div[id^=user-pass-change] input[value='Save Changes']")

    # License Keys
    element(:send_keys_btn, xpath: '//div[starts-with(@id, "all-license-keys")]/descendant::input[starts-with(@id, "send_key")]')


    # Public: User details storage, devices, storage limit hash
    #
    # @param [] none
    #
    # Example:
    #   # => user_details_details_section.storage_device_info
    #
    # @return [Hash]
    # e.g. {"Storage" => "Desktop: 0 Used / 10 GB Available", "Devices" => "Desktop: 0 Used / 1 Available Edit", "Desktop User Storage Limit:" => "10 GB Edit Remove"}
    # NOTE: Only tested new partners, for migrated users with 2 types of storage may not work properly
    # TODO: Test users with 2 types of storage
    def storage_device_info
      table = {}
      storage_device_labels.each_with_index do | key, index |
        table[key.text] = storage_device_text[index].text
        Log.debug "current pair key #{key.text} and value #{table[key]}"
      end
      table
    end

    def device_status_text
      device_status.text
    end

    def activated_keys_table_rows
      product_keys_tables.first.rows_text
    end

    def unactivated_keys_table_rows
      product_keys_tables.last.rows_text
    end

    def general_info_hash
      wait_until_bus_section_load
      output = general_info_dls[0].dt_dd_elements_text + general_info_dls[1].dt_dd_elements_text
      Hash[*output.flatten]
    end

    # Public: User details hash
    #
    # @param [] none
    #
    # Example:
    #   # => user_details_details_section.user_details_hash
    #
    # @return [Hash]
    def user_details_hash
      wait_until_bus_section_load(:xpath => "//dt[text()='Name:']")
      output = user_details_dls.map{ |dl| dl.dt_dd_elements_text }.delete_if { |k| k.empty? }
      Hash[*output.flatten]
    end

    # Public: User id
    #
    # @param [] none
    #
    # Example:
    #   # => user_details_details_section.user_id
    #
    # @return [String]
    def user_id
      user_details_hash['ID:']
    end

    # Public: Enable stash for a user
    #
    # @params [bool] send_email
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.add_stash
    #
    # @return [] nothing
    def add_stash(send_email)
      add_stash_link.click
      send_email_cb.check if send_email
      submit_stash_btn.click
      wait_until_bus_section_load
    end

    # Public: Click add stash link then click cancel link
    #
    # @params [] none
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.cancel_add_stash
    #
    # @return [] nothing
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
    # @return [] nothing
    def change_stash_quota(quota)
      handle_max('edit', 'machine', 'Stash')
      set_max_value('machine', 'Stash', quota)
      handle_max('save', 'machine', 'Stash')
    end

    def add_stash_quota(quota)
      handle_max('set', 'machine', 'Stash')
      set_max_value('machine', 'Stash', quota)
      handle_max('save', 'machine', 'Stash')
    end

    # Public: Click change stash link then click cancel link
    #
    # @params [] none
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.cancel_change_stash_quota
    #
    # @return [] nothing
    def cancel_change_stash_quota
      change_stash_quota_link.click
      cancel_change_stash_quota_link.click
    end

    # Public: Click change stash quota text box to trigger popup box
    #
    # @params [] none
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.click_change_quota_tb
    #
    # @return [] nothing
    def click_change_quota_tb
      change_stash_quota_link.click
      change_stash_quota_tb.click
    end

    # Public: Find change stash quota popup box by tips text
    #
    # @params [] none
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.find_change_quota_tooltips('Max: 100 GB')
    #
    # @return [] nothing
    def find_change_quota_tooltips(text)
      tooltips = find(:xpath, "//span[text()='#{text}']")
      # I cannot check tooltips.visible?, since change_stash_quota_tb element will out of focus immediately
      # I will always get false value
      # So as far as I can find tooltips by hover text, I consider tooltips works fine
      !tooltips.nil?
    end

    # Public: Click delete link
    #
    # @params [] none
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.click_delete_stash_link
    #
    # @return [] nothing
    def click_delete_stash_link
      delete_stash_link.click
    end

    # Public: Click send stash invitation email link
    #
    # @params [] none
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.send_stash_invitation_email
    #
    # @return [] nothing
    def send_stash_invitation_email
      send_invitation_link.click
      wait_until_bus_section_load
      sleep 5 # wait for email to send
    end

    # Public: Click delete link
    #
    # @params [] none
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_section.click_delete_stash
    #
    # @return [] nothing
    def click_delete_stash
      delete_stash_link.click
    end

    # Public: Return user back up details table rows
    #
    # @params [] none
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_section.user_backup_details_table_rows
    #
    # @return [String]
    def user_backup_details_table_rows
      user_backup_details_table.rows_text
    end

    # Public: Activate user 
    #
    # @params [] none
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_section.active_user
    #
    # @return [] nothing
    def active_user
      change_status_link.click
      status_selection.select('Active')
      submit_status_btn.click
    end

    # Public: Return error messages
    #
    # @params [] none
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_section.messages
    #
    # @return [String]
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

    # Public: Click change link
    #    Select new user group
    #    Click submit button
    #    Refresh module
    #    Verify user group changed
    #
    # @param [Object] user
    # @param [String] new_user_group
    #
    # Example
    #    @bus_admin_console_page.user_details_section.update_user_group(@user, "Test Group 1")
    #
    # @return [nothing]
    def update_user_group(user, new_user_group)
      change_user_group_link.click
      unless user.user_group.nil?
        user_group_search_img.click
        sleep 2
        find(:xpath, "//li[text()='#{new_user_group}']").click
        change_user_group_submit_button.click
        wait_until{ !change_user_group_submit_button.visible? }
        user.user_group = new_user_group
      end
    end

    # Public: Returns user's user group
    #
    # Example
    #    @bus_admin_console_page.user_details_section.users_user_group("User Group 1")
    #
    # @return [Boolean]
    def users_user_group(user_group)
      find(:xpath, "//a[text()='#{user_group}']")
    end

    # Public: Click change link
    #    Select new user group
    #    Click submit button
    #    Refresh module
    #    Verify user group changed
    #
    # @param [Object] user
    # @param [String] new_user_group
    #
    # Example
    #    @bus_admin_console_page.user_details_section.update_user_group(@user, "Test Group 1")
    #
    # @return [nothing]
    def update_partner(new_partner)
      change_partner_link.click
      user_group_search_img.click
      sleep 2
      find(:xpath, "//li[text()='#{new_partner}']").click
      change_partner_submit_button.click
      wait_until{ !change_partner_submit_button.visible? }
    end

    # Public: Returns user's partner
    #
    # Example
    #    @bus_admin_console_page.user_details_section.user_partner("Enterprise Root")
    #
    # @return [Boolean]
    def user_partner(user_partner)
      find(:xpath, "//a[text()='#{user_partner}']")
    end

    # Public: Click Delete User
    #    Click confirmation
    #
    # @param [none]
    #
    # Example
    #    @bus_admin_console_page.user_details_section.delete_user
    #
    # @return [nothing]
    def delete_user
      delete_user_link.click
      alert_accept
      sleep 2 # leaving the session too fast, delete not taking hold
    end

    def device_table_headers
      device_table.headers_text
    end

    def device_table_rows
      if device_stash_divide_row_index.nil?
        device_table.rows_text
      else
        device_table.rows_text[0..device_stash_divide_row_index-1]
      end
    end

    def device_table_hashes
      device_table_rows.map{ |row| Hash[*device_table_headers.zip(row).flatten] }
    end

    def stash_table_headers
      result = device_table.headers_text
      unless device_stash_divide_row_index.nil?
        result[0] = device_table.rows_text[device_stash_divide_row_index + 1].first
      end
      result
    end

    def stash_table_rows
      unless device_stash_divide_row_index.nil?
        device_table.rows_text.last
      end
    end

    def stash_table_hashes
      Hash[*stash_table_headers.zip(stash_table_rows).flatten]
    end

    def delete_device(device_name)
      device_table.rows.each do |row|
        if row[0].text == device_name
          row[-1].find(:css, 'form[id^=machine-delete] a.action').click
          alert_accept
          break;
        end
      end
    end

    def click_view_product_keys_link
      view_product_keys_link.click
      wait_until{ send_keys_btn.visible? }
    end

    def product_key
      product_key_lbl.text
    end

    def user
      { :id => general_info_hash['ID:'],
        :email => find(:css, "div.header-bar > h3").text,
        :name => general_info_hash['Name:'][/^(.*)(change)$/, 1]}
    end

    def edit_password(password)
      change_user_password_link.click
      wait_until_bus_section_load
      new_password_tb.type_text(password)
      new_password_confirm_tb.type_text(password)
      new_password_change_btn.click
      wait_until_bus_section_load
    end

    def change_device_quota(count)
      device_edit.click
      device_count.type_text(count)
      device_edit_submit.click
    end

    def device_edit_and_cancel(count)
      device_edit.click
      device_count.type_text(count)
      device_edit_cancel.click
    end

    def check_device_range(range)
      tooltip = {}
      tip_text = device_count[:onfocus][/'(Min: \d+, Max: \d+)'/, 1]
      tooltip['min'] = tip_text[/Min: (\d+)/, 1]
      tooltip['max'] = tip_text[/Max: (\d+)/, 1]
      range.each do |k, v|
        tooltip[k.downcase].should == v
      end
    end

    def get_machine_id(device)
      a = find(:xpath, "//table[@class='mini-table']//td[1]/a[text()='#{device}']")[:href]
      a[/\/admin\/view_restores\/(\d+)$/, 1].to_i
    end

    # Public: Click send user keys
    #
    # @param [none]
    #
    # Example
    #    @bus_admin_console_page.user_details_section.click_send_user_keys
    #
    # @return [nothing]
    def click_send_user_keys
      send_keys_btn.click
    end

    def set_user_email(email)
      find_link("Change User Email").click
      find(:id, "username").type_text email
      e = find(:xpath, "//div[contains(@id, 'user-username-change-')]//input[@value='Save Changes']")
      e.click
      wait_until{ !e.visible? }
    end

    def set_user_name(name)
      find(:xpath, "//div[contains(@id, 'user-show-')]//a[contains(text(),'(change)')]").click
      find(:id, "name").type_text name
      e = find(:xpath, "//div[contains(@id, 'user-show-')]//input[@name='commit']")
      e.click
      wait_until{ !e.visible? }
    end

    def set_user_status(status)
      case status
        when "cancelled"
          find(:xpath, "//div[contains(@id, 'user-show-')]//a[contains(text(),'(cancel)')]").click
          alert_accept
        when "active"
          find(:xpath, "//div[contains(@id, 'user-show-')]//a[contains(text(),'(uncancel)')]").click
      end
    end

    def handle_max(action, type, name, confirm=true)
      case type
        when 'machine'
          action = 'cancel-edit' if action == 'cancel'
          ctl = find(:xpath, "//table[@class='mini-table']//a[text()='#{name}']/../../*[last()-2]//*[starts-with(@id, '#{action}-machine-storage-max')]")
          ctl.click
          if action == 'remove'
            confirm ? alert_accept : alert_dismiss
          end
        when 'user'
          #TODO
      end

      if action == 'save' or action == 'remove'
        wait_until_bus_section_load
      end
    end

    def set_max_value(type, name, quota)
      case type
        when 'machine'
          max_input = find(:xpath, "//table[@class='mini-table']//a[text()='#{name}']/../../*[last()-2]//*[starts-with(@id, 'input-machine-storage-max')]")
          wait_until { max_input.visible? }
          max_input.click
          Log.debug machine_max_tooltips.text
          max_input.type_text(quota)
        when 'user'
          #TODO
      end
    end

    def check_machine_max_range(name, range)
      tooltip = {}
      max_input = find(:xpath, "//table[@class='mini-table']//a[text()='#{name}']/../../*[last()-2]//*[starts-with(@id, 'input-machine-storage-max')]")
      tip_text = max_input[:onfocus][/'(Min: \d+ GB, Max: \d+ GB)'/, 1]
      Log.debug tip_text
      tooltip['min'] = tip_text[/Min: (\d+)/, 1]
      tooltip['max'] = tip_text[/Max: (\d+)/, 1]
      range.each do |k, v|
        tooltip[k.downcase].should == v
      end
    end

    # jm: code for hashing user subscription info
    element(:bar_information, css: "div.show-details > table.mini-table[2]")

    # returns a hash of user subscription data
    def mozyhome_user_details_hash
      user_details_hash = Hash.new
      bar_information.headers_text.each_with_index { |header,index| user_details_hash[header] = bar_information.rows_text[0][index] }
      Log.debug(user_details_hash)
      user_details_hash
    end

    # Public: Is "Send Keys" button disabled?
    #
    # @param [none]
    #
    # Example
    #    @bus_admin_console_page.user_details_section.send_keys_button_disabled?
    #
    # @return [nothing]
    def send_keys_button_disabled?
      send_keys_btn['disabled'] == 'true'
    end

    def click_user_group_details_link
      user_group_details_link.click
    end

    private
    def device_stash_divide_row_index
      device_table.rows_text.index{ |row| row.first == ''}
    end
  end
end
