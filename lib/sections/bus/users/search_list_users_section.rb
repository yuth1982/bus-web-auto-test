module Bus
  # This class provides actions for search list users section
  class SearchListUsersSection < PageObject
    # Private elements
    #
    element(:search_user_tb, {:id => "user_search"})
    element(:search_user_btn, {:xpath => "//div[@id='user-list-content']/div/form//input[@value='Submit']"})
    element(:user_filter_select, {:id => "user_filter"})
    element(:search_results_table, {:xpath => "//div[@id='user-list-content']/div/table"})
    element(:clear_search_link, {:link => "Clear search"})

    # Public: Search user
    #
    # Examples
    #  @bus_admin_console_page.search_list_users_section.search_user("qa1+test@mozy.com", "None")
    #
    # Returns nothing
    def search_user(keywords, filter = "None")
      search_user_tb.type_text(keywords)
      user_filter_select.select_by(:text, filter)
      search_user_btn.click
      raise "error on search / list user action" unless clear_search_link.displayed?
    end

    # Public: Search results table header row text
    #
    # Example
    #
    #  @bus_admin_console_page.search_list_users_section.search_results_tb_header_text
    #  # => ["User", "Name", "Machines", "Storage", “Storage Used", "Created", "Backed Up"]
    #
    # Returns search results table rows text array
    def search_results_tb_headers_text
      search_results_table.headers_text
    end

    # Public: Search results table body rows text
    #
    # Example
    #
    #  @bus_admin_console_page.search_list_users_section.search_results_tb_rows_text
    #  # => ["", "qa1+new+user+test@mozy.com", "new user 1", "0", "0 bytes", "0", "none", "08/15/12", "never"]
    #
    # Return search results table body rows text array
    def search_results_tb_rows_text
      search_results_table.rows_text
    end
  end
end
