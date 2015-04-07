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
    element(:machine_mapping_link, xpath: "//div[@id='machine-list-content']/p[2]/a")
    element(:export_csv_link, css: "p.table-export-links a")

    def navigate_to_machine_mapping
      machine_mapping_link.click
    end

    def search_results_hashes
      search_results_table.hashes
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

    # Public: Click to export the machine csv
    #
    # Example
    #   @bus_admin_console_page.search_list_machines_section.export_csv
    #
    # Returns null
    def export_csv
      export_csv_link.click
    end

    # Public: Get the downloaded machines.csv and users.csv if exist
    #
    # Example
    #   @bus_admin_console_page.search_list_machines_section.machine_user_csv_file
    #
    # Returns ['machines.csv', 'users.csv']
    def machine_user_csv_files machine, user
      flag = 0
      CONFIGS['global']['default_wait_time'].times do
        if file_exists?("#{machine}") && file_exists?("#{user}")
          flag = 1
          break
        end
        sleep(2)
      end
      return [machine, user] if flag == 1
    end

    # Public: Open the machine details section
    #
    # @param [String] machine_name
    #
    # Example
    #   @bus_site.admin_console_page.search_list_machine_section.view_machine_details("AUTOTEST")
    #
    # @return [] nothing
    def view_machine_details(machine_name)
      find_link(machine_name).click
    end

    def search_list_machines_opened
      search_machine_tb.visible?
    end
  end
end
