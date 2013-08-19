module Bus
  # This class provides actions for add new admin section
  class AddNewAdminSection < SiteHelper::Section
    element(:name_tb,id: "new_admin_display_name")
    element(:email_tb,id: "new_admin_username")
    elements(:user_groups_cb,xpath: "//div[@id='user_groups']/ul/li/label")
    elements(:roles_cb,xpath: "//div[@id='roles']/ul/li/label")
    element(:save_changes_btn,xpath: "//div[@id='admin-new-content']//form/table//input[@value='Save Changes']")
    element(:message, xpath: "//div[@id='admin-new-errors']/ul/li")

    def add_new_admin(admin_obj)
      name_tb.set(admin_obj.name)
      email_tb.set(admin_obj.email)
      #TODO - parent admin selection implementation

      admin_obj.user_groups.each do | ug |
        Log.debug("Processing grant user group #{ug} to admin")
        e = find(:xpath, "//label[text() = ' #{ug}'")
        e.child[0].check
      end

      admin_obj.roles.each do | r |
        Log.debug("Processing grant role #{r} to admin")
        e = find(:xpath, "//label[text() = ' #{r}']")
        e.child[0].check
      end
      save_changes_btn.click
    end

    # Public: Messages for Add New Admin section
    #
    # Example
    #  @bus_admin_console_page.add_new_admin_section.messages
    #  # => "New Admin created. Please have the Admin check his or her email to complete the process."
    #
    # @return [String]
    def messages
      message.text
    end
  end
end
