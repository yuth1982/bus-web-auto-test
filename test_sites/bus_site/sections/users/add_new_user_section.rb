module Bus
  # This class provides actions for add new user section
  class AddNewUserSection < SiteHelper::Section
    # Private elements
    #
    element(:succ_msg_div, css: 'ul.flash.successes')
    element(:err_msg_div, css: 'ul.flash.errors')

    element(:user_group_select, id: 'user_user_group_id')
    element(:ug_resources_details_table, id: 'resource-details')
    element(:buy_more_link, id: 'add_more_link')
    element(:add_group_link, css: 'a[href*=add_group]')

    element(:storage_type_select, id: 'user_storage_pool_policy')
    element(:storage_max_tb, id: 'desired_user_storage')
    element(:device_tb, id: 'device_count')
    element(:enable_stash_cb, id: 'user_enable_stash')

    element(:name_tb, id: 'user1_name')
    element(:email_tb, id: 'user1_username')
    element(:add_user_btn, css: 'button[onclick*=add_new_user]')
    element(:delete_user_btn, css: 'button[onclick*=del_new_user]')

    element(:send_emails_cb, id: 'send_email_to_users')
    element(:submit_btn, id: 'new_users_in_batch_submit_btn')

    # Public: Add new users
    #
    # @users     [Object] users
    #
    # Example
    #   @bus_admin_console_page.add_new_user_section.add_new_users(user_object)
    #
    # @return [] nothing
    def add_new_users(users)
      user = users.first
      user_group_select.select(user.user_group) unless user.user_group.nil?
      sleep 2 # wait for ajax call back
      storage_type_select.select(user.storage_type) unless user.storage_type.nil?
      storage_max_tb.type_text(user.storage_limit) unless user.storage_limit.nil?
      device_tb.type_text(user.devices) unless user.devices.nil?

      unless user.enable_stash.nil?
        if user.enable_stash.downcase.eql?('yes')
          enable_stash_cb.check
        else
          enable_stash_cb.uncheck
        end
      end

      users.each_index do |index|
        find(:id, "user#{index+1}_name").type_text(users[index].name)
        find(:id, "user#{index+1}_username").type_text(users[index].email)
        add_user_btn.click if index != users.length-1
      end

      unless user.send_email.nil?
        if user.send_email.downcase.eql?('yes')
          send_emails_cb.check
        else
          send_emails_cb.uncheck
        end
      end

      submit_btn.click
      wait_until_bus_section_load
    end

    # Public: Success messages for add new user sections
    #
    # Example
    #  @bus_admin_console_page.add_new_user_section.success_messages
    #  # => "Created new user test@mozy.com"
    #
    # @return [String]
    def success_messages
      succ_msg_div.text
    end

    # Public: Error messages for add new user sections
    #
    # Examples:
    #  @bus_admin_console_page.add_new_user_section.error_messages
    #  # => "Failed to create (1) users"
    #
    # @return [String]
    def error_messages
      err_msg_div.text
    end

    # Public: User group resource details
    #
    # Examples:
    #  @bus_admin_console_page.add_new_user_section.ug_resource_details_table_rows
    #  # => ["Desktop Storage (GB)","200"],["Server Storage (GB)","50"],["Desktop Devices","2"], ["Server Devices", "192"]
    #
    # @return
    def ug_resource_details_table_rows
      ug_resources_details_table.rows_text[1..-2]
    end

    def select_user_group(group_name)
      user_group_select.select(group_name)
      sleep 2 # wait for ajax call back
    end
  end
end
