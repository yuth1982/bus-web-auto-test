module Bus
  # This class provides actions for add new admin section
  class AddNewAdminSection < SiteHelper::Section
    element(:name_tb,id: "new_admin_display_name")
    element(:email_tb,id: "new_admin_username")
    elements(:user_groups_cb,xpath: "//div[@id='user_groups']/ul/li/label")
    elements(:roles_cb,xpath: "//div[@id='roles']/ul/li/label")
    element(:message_div, css: "div#admin-new-errors ul")
    element(:save_changes_btn,xpath: "//div[@id='admin-new-content']//form/table//input[@value='Save Changes']")

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

    def messages
      message_div.text
    end
  end
end
