module Bus
  # This class provides actions for list user groups section
  class SearchListMachinesSection < SiteHelper::Section
    # Private elements
    #
    element(:search_user_tb, id: "machine_search")
    element(:search_user_btn, xpath: "//div[@id='machine-list-content']/div/form//input[@value='Submit']")
    element(:user_filter_select, id: "user_filter")
    element(:search_results_table, xpath: "//div[@id='machine-list-content']/div/table")
    element(:clear_search_link, link: "Clear search")
  end
end
