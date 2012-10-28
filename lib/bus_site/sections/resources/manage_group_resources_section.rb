module Bus
  # This class provides actions for manage group resource section
  class ManageGroupResourcesSection < SiteHelper::Section

    # MozyEnterprise
    #
    element(:send_email_cb, id: "send_emails")
    element(:assign_keys_btn, xpath: "//input[@name='assign_keys']")
    element(:message_div, xpath: "//div[starts-with(@id,'resource-group_available_keys-')]/ul") #Quota changed.

    # Assign a MozyEnterprise key to a user (email)
    #
    def assign_mozyenterprise_key(email, send_email = true)
      find(:xpath, "//input[starts-with(@id,'key_email_')]").type_text(email)
      send_email_cb.check if send_email
      assign_keys_btn.click
    end

    # Public: Messages for manage resources actions
    #
    # Example
    #  manage_group_resources_section.messages
    #  # => "1 key has been assigned."
    #
    # Returns success or error message text
    def messages
      message_div.text
    end
  end

end
