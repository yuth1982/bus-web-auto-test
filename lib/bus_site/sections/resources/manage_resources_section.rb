module Bus
  # This class provides actions for manage resource section
  class ManageResourcesSection < SiteHelper::Section

    # Private elements
    #
    elements(:resources_general_info_spans, xpath: "//div[@class='show-details']/div/div/span[@class='label' or @class='value']")
    elements(:resources_details_tables, css: "table.matrix_table")
    element(:user_groups_table, css: "table.mini_table")
    element(:manage_resource_content_div, id: "resource-available_key_list-content")

    # Batch key assignment
    element(:batch_key_assignment_link, xpath: "//a[text()='Perform batch key assignment']")
    element(:batch_key_assignment_div, xpath: "//div[starts-with(@id, 'resource-available_key_list-batch_form-')]")

    # Quota changed message
    element(:message_div, xpath: "//div[@id='resource-available_key_list-errors']/ul")

    # Public: User group general information
    #
    # Example
    #   @bus_site.admin_console_page.manage_resources_section.resources_general_info_hash
    #
    # Returns hash
    def resources_general_info_hash
      array = resources_general_info_spans.map{ |span| span.text }
      Hash[*array]
    end

    # Public: Find and click link by user group name
    #         Can be used to assign resources per user group in assign keys or manage resources
    #         Some company types do not have user groups enabled by default
    #
    # @param [string] group_name
    #
    # Example
    #  @bus_site.admin_console_page.manage_resources_section.select_group('Test user group')
    #
    # @return nothing
    def select_group(group_name)
      find_link(group_name).click
    end

    # Public: Allocate desktop resources for MozyPro partner
    #
    # @param [string] desktop_quota
    #
    # Example
    #   @bus_site.admin_console_page.manage_resources_section.allocate_mozypro_desktop_quota('10')
    #
    # Returns nothing
    def allocate_mozypro_desktop_quota(desktop_quota)
      desktop_span_1 = find(:id, "allocated_13")
      desktop_span_2 = find(:id, "allocated_change_13")
      desktop_span_1.find(:xpath, "//a[text()='Change']").click
      desktop_span_2.find(:id, "quota").type_text(desktop_quota)
      desktop_span_2.find(:css, "input[value='Submit']").click
    end

    # Public: Allocate server resources for MozyPro partner
    #
    # @param [string] server_quota
    #
    # Example
    #   @bus_site.admin_console_page.manage_resources_section.allocate_mozypro_server_quota('10')
    #
    # Returns nothing
    def allocate_mozypro_server_quota(server_quota)
      server_span_1 = find(:id, "allocated_14")
      server_span_2 = find(:id, "allocated_change_14")
      server_span_1.find_link('Change').click
      server_span_2.find(:id, "quota").type_text(server_quota)
      server_span_2.find(:css, "input[value='Submit']").click
    end

    # Public: Resources storage details table headers text
    #
    # Example
    #  @bus_site.admin_console_page.manage_resources_section.storage_details_table_headers
    #
    # Returns string array
    def storage_details_table_headers
      resources_details_tables[0].headers_text
    end

    # Public: Resources storage details table rows text
    #
    # Example
    #  @bus_site.admin_console_page.manage_resources_section.storage_details_table_rows
    #
    # Returns string array
    def storage_details_table_rows
      resources_details_tables[0].rows_text
    end

    # Public: Resources license details table headers text
    #
    # Example
    #  @bus_site.admin_console_page.manage_resources_section.license_details_table_headers
    #
    # Returns string array
    def license_details_table_headers
      resources_details_tables[1].headers_text
    end

    # Public: Resources license details table rows text
    #
    # Example
    #  @bus_site.admin_console_page.manage_resources_section.license_details_table_rows
    #
    # Returns string array
    def license_details_table_rows
      resources_details_tables[1].rows_text
    end

    # Public: User groups table headers text
    #
    # Example
    #  @bus_site.admin_console_page.manage_resources_section.user_groups_table_headers
    #
    # Returns string array
    def user_groups_table_headers
      user_groups_table.headers_text
    end

    # Public: User groups table rows text
    #
    # Example
    #  @bus_site.admin_console_page.manage_resources_section.user_groups_table_rows
    #
    # Returns string array
    def user_groups_table_rows
      user_groups_table.rows_text
    end

    # Public: Batch Assign a MozyPro keys
    #
    # @params [string] email_quota, [string] type, [bool] send_email
    #
    # Example
    #  @bus_site.admin_console_page.manage_resources_section.assign_mozypro_key('test_email@mozy.com,1','Desktop')
    #
    # @return nothing
    def batch_assign_mozypro_keys(email_quota, type, send_email = false)
      batch_key_assignment_link.click
      batch_key_assignment_div.find(:id, "emails").type_text(email_quota)
      batch_key_assignment_div.find(:id, "license_type").select(type)
      batch_key_assignment_div.find(:id, "send_emails").check if send_email
      batch_key_assignment_div.find(:css, "input[name='batch_assignment']").click
      wait_until{ batch_key_assignment_link.visible? }
    end

    # Public: Messages for manage resources actions
    #
    # Example
    #  @bus_admin_console_page.manage_resources_section.messages
    #  # => "Quota changed."
    #
    # Returns success or error message text
    def messages
      message_div.text
    end
  end
end
