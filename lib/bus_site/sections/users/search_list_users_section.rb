module Bus
  # This class provides actions for search list users section
  class SearchListUsersSection < SiteHelper::Section
    # Private elements
    #
    element(:search_user_tb, id: "user_search")
    element(:search_user_btn, xpath: "//div[@id='user-list-content']/div/form//input[@value='Submit']")
    element(:user_filter_select, id: "user_filter")
    element(:search_results_table, xpath: "//div[@id='user-list-content']/div/table")
    element(:clear_search_link, xpath: "//a[text()='Clear search']")
    element(:refresh_link, xpath: "//a[@class='mod-button']")

    # Public: Search user
    #
    # Examples
    #  @bus_admin_console_page.search_list_users_section.search_user("qa1+test@mozy.com", "None")
    #
    # Returns nothing
    def search_user(keywords, filter = "None")
      search_user_tb.type_text(keywords)
      user_filter_select.select(filter)
      search_user_btn.click
      has_clear_search_link?
    end

    # Public: Search results table header row text
    #
    # Example
    #
    #  @bus_admin_console_page.search_list_users_section.search_results_table_headers
    #  # => ["User", "Name", "Machines", "Storage", “Storage Used", "Created", "Backed Up"]
    #
    # Returns search results table rows text array
    def search_results_table_headers
      search_results_table.headers_text
    end

    # Public: Search results table body rows text
    #
    # Example
    #
    #  @bus_admin_console_page.search_list_users_section.search_results_table_rows
    #  # => ["", "qa1+new+user+test@mozy.com", "new user 1", "0", "0 bytes", "0", "none", "08/15/12", "never"]
    #
    # Return search results table body rows text array
    def search_results_table_rows
      search_results_table.rows_text
    end

    # Public: Click the user link to view user details
    #
    # Example
    #
    #  @bus_admin_console_page.search_list_users_section.view_user_details('qa1+new+user+test@mozy.com')
    #
    # Return search results table body rows text array
    def view_user_details(user)
      find_link(user).click
    end

    def refresh
      refresh_link.click
      sleep 6
    end
  end
end
