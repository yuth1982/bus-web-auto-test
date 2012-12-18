module Bus
  # This class provides actions for list user groups section
  class SearchListMachinesSection < SiteHelper::Section
    # Private elements
    #
    element(:search_machine_tb, id: "machine_search")
    element(:search_machine_btn, xpath: "//div[@id='machine-list-content']/div/form//input[@value='Submit']")
    element(:machine_filter_select, id: "machine_filter")
    element(:search_results_table, xpath: "//div[@id='machine-list-content']/div/table")
    element(:clear_search_link, xpath: "//table[@id=('search_box')]//tr/td[1]/a")
    element(:machine_mapping_link, xpath: "//p[2]/a")

    def navigate_to_machine_mapping
      machine_mapping_link.click
    end

    # Public: Search results table header row text
    #
    # Example
    #   @bus_admin_console_page.search_list_machines_section.search_results_table_headers
    #
    # Returns search results table rows text array
    def search_results_table_headers
      search_results_table.headers_text
    end

    # Public: Search results table body rows text
    #
    # Example
    #
    #  @bus_admin_console_page.search_list_machines_section.search_results_table_rows
    #  # => ["", "qa1+new+user+test@mozy.com", "new user 1", "0", "0 bytes", "0", "none", "08/15/12", "never"]
    #
    # Return search results table body rows text array
    def search_results_table_rows
      search_results_table.rows_text
    end
  end
end
