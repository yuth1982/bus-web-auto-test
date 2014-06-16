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
    element(:user_groups, xpath: "//div[@id='setting-edit_client_config-tabs']/ul/li[6]")


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

      bandwidth_throttling_tab.click
      if client_config.throttle
        throttle_amount_tb.type_text(client_config.throttle_amount)
      else
        throttle_cb.click
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

    #section(:branding_section, BrandingSection, xpath: "//li[@id='nav-cat-site_branding']/ul/li[4]/a")
    element(:css_input, xpath: "//*[@id='site_branding-webrestore_site-tabs']/ul[2]/li[1]/textarea")
    #element(:css_input, css: "#site_branding-webrestore_site-tabs > ul.tab-panes > li.selected > textarea")
    element(:save_changes_btn, xpath: "//*[@id='site_branding-webrestore_site-tabs']/ul[2]/li[7]/p/input")

    def css_header_color_hex
      color_hex_list = ["#FAEBD7", "#00FFFF", "#8A2BE2", "#FF1493"]
      color_hex = color_hex_list[rand(4)]
      puts color_hex
      header_hex = ".content-header{ background-color: " + color_hex +";}"
      footer_hex = ".footer{ background-color: " + color_hex +";}"
      css_input.type_text(header_hex)
      puts "---input----"
      css_input.type_text(footer_hex)
      sleep 3
    end

    def click_save_changes
      save_changes_btn.click
      sleep 5
    end

  end
end