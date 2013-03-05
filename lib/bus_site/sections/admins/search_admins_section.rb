module Bus
  # This class provides actions for search admins section
  class SearchAdminsSection < SiteHelper::Section
    # Private elements
    #
    element(:search_admin_tb, id: "admin_search")
    element(:search_admin_btn, xpath: "//table[@id='search_box']//input[@value='Submit']")
    element(:search_results_table, xpath: "//div[@id='admin-search-content']/div/div/table")
    element(:clear_search_link, link: "Clear search")

    def search_admin(search_key)
      search_admin_tb.type_text(search_key)
      search_admin_btn.click
      wait_until_bus_section_load
    end

  end
end
