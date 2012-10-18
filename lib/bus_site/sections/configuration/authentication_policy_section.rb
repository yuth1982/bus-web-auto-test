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
    # Sync rules tab
    element(:sync_rules_tab, xpath: "//div[@id='authentication_policies-edit-tabs']/ul[1]/li[2]")
    element(:attribute_mapping_tab, xpath: "//div[@id='authentication_policies-edit-tabs']/ul[1]/li[3]")
    element(:add_rule, id: 'add-provision-rule')
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
    element(:data_saml_connection_encryption, id: "data_saml_connection_encryption")

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
      test_ad_connection.click
    end

    def test_connection_result
      authentication_policies_edit_errors.text
    end

    def move_to_sync_rules
      sync_rules_tab.click
    end

    def add_rule
      add_rule_button.click
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

    def check_encrypt_saml(check)
      if check
        data_saml_connection_encryption.check
      else
        data_saml_connection_encryption.uncheck
      end
    end

    def fillin_certificate(cert)
      data_saml_connection_signing_key.set(cert)
    end

    def fillin_saml_settings(saml_info)
      fillin_auth_url(saml_info.auth_url)
      fillin_client_endpoint(saml_info.saml_endpoint)
      fillin_certificate(saml_info.saml_cert)
      check_encrypt_saml(saml_info.encrypted)
    end

    def saml_info
      saml_info = Bus::DataObj::SAMLInfo.new
      saml_info.auth_url = data_saml_connection_web_endpoint.value
      saml_info.saml_endpoint = data_saml_connection_client_endpoint.value
      saml_info.saml_cert = data_saml_connection_signing_key.value
      saml_info.encrypted = data_saml_connection_encryption.value
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
  end
end