module Bus
  # This class provides actions for list roles section
  class ListRolesSection < SiteHelper::Section

    def list_role(role_name)
      find(:xpath, "//a[text() = '#{role_name}']").click
    end

    def all_role_name_started_with(name)
      all(:xpath, "//a[starts-with(., \"#{name}\")]")
    end
  end
end
