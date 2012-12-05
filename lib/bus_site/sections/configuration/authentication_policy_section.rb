module Bus
  # This class provides actions for add new admin section
  class AuthenticationPolicySection < SiteHelper::Section

    # Connection Settings Tab with Horizon Application Manager selected
    element(:provider_mozy_rd, id: "provider-mozy")
    element(:provider_ldap_rd, id: "provider-ldap")
    element(:auth_config_fields, id: "auth_config_fields")
    element(:data_horizon_configs_org_name, id: "data_horizon_configs_org_name")
    element(:test_org_name, id: "test_org_name")
    element(:authentication_policies_edit_errors, xpath: "//div[@id='authentication_policies-edit-errors']/ul")
    # Connection Settings Tab without Horizon Application Manager selected
    element(:data_ad_connection_host, id: "data_ad_connection_host")
    elements(:protocol_rds, xpath: "//fieldset[@id='ad-connection']/div[2]/div/input")
    element(:data_ad_connection_cert, id: "data_ad_connection_cert")
    element(:data_ad_connection_port, id: "data_ad_connection_port")
    element(:data_ad_connection_base_dn, id: "data_ad_connection_base_dn")
    element(:data_ad_connection_bind_username, id: "data_ad_connection_bind_username")
    element(:data_ad_connection_bind_password, xpath: "//input[contains(@id, 'bind_password')]")
    #element(:bind_password, id: "bind_password")
    element(:test_ad_connection, id: "test_ad_connection")
    # SAML Authentication Tab with Horizon Application Manager selected
    element(:tab_titles, xpath: "//div[@id='authentication_policies-edit-tabs']/ul")
    element(:web_auth_enable_rd, id: "data_saml_connection_webauth_true")
    element(:mac_only_rd, id: "data_saml_connection_webauth_mac")
    element(:web_auth_disable_rd, id: "data_saml_connection_webauth_false")
    element(:load_horizon_attrs_btn, id: "load_horizon_attrs_btn")
    element(:data_saml_connection_web_endpoint, id: "data_saml_connection_web_endpoint")
    element(:data_saml_connection_client_endpoint, id: "data_saml_connection_client_endpoint")
    element(:data_saml_connection_signing_key, id: "data_saml_connection_signing_key")
    element(:saml_save_btn, xpath: "//div[@id='authentication_policies-edit-content']//input[@class='button']")
    element(:connection_settings_tab, "//div[@id='authentication_policies-edit-tabs']/ul[1]/li[1]")
    element(:sync_rules_tab, xpath: "//div[@id='authentication_policies-edit-tabs']/ul[1]/li[2]")
    element(:attribute_mapping_tab, xpath: "//div[@id='authentication_policies-edit-tabs']/ul[1]/li[3]")
    element(:saml_authentication_tab, xpath: "//div[@id='authentication_policies-edit-tabs']/ul[1]/li[4]")
    element(:save_changes_button, xpath: "//input[@value='Save Changes']")
    element(:sync_now_button, xpath: "//input[@name='sync_now']")
    element(:options_delete_missing_users, id: 'options_delete_missing_users')
    element(:options_suspend_missing_users, id: 'options_suspend_missing_users')
    element(:scheduled_sync_time, id: 'data_sync_options_schedule')
    element(:fixed_attribute, xpath: "//ul[@class='tab-panes']/li[3]//div[4]/div/input")
    element(:loading_link, xpath: "//a[contains(@onclick,'toggle_module')]")

    # Public: Select authentication provider
    #
    # Example
    #   @bus_admin_console_page.authentication_policy_section.select_auth('LDAP')
    #
    # Returns nothing
    def select_auth(provider)
      case provider
      when 'Mozy'
        provider_mozy_rd.check
      when 'Directory Service'
        provider_ldap_rd.check
      else
        raise "Unable to find provider of #{provider}"
      end
    end

    def provider_mozy_checked?
      provider_mozy_rd.checked?
    end

    def provider_ldap_checked?
      provider_ldap_rd.checked?
    end

    # Public: Choose Horizon manager or not
    #
    # check - Switch to check/uncheck horizon manager
    #
    # Example
    #   @bus_admin_console_page.authentication_policy_section.check_horizon(true)
    #
    # Returns nothing
    def check_horizon(check)
      if check
        auth_config_fields.check
      else
        auth_config_fields.uncheck
      end
    end

    # Public: Filling organization name for horizon manager
    #
    # org_name - Organization name
    #
    # Example
    #   @bus_admin_console_page.authentication_policy_section.fillin_org_name('mozyqa2')
    #
    # Returns nothing
    def fillin_org_name(org_name)
      data_horizon_configs_org_name.set(org_name)
    end

    def test_connection_horizon
      test_org_name.click
    end

    def test_connection_ad
      wait_until{ test_ad_connection[:class] != "disabled_for_spin" }
      test_ad_connection.click
    end

    def test_connection_result
      wait_until{ loading_link[:class] != "title loading" }
      authentication_policies_edit_errors.text
    end

    # the hash to decide the action depends on provision/deprovision
    def type_action_hash
      type_action_hash = {'provision'=> 'user_group', 'deprovision'=> 'action'}
    end

    # when moving from mozy to ad and before saving changes, the xpath is different
    def change_provider_connecting_settings
      find(:xpath, "//div[@id='authentication_policies-change_provider-tabs']/ul[1]/li[1]").click
    end

    def fill_in_rules(num, content)
      find(:xpath, "//ol[@id='provision-rules']//li[#{num}]//input").set(content)
    end

    def group_num
      find(:xpath, "//ol[@id='provision-rules']//select[1]").options.length
    end

    def group_names
      find(:xpath, "//ol[@id='provision-rules']//select[1]").options_text
    end

    # Public: Click the add rule button
    #
    # type - provision or deprovision
    #
    # Example
    #   @bus_admin_console_page.authentication_policy_section.add_rule('provision')
    #
    # Returns nothing
    def add_rule(type)
      find(:id, "add-#{type}-rule").click
    end

    # Public: Get the number of options in the dropdownlist
    #
    # type - provision or deprovision
    #
    # Example
    #   @bus_admin_console_page.authentication_policy_section.options_num('provision')
    #
    # Returns number of options
    def options_num(type)
      find(:xpath, "//ol[@id='#{type}-rules']//select[1]").options.length
    end

    # Public: Array of options text
    #
    def options_names(type)
      find(:xpath, "//ol[@id='#{type}-rules']//select[1]").options_text
    end

    # Public: The result after synced, include status, sync time, next sync time
    #
    def sync_result
      r = []
      (1..3).each { |num| r << find(:xpath, "//fieldset[@id='sync-status']/div[#{num}]/div").text }
      r
    end

    # Public: The layout of attribute_mapping_tab
    #
    def attribute_layout
      r = [[],[]]
      r[0] << find(:xpath, "//ul[@class='tab-panes']/li[3]//div[1]/label").text
      r[1] << find(:xpath, "//ul[@class='tab-panes']/li[3]//div[1]/div").text
      (2..4).each do |num|
        r[0] << find(:xpath, "//ul[@class='tab-panes']/li[3]//div[#{num}]/label").text
        r[1] << find(:xpath, "//ul[@class='tab-panes']/li[3]//div[#{num}]/div/input").value
      end
      r
    end

    # Public: Add rules
    #
    # type - provision or deprovision
    # number - rule number
    # rule - rule array
    # drop_down_content - the action or group array
    #
    # Example
    #   @bus_site.admin_console_page.authentication_policy_section.add_rules('provision', 2, ['dev_test*', 'qa_test*'], ['dev', 'qa'])
    #
    # Returns nothing
    def add_rules(type, number, rule, drop_down_content)
      (1..number).each do |num|
        find(:id, "add-#{type}-rule").click
        find(:xpath, "//ol[@id='#{type}-rules']//li[#{num}]//input").set(rule[num])
        if drop_down_content[num] != ''
          find(:xpath, "//ol[@id='#{type}-rules']//select[@name='data[rules][#{type}][#{num}][#{type_action_hash[type]}]']").select(drop_down_content[num])
        end
        Log.debug('add a new rule')
      end
    end

    # Public: Click the save changes button
    #
    def save_changes
      save_changes_button.click
    end

    # Public: The message show after saving changes
    #
    def result_message
      wait_until{ loading_link[:class] != "title loading" }
      authentication_policies_edit_errors.text
    end

    # Public: The number of rules that are added
    #
    def rule_num(type)
      if (page.has_xpath?("//ol[@id='#{type}-rules']//li"))
        all(:xpath,"//ol[@id='#{type}-rules']//li").length
      else
        0
      end
    end

    # Public: The status of arrows
    #
    # type - provision or deprovision
    # index - which number of rule
    #
    # Example
    #   @bus_site.admin_console_page.authentication_policy_section.arrow_status('provision', 2)
    #   #=> ['up', 'down', 'delete']
    #
    # Returns array of status
    def arrow_status(type, index)
      status = []
      (1..3).each { |i| status << find(:xpath, "//ol[@id='#{type}-rules']//li[#{index}]/a[#{i}]")['class'] }
      status
    end

    # Public: change the order of the rules
    #
    # type - provision or deprovision
    # index - which number of rule
    # action - make the rule up or down
    #
    # Example
    #   @bus_site.admin_console_page.authentication_policy_section.change_order('provision', 2, 'up')
    #
    # Returns nothing
    def change_order(type, index, action)
      find(:xpath, "//ol[@id='#{type}-rules']//li[#{index}]/a[@class='#{action}']").click
    end

    # Public: The array of rules order
    #
    # type - provision or deprovision
    #
    # Example
    #   @bus_site.admin_console_page.authentication_policy_section.rules_order('provision')
    #   #=> [['cn=dev_test*', 'dev'], ['cn=pm_test*', 'pm']]
    #
    # Returns array of status
    def rules_order(type)
      num = rule_num(type)
      rules = []
      num.times {rules << []}
      (1..num).each do |i|
        rules[i - 1] << find(:xpath, "//ol[@id='#{type}-rules']//li[#{i}]//input").value
        rules[i - 1] << find(:xpath, "//ol[@id='#{type}-rules']//select[@name='data[rules][#{type}][#{i}][#{type_action_hash[type]}]']").first_selected_option.text
      end
      rules
    end

    # Public: Delete a provision or deprovision rule
    #
    def delete_rule(type)
      find(:xpath, "//ol[@id='#{type}-rules']//li[1]/a[3]").click
      Log.debug("delete a rule")
    end

    # Public: The selected option of a dropdownlist
    #
    def selected_option(type)
      find(:xpath, "//ol[@id='#{type}-rules']//select[1]").first_selected_option.text
    end

    # Public: Click the sync now button
    #
    def sync_now
      sync_now_button.click
    end

    # Public: Refresh the page
    #
    def refresh
#      find(:xpath, "//a[@class='mod-button']").click
      page.find(:xpath, "//div[@id='authentication_policies-edit']//a[@class='mod-button']").click
    end

    # Public: Delete or suspend users if not synced for several days
    #
    def handle_user(method, days)
      uncheck_option =  method == 'delete' ? 'suspend' : 'delete'
      find(:id, "options_#{method}_missing_users").check
      find(:id, "options_#{uncheck_option}_missing_users").uncheck
      find(:id, "data_sync_options_#{method}_after_miss").set(days)
    end

    def clear_user_sync_info
      options_delete_missing_users.uncheck
      options_suspend_missing_users.uncheck
    end

    # Public: Set the daily sync at time
    #
    def sync_daily_at(hour)
      scheduled_sync_time.set(hour)
    end

    def sync_daily_time
      scheduled_sync_time.value
    end

    def set_fixed_attribute(attr)
      fixed_attribute.set(attr)
    end

    def load_attributes_result
      test_connection_result
    end

    def select_tab(tab_name)
      tab_titles.child.each do |c|
        c.click if c.text == tab_name
      end
    end

    def tabs
      tabs = []
      tab_titles.child.each do |c|
        tabs << c.text
      end
      tabs
    end

    def load_attributes
      load_horizon_attrs_btn.click
    end

    def load_attributes_alert_text
      load_horizon_attrs_btn.click
      text = alert_text
      alert_accept
      text
    end

    def auth_URL_disabled?
      !data_saml_connection_web_endpoint['disabled'].nil?
    end

    def auth_URL
      data_saml_connection_web_endpoint.value
    end

    def client_endpoint
      data_saml_connection_client_endpoint.value
    end

    def certificate
      data_saml_connection_signing_key.value
    end

    def encrypted_saml?
      data_saml_connection_encryption.checked?
    end

    def clear_all
      clear_auth_URL
      clear_client_endpoint
      clear_certificate
    end

    def clear_auth_URL
      data_saml_connection_web_endpoint.clear
    end

    def clear_client_endpoint
      data_saml_connection_client_endpoint.clear
    end

    def clear_certificate
      data_saml_connection_signing_key.clear
    end

    def save_saml_tab
      saml_save_btn.click
    end

    def fillin_connection_settings(connection_info)
      fillin_server_host(connection_info.server_host)
      select_protocol(connection_info.protocol)
      fillin_ssl_cert(connection_info.ssl_cert) unless connection_info.protocol == 'false'
      fillin_port(connection_info.port)
      fillin_base_dn(connection_info.base_dn)
      fillin_user(connection_info.bind_user, connection_info.bind_password)
    end

    def fillin_auth_url(auth_url)
      data_saml_connection_web_endpoint.set(auth_url)
    end

    def fillin_client_endpoint(client_endpoint)
      data_saml_connection_client_endpoint.set(client_endpoint)
    end

    def fillin_certificate(cert)
      data_saml_connection_signing_key.set(cert)
    end

    def fillin_saml_settings(saml_info)
      fillin_auth_url(saml_info.auth_url)
      fillin_client_endpoint(saml_info.saml_endpoint)
      fillin_certificate(saml_info.saml_cert)
    end

    def saml_info
      saml_info = Bus::DataObj::SAMLInfo.new
      saml_info.auth_url = data_saml_connection_web_endpoint.value
      saml_info.saml_endpoint = data_saml_connection_client_endpoint.value
      saml_info.saml_cert = data_saml_connection_signing_key.value
      saml_info
    end
    # Public: Select protocol to connect to LDAP server
    #
    # protocol - Which protocol to use in [starttls, ldaps, false]
    #
    # Example
    #   @bus_admin_console_page.authentication_policy_section.select_protocol("ldaps")
    #
    # Returns nothing
    def select_protocol(protocol)
      protocol_rds.each do | p |
        p.click if p.value == protocol
      end
    end

    def fillin_server_host(server)
      data_ad_connection_host.set(server)
    end

    def fillin_ssl_cert(cert)
      data_ad_connection_cert.set(cert)
    end

    def fillin_port(port)
      data_ad_connection_port.set(port)
    end

    def fillin_base_dn(base_dn)
      data_ad_connection_base_dn.set(base_dn)
    end

    def fillin_user(user, password)
      data_ad_connection_bind_username.set(user)
      data_ad_connection_bind_password.set(password)
    end

    def server_host_disabled?
      !data_ad_connection_host['disabled'].nil?
    end

    def connection_info
      connection_info = Bus::DataObj::ConnectionInfo.new
      connection_info.server_host = data_ad_connection_host.value
      protocol = protocol_rds.reject! {|p| p['checked'].nil?}
      connection_info.protocol = protocol.first.value == 'false' ? "no ssl" : protocol.first.value
      connection_info.ssl_cert = data_ad_connection_cert.value unless connection_info.protocol == 'no ssl'
      connection_info.port = data_ad_connection_port.value
      connection_info.base_dn = data_ad_connection_base_dn.value
      connection_info.bind_user = data_ad_connection_bind_username.value
      connection_info.bind_password = data_ad_connection_bind_password.value
      connection_info
    end

    def data_ad_connection_cert_displayed?
      data_ad_connection_cert.visible?
    end

    # selenium does not support this, use webkit
    def response_code
      status_code
    end

    def get_whitelist file
      SSHHelper.download(SSHHelper::SOCKD_CONF, "#{FileHelper.default_test_data_path}/#{file}")
    end

    def host_port_added old_file, new_file
      host_port = []
      Diffy::Diff.new("#{FileHelper.default_test_data_path}/#{new_file}", "#{FileHelper.default_test_data_path}/#{old_file}", :source => 'files').each do |line|
        case line
          when /^\+/
            #to do
          when /^-/
            if line =~ /to/
              host = /[\d\.]+/.match(line)
              port = /[\d]+$/.match(line)
              host_port << [host[0], port[0]]
            end
        end
      end
      host_port
    end
  end
end
