module Bus
  # This class provides actions for add new admin section
  class AuthenticationPolicySection < SiteHelper::Section
    element(:provider_mozy_rd, id: "provider-mozy")
    element(:provider_ldap_rd, id: "provider-ldap")
    element(:auth_config_fields, id: "auth_config_fields")
    element(:data_horizon_configs_org_name, id: "data_horizon_configs_org_name")
    element(:test_org_name, id: "test_org_name")
    element(:authentication_policies_edit_errors, xpath: "//div[@id='authentication_policies-edit-errors']/ul")

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

    # Public: Fillin organization name for horizon manager
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

    def test_connection
      test_org_name.click
    end

    def test_connection_result
      authentication_policies_edit_errors.text
    end
  end
end