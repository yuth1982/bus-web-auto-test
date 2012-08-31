module Bus
  # This class provides actions for manage resource section
  class ManageResourcesSection < SiteHelper::Section

    # Private elements
    #
    element(:change_link, xpath: "//div[@id='unassigned-resources']//a[text()='Change']")
    element(:quota_tb, id: "quota")
    element(:assign_storage_btn, css: "input[name='assign_storage']")
    element(:message_div, xpath: "//div[@id='resource-available_key_list-errors']/ul") #Quota changed.

    elements(:general_info_span, xpath: "//div[@id='resource-available_key_list-content']/div[2]/div/div/span[@class='value']")

    # Public: Assign a new quota to a MozyPro partner
    #         upgrade or downgrade
    #
    #
    def assign_mozypro_storage(new_quota)
      change_link.click
      quota_tb.type_text(new_quota)
      assign_storage_btn.click
      sleep 5
    end

    def mozypro_total_storage
      general_info_span[0].text
    end

    def mozypro_unallocated_storage
      general_info_span[1].text
    end

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
