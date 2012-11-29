module Bus
  # This class provides actions for manage resource section
  class ManageResourcesSection < SiteHelper::Section

    # Private elements
    #
    element(:manage_resource_content_div, id: "resource-available_key_list-content")
    element(:select_group, link: "Select different group")
    #element(:group_select, id: "user_group_id")
    #element(:submit_group_btn, xpath: "//input[@name='select_group']")

    # MozyPro
    element(:change_link, xpath: "//span[starts-with(@id, 'allocated_')]//a[text()='Change']")
    element(:quota_tb, id: "quota")
    element(:assign_storage_btn, css: "input[name='assign_storage']")
    element(:message_div, xpath: "//div[@id='resource-available_key_list-errors']/ul") #Quota changed.


    elements(:general_info_span, xpath: "//div[@id='resource-available_key_list-content']/div[2]/div/div/span[@class='value']")


    # Public: Find and click link by user group name
    #         Can be used to assign resources per user group in assign keys or manage resources
    #         Some company types do not have user groups enabled by default
    #
    # @param [string] group_name
    #
    # Example
    #  @bus_site.admin_console_page.manage_resources_section.select_group(user_group)
    #
    # @return nothing
    def select_group(group_name)
      #group_select.select(group_name)
      #submit_group_btn.click
      find_link(group_name).click
    end

    # Public: Assign a MozyEnterprise key to a user and send email
    #
    # @param [string] email
    #
    # Example
    #  @bus_site.admin_console_page.manage_resources_section.assign_mozypro_key("qa1+automation+james.omally@mozy.com")
    #
    # @return nothing
    def assign_mozypro_key(email, send_email = true)
      find(:xpath, "//input[starts-with(@id,'key_email_')]").type_text(email)
      send_email_cb.check if send_email
      assign_keys_btn.click
    end

    # Public: Allocate a new quota to a MozyPro partner
    #         upgrade or downgrade
    #
    # @param [integer] new_quota
    #
    # Example
    #  @bus_site.admin_console_page.manage_resources_section.assign_mozypro_storage(250)
    #
    # @return nothing
    def assign_mozypro_storage(new_quota)
      change_link.click
      quota_tb.type_text(new_quota)
      assign_storage_btn.click
      sleep 5
    end

    # Public: Returns the mozypro total storage
    #
    # Example
    #  @bus_site.admin_console_page.manage_resources_section.mozypro_total_storage.should == total unless total.empty?
    #
    # @return [String]
    def mozypro_total_storage
      general_info_span[0].text
    end

    # Public: Returns the mozypro unallocated storage
    #
    # Example
    #  @bus_site.admin_console_page.manage_resources_section.mozypro_unallocated_storage.should == unallocated unless unallocated.empty?
    #
    # @return [String]
    def mozypro_unallocated_storage
      general_info_span[1].text
    end

    # Public: Returns the mozypro server enabled status(yes, no)
    #
    # Example
    #  @bus_site.admin_console_page.manage_resources_section.mozypro_enable_server.should == add_on unless enable_server.empty?
    #
    # @return [String]
    def mozypro_enable_server
      general_info_span[2].text
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
