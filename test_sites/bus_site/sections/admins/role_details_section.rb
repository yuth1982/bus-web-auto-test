module Bus
  # This class provides actions for add new role section
  class RoleDetailsSection < SiteHelper::Section
    element(:delete_role_lnk, xpath: "//a[text() = 'Delete Role']")

    #TODO
    def update_name(role_name)

    end

    def delete_role(role_name)
      delete_role_lnk.click
      alert_accept
    end
  end
end
