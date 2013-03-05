module Bus
  # This class provides actions for list roles section
  class ListRolesSection < SiteHelper::Section

    def list_role(role_name)
      find(:xpath, "//a[text() = '#{role_name}']").click
    end

  end
end
