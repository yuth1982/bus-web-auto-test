module Bus
  # This class provides actions for add new user section
  class AddNewUserSection < SiteHelper::Section
    # Private elements
    #
    element(:succ_msg_div, css: 'ul.flash.successes')
    element(:err_msg_div, css: 'ul.flash.errors')

    element(:user_group_select, id: 'user_user_group_id')
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
    element(:submit_btn, css: 'button[onclick*=new_users_in_batch]')

    # Public: Add new users
    #
    # @user       [Object] user
    # @num_users  [int] number of users to create
    #
    # Example
    #   @bus_admin_console_page.add_new_user_section.add_new_users(user_object)
    #
    # @return [] nothing
    def add_new_users(user, num_users = 1)
      user_group_select.select(user.user_group)
      sleep 2 # wait for ajax call back
      storage_type_select.select(user.storage_type) unless user.storage_type.nil?
      storage_max_tb.type_text(user.storage_max) unless user.storage_max.nil?
      device_tb.type_text(user.devices) unless user.devices.nil?

      unless user.enable_stash.nil?
        if user.enable_stash.downcase.eql?('yes')
          enable_stash_cb.check
        else
          enable_stash_cb.uncheck
        end
      end

      if num_users.to_i == 1
        name_tb.type_text(user.name)
        email_tb.type_text(user.email)
      else
        num_users.to_i.times do |i|
          find(:id, "user#{i+1}_name").type_text(user.rand_name)
          find(:id, "user#{i+1}_username").type_text(user.rand_email)
          add_user_btn.click
        end
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
    # Example
    #  @bus_admin_console_page.add_new_user_section.error_messages
    #  # => "Failed to create (1) users"
    #
    # @return [String]
    def error_messages
      err_msg_div.text
    end
  end
end
