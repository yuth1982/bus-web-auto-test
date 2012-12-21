module Bus
  # This class provides actions for purchase resources section
  class PurchaseResourcesSection < SiteHelper::Section

    # Private elements
    #
    element(:user_group_search_img, css: "img[alt='Search-button-icon']")
    element(:server_license_tb, id: "licenses_Server")
    element(:server_quota_tb, id: "quota_Server")
    element(:desktop_license_tb, id: "licenses_Desktop")
    element(:desktop_quota_tb, id: "quota_Desktop")
    element(:continue_btn, css: "input[value=Submit]")
    element(:submit_purchase_btn, id: "btn-purchase_resource_submit")
    element(:message_span, css: "div#resource-purchase_resources-content div span")

    # Public: Purchase resources
    #
    # Example
    #   @bus_admin_console_page.purchase_resources_section.purchase
    #
    # Returns nothing
    def purchase(user_group, desktop_license, desktop_quota, server_license, server_quota)
      unless user_group.nil?
        user_group_search_img.click
        sleep 2
        find(:xpath, "//li[contains(text(),'#{user_group}')]").click
      end
      server_license_tb.type_text(server_license) unless server_license.nil?
      server_quota_tb.type_text(server_quota) unless server_quota.nil?
      desktop_license_tb.type_text(desktop_license) unless desktop_license.nil?
      desktop_quota_tb.type_text(desktop_quota) unless desktop_quota.nil?
      continue_btn.click
      submit_purchase_btn.click
    end

    # Public: Messages for purchase resources actions
    #
    # Example
    #  @bus_admin_console_page.purchase_resources_section.messages
    #  # => "Quota changed."
    #
    # Returns success or error message text
    def messages
      message_span.text
    end

  end
end