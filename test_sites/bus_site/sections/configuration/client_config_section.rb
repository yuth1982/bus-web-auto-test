module Bus
  # This class provides actions for add new partner page section
  class ClientConfigSection < SiteHelper::Section

    # Private elements
    #
    element(:config_name_tb, id: 'config_name')
    element(:config_license_type_id_select, id: 'config_license_type_id')

    # tabs
    element(:preferences_tab, xpath: "//div[@id='setting-edit_client_config-tabs']/ul/li")
    element(:scheduling_tab, xpath: "//div[@id='setting-edit_client_config-tabs']/ul/li[2]")
    element(:bandwidth_throttling_tab, xpath: "//div[@id='setting-edit_client_config-tabs']/ul/li[3]")
    element(:throttle_cb, id: 'throttle_checkbox')
    element(:windows_backup_sets, xpath: "//div[@id='setting-edit_client_config-tabs']/ul/li[4]")
    element(:mac_backup_sets, xpath: "//div[@id='setting-edit_client_config-tabs']/ul/li[5]")
    element(:user_groups, xpath: "//div[@id='setting-edit_client_config-tabs']/ul/li[6]")
    element(:client_config_save_changes_btn, xpath: "//div[@id='setting-edit_client_config-tabs'] input[value='Save Changes']")

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
      page.driver.browser.switch_to.frame(0)
      page.find(:id, 'config_name').type_text(client_config.name)
      page.find(:id, 'config_license_type_id').select(client_config.type)
      page.find(:xpath, "//div[@id='blank-div']/form/fieldset/div[3]/input").click
      page.find(:xpath, "//div[@id='setting-edit_client_config-tabs']/ul/li[3]").click
      if client_config.throttle
        page.find(:id, 'throttle_kbps').type_text(client_config.throttle_amount)
      else
        page.find(:id, 'throttle_checkbox').click
      end
      page.find(:xpath, "//div[@id='setting-edit_client_config-tabs']/ul[2]/li[7]/p/input[2]").click
      page.driver.browser.switch_to.default_content
    end

    # Public: Messages for client configuration section
    #
    # Example
    #  @bus_admin_console_page.client_configuration_section.messages
    #  # => "Your configuration was saved."
    #
    # Returns success or error message text
    def messages
      page.driver.browser.switch_to.frame(0)
      page.find(:xpath, "//div[@id='setting-edit_client_config-errors']/ul/li").text
      page.driver.browser.switch_to.default_content
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
      page.driver.browser.switch_to.frame(0)
      page.find(:xpath, "//a[text()='#{client_config}']").click
      page.find(:xpath, "//a[text()='Delete Config']").click
      alert_accept
      page.driver.browser.switch_to.default_content
    end
  end
end
