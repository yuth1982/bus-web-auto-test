module Bus
  # This class provides actions for list user groups section
  class SearchListMachinesSection < SiteHelper::Section
    # Private elements
    #
    element(:search_machine_tb, id: "machine_search")
    element(:search_machine_btn, xpath: "//div[@id='machine-list-content']/div/form//input[@value='Submit']")
    element(:machine_filter_select, id: "machine_filter")
    element(:search_results_table, xpath: "//div[@id='machine-list-content']/div/table")
    element(:clear_search_link, link: "Clear search")
    element(:machine_mapping_link, link: "Machine Mapping")

    def navigate_to_machine_mapping
      machine_mapping_link.click
    end
  end
end
