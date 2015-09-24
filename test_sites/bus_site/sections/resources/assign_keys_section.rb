module Bus
  # This class provides actions for assign keys section
  class AssignKeysSection < SiteHelper::Section

    # Private elements
    #
    element(:assign_btn, xpath: "//input[@value='Assign']")


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


  end
end
