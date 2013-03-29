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
    element(:windows_backup_sets_tab, xpath: "//div[@id='setting-edit_client_config-tabs']/ul/li[4]")
    element(:mac_backup_sets_tab, xpath: "//div[@id='setting-edit_client_config-tabs']/ul/li[5]")
    element(:user_groups_tab, xpath: "//div[@id='setting-edit_client_config-tabs']/ul/li[6]")
    element(:client_config_save_changes_btn, xpath: "//div[@id='setting-edit_client_config-tabs'] input[value='Save Changes']")

    element(:message_div, xpath: "//div[@id='setting-edit_client_config-errors']/ul/li")

    # Public: Enter name
    #         Select license type
    #         Click next button
    #         Deselect throttle or add throttle amount
    #         Select user group
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
      unless client_config.type.nil?
        # default client type depends on partner/admin settings i.e. "Server" or "Generic"
        page.find(:id, 'config_license_type_id').select(client_config.type)
      end
      page.find(:xpath, "//div[@id='blank-div']/form/fieldset/div[3]/input").click
      wait_until{ page.find(:xpath, "//div[@id='setting-edit_client_config-tabs']/ul/li[1]").visible?}

      # Select throttle tab (li element depends on roles/capabilities)
      (1..page.all(:xpath, "//div[@id='setting-edit_client_config-tabs']/ul/li").count).each do |i|
        begin
          if page.find(:xpath, "//div[@id='setting-edit_client_config-tabs']/ul/li[#{i}]").text == "Bandwidth Throttling"
            page.find(:xpath, "//div[@id='setting-edit_client_config-tabs']/ul/li[#{i}]").click
            break
          end
        rescue Capybara::ElementNotFound
          break
        end
      end

      wait_until{ page.find(:id, 'throttle_checkbox').visible? }
      # Select throttle?
      if client_config.throttle
        page.find(:id, 'throttle_kbps').type_text(client_config.throttle_amount)
      else
        page.find(:id, 'throttle_checkbox').click
      end

      # Select user group?
      unless client_config.user_group.nil?
        # Select user groups tab (li element depends on roles/capabilities)
        (1..page.all(:xpath, "//div[@id='setting-edit_client_config-tabs']/ul/li").count).each do |i|
          begin
            if page.find(:xpath, "//div[@id='setting-edit_client_config-tabs']/ul/li[#{i}]").text == "User Groups"
              page.find(:xpath, "//div[@id='setting-edit_client_config-tabs']/ul/li[#{i}]").click
              break
            end
          rescue Capybara::ElementNotFound
            break
          end
        end

        wait_until{ page.find(:xpath, "//a[contains(text(),'Add/remove user groups')]").visible? }
        page.find(:xpath, "//a[contains(text(),'Add/remove user groups')]").click
        wait_until{ page.find(:xpath, "//div[@id='config-user-groups']/table").visible? }

        #for each row in the table look for the user group in the label, when found select the config
        (2..page.all(:xpath, "//div[@id='config-user-groups']/table/tbody/tr").count).each do |row|
          if page.find(:xpath, "//div[@id='config-user-groups']/table/tbody/tr[#{row}]/td/label").text == client_config.user_group
            page.find(:xpath, "//div[@id='config-user-groups']/table/tbody/tr[#{row}]/td[2]/select").select(client_config.name)
            unless page.find(:xpath, "//div[@id='config-user-groups']/table/tbody/tr[#{row}]/td/label/input").checked?
              page.find(:xpath, "//div[@id='config-user-groups']/table/tbody/tr[#{row}]/td/label/input").click
            end
          end
        end
      end

      page.find(:xpath, "//input[@value='Save Changes']").click
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

    # Public: Existing config hashes
    #         Converts results table into an Array of Hash where the keys of each Hash are the headers in the table.                                                                                               # Example
    #         Due to iframes table conversion is done inline and asserted
    #
    # @param [string] test_data
    #
    # Example
    #  @bus_admin_console_page.client_config_section.assert_existing_config_hash
    #
    # @return [nothing]
    def assert_existing_config_hashes(test_data)
      wait_until_bus_section_load
      page.driver.browser.switch_to.frame(0)
      existing_table = page.find(:css, "#blank-div table.table-view")
      expected = test_data.hashes
      expected.each_index{ |index| expected[index].keys.each{ |key| (existing_table.rows_text.map{ |row| Hash[*existing_table.headers_text.zip(row).flatten] })[index][key].should == expected[index][key]} }
      page.driver.browser.switch_to.default_content
    end
  end
end
