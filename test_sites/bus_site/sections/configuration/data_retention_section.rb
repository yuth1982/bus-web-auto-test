module Bus
  # This class provides actions for data retention page section
  class DataRetentionSection < SiteHelper::Section

    # Constants
    #
    ACC_SETTINGS_DIV_ID = "setting-edit_account_settings-content"

    # Private elements
    #
    element(:partner_adr_policy_link, xpath: "//div[@id='setting-adr_status-content']/div/h5/a")
    element(:user_group_adr_policy_table, xpath: "//div[@id='setting-adr_status-content']/div[3]//table")
    element(:sub_partner_adr_policy_table, xpath: "//div[@id='setting-adr_status-content']/div[5]//table[@class='table-view']")
    element(:adr_policy_name_select, xpath: "//select[@id='adr_policy_period_value']")
    element(:save_adr_policy_btn, xpath: "//input[@value='Save']")
    element(:password_input, xpath: "//input[@name='password']")
    element(:submit_adr_policy_btn, xpath: "//input[@value='Submit'][@type='button']")
    element(:message_div, xpath: "//div[starts-with(@id,'setting-change_adr_policy-')]/ul/li")


    # Pubic: get adr policy of the partner, user group, sub partner
    #
    # Example
    #  @bus_admin_console_page.account_details_section.data_retention_section.get_adr_policy
    #
    # Returns adr_policy
    def get_adr_policy
      adr_policy = Bus::DataObj::ADRPolicy.new
      adr_policy.partner_adr = data_ad_connection_host.value
      adr_policy.default_user_group_adr = data_ad_connection_host.value
      adr_policy.sub_partner_adr = data_ad_connection_host.value
      adr_policy
    end

    def get_partner_adr_policy
      partner_adr_policy_link.text
    end

    def user_group_adr_policy_table_hashes
      user_group_adr_policy_table.rows_text
    end

    def sub_partner_adr_policy_table_hashes
      sub_partner_adr_policy_table.rows_text
    end

    # Public: reports table entire text
    #
    # Example
    #   @bus_admin_console_page.scheduled_reports_section.reports_table_text
    #   # => "No results found"
    #
    # Returns reports table text
    def sub_partner_adr_policy_table_text
      sub_partner_adr_policy_table.text
    end

    def click_partner_adr_policy
      partner_adr_policy_link.click
    end

    def create_adr_policy(policy, password)
      adr_policy_name_select.select(policy)
      save_adr_policy_btn.click
      password_input.type_text(password)
      submit_adr_policy_btn.click
    end

    def messages
      message_div.text
    end

  end
end