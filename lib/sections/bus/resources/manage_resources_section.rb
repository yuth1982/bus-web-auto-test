module Bus
  # This class provides actions for manage resource section
  class ManageResourcesSection < PageObject

    # Private elements
    #
    element(:change_link, {:xpath => "//div[@id='unassigned-resources']//a[text()='change']"})
    element(:quota_tb, {:id => "quota"})
    element(:assign_storage_btn, {:xpath => "//input[@name='assign_storage']"})
    element(:message_div, {:xpath => "//div[@id='resource-available_key_list-errors']/ul"}) #Quota changed.

    # Public: Assign a new quota to a MozyPro partner
    #         upgrade or downgrade
    #
    #
    def assign_mozypro_storage(new_quota)
      change_link.click
      quota_tb.type_text(new_quota)
      assign_storage_btn.click
    end

    def message_text
      message_div.text
    end
  end
end
