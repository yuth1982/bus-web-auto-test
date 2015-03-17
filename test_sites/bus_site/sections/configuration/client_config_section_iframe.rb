module Bus
  # This class provides actions for add new partner page section
  class ClientConfigIframe < SiteHelper::Iframe

    element(:config_name_tb, id: 'config_name')
    element(:config_license_type_id_select, id: 'config_license_type_id')
    element(:next_btn, css: 'div#blank-div>form input[value=Next]')

    # tabs
    element(:preferences_tab, xpath: "//div[@id='setting-edit_client_config-tabs']/ul/li")
    element(:scheduling_tab, xpath: "//div[@id='setting-edit_client_config-tabs']/ul/li[2]")
    element(:bandwidth_throttling_tab, xpath: "//div[@id='setting-edit_client_config-tabs']/ul/li[3]")
    element(:throttle_cb, id: 'throttle_checkbox')
    element(:throttle_amount_tb, id: 'throttle_kbps')
    element(:windows_backup_sets, xpath: "//div[@id='setting-edit_client_config-tabs']/ul/li[4]")
    element(:mac_backup_sets, xpath: "//div[@id='setting-edit_client_config-tabs']/ul/li[5]")
    element(:user_groups, xpath: "//div[@id='setting-edit_client_config-tabs']/ul/li[7]")
    element(:add_user_groups, xpath: "//div[@id='config-user-groups']/p[2]/a")
    element(:choose_user_groups, xpath: "//div[@id='config-user-groups']/table/tbody/tr[3]/td/label/input")

    element(:ckey_radio, xpath: "//input[@id='userinfo.allowed_encryption_key_sources.adminurl']")
    element(:ckey_input, xpath: "//input[@id='userinfo.encryption_key_url']")
    element(:default_key_check, id: "userinfo.allowed_encryption_key_sources.default")

    element(:client_config_save_changes_btn, css: "input[value='Save Changes']")

    element(:message_div, xpath: "//div[@id='setting-edit_client_config-errors']/ul/li")

    # Public: Enter name
    #         Select license type
    #         Click next button
    #         Select/deselect throttle
    #         Click save changes button
    #
    # @param [Object] client_config
    #
    # Example
    #    @bus_admin_console_page.client_config_section.create_client_config(@client_config)
    #
    # @return [nothing]
    def create_client_config(client_config)
      config_name_tb.type_text(client_config.name)
      config_license_type_id_select.select(client_config.type) unless client_config.type.nil?
      next_btn.click

      preferences_tab.click
      if !client_config.private_key.nil?
        default_key_check.click
        if !client_config.user_group.nil?
          user_groups.click
          sleep 1
          add_user_groups.click
          choose_user_groups.click
        end
      end

      if !client_config.ckey.nil?
        ckey_radio.click
        ckey_input.type_text(client_config.ckey)
        if !client_config.user_group.nil?
          user_groups.click
          sleep 1
          add_user_groups.click
          choose_user_groups.click
        end
      end

      bandwidth_throttling_tab.click
      if client_config.throttle
        throttle_amount_tb.click unless throttle_cb.checked?
        throttle_amount_tb.type_text(client_config.throttle_amount)
      else
        throttle_cb.click if throttle_cb.checked?
      end



      client_config_save_changes_btn.click
    end

    # Public: Messages for client configuration section
    #
    # Example
    #  @bus_admin_console_page.client_configuration_section.messages
    #  # => "Your configuration was saved."
    #
    # Returns success or error message text
    def messages
      message_div.text
    end

    # Public: Select config
    #         Click delete config link
    #         Accept confirmation
    #
    # @param [String] client_config
    #
    # Example
    #    @bus_admin_console_page.client_config_section.delete_client_config("smoke_desktop_config")
    #
    # @return [nothing]
    def delete_client_config(client_config)
      page.find(:xpath, "//a[text()='#{client_config}']").click
      page.find(:xpath, "//a[text()='Delete Config']").click
      alert_accept
    end
  end
end