module Bus
  # This class provides actions for list roles section
  class ListRolesSection < SiteHelper::Section

    def list_role(role_name)
      multi_page_link = "//div[@class='table-metadata']//p[3]//a"
      role_name_link = "//a[text()='#{role_name}']"
      index = 1
      while (all(:xpath, role_name_link).size == 0)
        find(:xpath, multi_page_link+"[#{index}]").click
        wait_until_bus_section_load
        index += 1
      end
      find(:xpath, role_name_link).click
    end

    def all_role_name_started_with(name)
      all(:xpath, "//a[starts-with(., \"#{name}\")]")
    end
  end
end
