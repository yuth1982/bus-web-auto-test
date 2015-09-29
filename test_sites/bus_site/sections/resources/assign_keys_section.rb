module Bus

  # This class provides actions for assign keys section
  class AssignKeysSection < SiteHelper::Section

    # Private elements
    #
    element(:assign_btn, xpath: "//input[@value='Assign']")
    elements(:assign_key_summary_spans, xpath: "//div[@class='show-details']/div/div/span[@class='label' or @class='value']")


    def click_user_group(user_group)
      find(:xpath, "//a[text()='#{user_group}']").click
    end

    def assign_keys_to_email(type, email)
      find(:xpath, "//td[text()='#{type}']//../../tr[1]/td[4]/input[contains(@id,'key_email')]").type_text(email)
      find(:xpath, "//td[text()='#{type}']//../../tr[1]/td[2]").text
    end

    def click_assign_button
      assign_btn.click
    end

    def resources_general_info_hash
      array = assign_key_summary_spans.map{ |span| span.text }
      Hash[*array]
    end

  end
end
