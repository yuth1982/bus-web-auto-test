module Bus
  # This class provides actions for list admins section
  class ListAdminsSection < SiteHelper::Section
    def view_admin(admin)
      find(:xpath, "//a[text()='#{admin}']").click
    end
  end
end
