module Bus
  # This class provides actions for add new partner page section
  class ClientConfigIframe < SiteHelper::Iframe

    element(:config_name_tb, id: 'config_name')
    element(:config_license_type_id_select, id: 'config_license_type_id')
    element(:next_btn, css: 'div#blank-div>form input[value=Next]')
    element(:cancel_edit_config_btn, xpath:"//div[contains(@id,'edit_client_config')]/ul/li/p/input[@value='Cancel']")

    # tabs when create config
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
    element(:private_key_input, id: "userinfo.allowed_encryption_key_sources.custom")

    element(:client_config_save_changes_btn, css: "input[value='Save Changes']")

    element(:message_div, xpath: "//div[@id='setting-edit_client_config-errors']/ul/li")

    #backup_set
    element(:create_backup_set_link, xpath: "//a[text()='Create Backup Set']")
    element(:backup_name_input, xpath: "//input[@value='New Backup Set']")
    element(:location_exclude_check, xpath: "//label/input[contains(@onclick,'update_linuxset_exclude')]")
    element(:add_search_location_link, xpath: "//a[text()='Add Search Location']")
    element(:done_link, xpath: "//a[text()='Done']")
    element(:cancel_linuxset_link, xpath: "//a[contains(@onclick,'cancel_editing_linuxset')]")
    element(:options_cb, xpath: "//div[@id='editlinuxbackupsetbox']//div//p//label//input")
    element(:linux_rules_name_includes_input, xpath: "//input[@id='filenames_linuxrule']")
    element(:linux_rules_name_excludes_input, xpath: "//input[@id='exclude_filenames_linuxrule']")
    element(:linux_rules_type_includes_input, xpath: "//input[@id='filetypes_linuxrule']")
    element(:linux_rules_type_excludes_input, xpath: "//input[@id='exclude_filetypes_linuxrule']")

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
        default_key_check.uncheck
        private_key_input.check
      end

      if !client_config.ckey.nil?
        ckey_radio.click
        ckey_input.type_text(client_config.ckey)
      end

      if !client_config.user_group.nil?
        user_groups.click
        add_user_groups.click
        user_group1_xpath = "//div[@id='config-user-groups']//label[text()='#{client_config.user_group}']/input"
        find(:xpath, user_group1_xpath).click
        if !client_config.user_group_2.nil?
          user_group2_xpath = "//div[@id='config-user-groups']//label[text()='#{client_config.user_group_2}']/input"
          find(:xpath, user_group2_xpath).click
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

    def remove_group_from_config(group_name)
      add_user_groups.click if add_user_groups.visible?
      user_group1_xpath = "//div[@id='config-user-groups']//label[text()='#{group_name}']/input"
      find(:xpath, user_group1_xpath).uncheck
    end

    def save_client_configs
      client_config_save_changes_btn.click
    end

    def edit_client_config client_config_name
      wait_until{ find_link(client_config_name).visible? }
      find_link(client_config_name).click
    end

    def cancel_edit_client_config
      cancel_edit_config_btn.click
    end

    def copy_client_config (old_config_name,new_config_name)
      find(:xpath, "//td/a[text()='#{old_config_name}']/../../td//a[text()='Copy']").click
      find(:xpath, "//td/a[text()='#{old_config_name}']/../../td//input[@id='copy_name']").type_text(new_config_name)
      find(:xpath, "//td/a[text()='#{old_config_name}']/../../td//input[@value='Submit']").click
    end

    def get_client_config_group (config_name)
      find(:xpath, "//td/a[text()='#{config_name}']/../../td[3]").text
    end

    def click_tab(tab_name)
      find(:xpath, "//li[text()='#{tab_name}']").click
    end

    def create_backup_lnk_visible
      create_backup_set_link.visible?
    end

    def backup_set_name_visible(backup_name)
      all(:xpath, "//table//b[text()='#{backup_name}']").size
    end

    def set_linux_backup_name(name)
      create_backup_set_link.click
      backup_name_input.type_text(name)
    end

    def check_exclusionary(check)
      if check
        location_exclude_check.check
      else
        location_exclude_check.uncheck
      end
    end

    def get_exclusionary
     location_exclude_check.checked?
    end

    def click_edit_linux_backup(backup_name)
      find(:xpath, "//label//b[text()='"+backup_name+"']//..//..//a[text()='view/edit']").click
    end

    def edit_linux_backup_exsit(backup_name)
      all(:xpath, "//label//b[text()='"+backup_name+"']//..//..//a[text()='view/edit']").size
    end

    def delete_linux_backup(backup_name)
      find(:xpath, "//label//b[text()='"+backup_name+"']//..//..//a[text()='Delete']").click
      alert_accept
    end

    def backup_name_visible(backup_name)
      find(:xpath,"//input[@value='#{backup_name}']").visible?
    end

    def add_locations(locations)
      locations.each_index do |n|
        find(:xpath, "//div[@id='linuxfsitems']//select["+(n+1).to_s+"]").select(locations[n]['location types'])
        find(:xpath, "//input[@id='linuxfsitem_"+n.to_s+"']").type_text(locations[n]['folder names'])
        if n<(locations.size-1)
          add_search_location_link.click if all(:xpath, "//div[@id='linuxfsitems']//select["+(n+2).to_s+"]").size == 0
        end
      end
    end

    def get_search_locations
      all_types_objs = all(:xpath, "//div[@id='linuxfsitems']//select")
      search_locations = []
      all_types_objs.each_index do |n|
        types_obj = find(:xpath, "//div[@id='linuxfsitems']//select["+(n+1).to_s+"]")
        locations_obj = find(:xpath, "//input[@id='linuxfsitem_"+n.to_s+"']")
        if types_obj.value == '1'
          search_locations << {'location types' => 'Include', 'folder names' => locations_obj.value}
        else
          search_locations << {'location types' => 'Exclude', 'folder names' => locations_obj.value}
        end
      end
      search_locations
    end

    def delete_location(location)
      index = find(:xpath, "//input[@value='#{location}']")[:id].split('_')[1]
      find(:xpath, "//a[contains(@onclick,'remove_linuxfsitem(#{index})')]").click
    end

    def add_linux_backup_rules(rules)
      linux_rules_name_includes_input.type_text(rules['name includes']) unless rules['name includes'].nil?
      linux_rules_name_excludes_input.type_text(rules['name excludes']) unless rules['name excludes'].nil?
      linux_rules_type_includes_input.type_text(rules['type includes']) unless rules['type includes'].nil?
      linux_rules_type_excludes_input.type_text(rules['type excludes']) unless rules['type excludes'].nil?
    end

    def get_linux_backup_rules()
      rules = {
          "name includes" => linux_rules_name_includes_input.value,
          "name excludes" => linux_rules_name_excludes_input.value,
          "type includes" => linux_rules_type_includes_input.value,
          "type excludes" => linux_rules_type_excludes_input.value
      }
      rules
    end

    def lock_cascade_setting_linux_backup(backup_hash)
      if backup_hash['action'] == 'check'
        find(:xpath, "//label/b[text()='#{backup_hash['backup name']}']/../../../td[#{backup_hash['index']}]/input").check
      else
        find(:xpath, "//label/b[text()='#{backup_hash['backup name']}']/../../../td[#{backup_hash['index']}]/input").uncheck
      end
    end

    def lock_cascade_setting_linux_backup_disabled?(backup_hash)
      wait_until{find(:xpath, "//table//b[text()='#{backup_hash['backup name']}']/../../td[#{backup_hash['index']}]/input").visible?}
      find(:xpath, "//table//b[text()='#{backup_hash['backup name']}']/../../td[#{backup_hash['index']}]/input")['disabled']
    end

    def lock_cascade_setting_linux_backup_checked?(backup_hash)
      if(all(:xpath, "//table//b[text()='#{backup_hash['backup name']}']/../../td[#{backup_hash['index']}]/input").size >0)
        action_xpath = "//table//b[text()='#{backup_hash['backup name']}']/../../td[#{backup_hash['index']}]/input"
      else
        action_xpath = "//label/b[text()='#{backup_hash['backup name']}']/../../../td[#{backup_hash['index']}]/input"
      end
      find(:xpath, action_xpath).checked?
    end

    def click_done
      done_link.click
    end

    def cancel_edit_linuxset
      cancel_linuxset_link.click
    end

    def alert_accept
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.driver.browser.switch_to.alert.accept
      else
        raise("alert_accept method only works for Selenium Driver")
      end
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