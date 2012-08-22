module Bus
  # This class provides actions for search admins section
  class SearchAdminsSection < PageObject
    # Private elements
    #
    element(:search_admin_tb, {:id => "admin_search"})
    element(:search_user_btn, {:xpath => "//table[@id='search_box']//input[@value='Submit']"})
    element(:search_results_table, {:xpath => "//div[@id='admin-search-content']/div/div/table"})
    element(:clear_search_link, {:link => "Clear search"})
  end
end