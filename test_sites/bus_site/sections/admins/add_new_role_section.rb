module Bus
  # This class provides actions for add new role section
  class AddNewRoleSection < SiteHelper::Section
    element(:role_select, id: "role_subpartner_role")
    element(:name_tb, id: "role_name")
    element(:role_parent_select, id: "role_parent_role_id")
    element(:message_div, css: 'div#roles-new-errors ul')

    element(:submit_btn, xpath: "//div[@id='roles-new-content']//input[contains(@value, 'Save Changes')]")


    # Public: Add a new role with given role object information
    #
    # role_obj - role object with role information
    #
    # Example
    #   @bus_admin_console_page.add_new_role_section.add_new_role(role_obj)
    #
    # Returns nothing
    def add_new_role(role_obj)
      role_select.select(role_obj.type)
      name_tb.type_text(role_obj.name)
      role_parent_select.visible? && role_parent_select.select(role_obj.parent) unless role_obj.parent.nil?
      submit_btn.click
    end

    # Public: Append capabilities with given capability array
    #
    # capabilities - [["Partners: add"], ["Partners: list/view"]]
    #
    # Example
    #   @bus_admin_console_page.add_new_role_section.add_capabilities([["Partners: add"], ["Partners: list/view"]])
    #
    # Returns nothing
    #
    # NOTE - Only apply to new roles created
    def add_capabilities(capabilities)
      capabilities.each do | c |
        Log.debug("Processing #{c[0]}")
        e = find(:xpath, "//label[text() = '#{c[0]}']")
        e.child[0].check
      end
      save_btn = all(:xpath, "//input[contains(@value, 'Save Changes')]")[-1]
      save_btn.click
    end

    def messages
      message_div.text
    end
  end
end
