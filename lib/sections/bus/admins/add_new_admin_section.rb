module Bus
  # This class provides actions for add new admin section
  class AddNewAdminSection < PageObject
    element(:name_tb, {:id => "new_admin_display_name"})
    element(:email_tb, {:id => "new_admin_username"})
    elements(:user_groups_cb, {:xpath => "//div[@id='user_groups']/ul/li/label"})
    elements(:roles_cb, {:xpath => "//div[@id='roles']/ul/li/label"})
    element(:save_changes_btn, {:xpath => "//div[@id='admin-new-content']//form/table//input[@value='Save Changes']"})

    def add_new_admin(admin_obj)

    end

  end
end
