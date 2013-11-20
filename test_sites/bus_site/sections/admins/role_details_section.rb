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

    def add_all_available_capabilities
      wait_until_bus_section_load
      all(:css, 'input[id^=capability]').each do |ch|
        ch.check
      end
      find(:css, 'div[id^=roles-show] input[class=button]').click
    end
  end
end
