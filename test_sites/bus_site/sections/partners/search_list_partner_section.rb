module Bus
  # This class provides actions for search list partner page section
  class SearchListPartnerSection < SiteHelper::Section

    # Private elements
    #
    element(:search_partner_tb, id: 'pro_partner_search')
    element(:search_partner_btn, css: 'div#partner-list-content input[value=Submit]')
    element(:partner_filter_select, id: 'pro_partner_filter')
    element(:include_sub_partners_cb, id: 'include_subpartners')
    element(:full_search_cb, id: 'full_search')
    element(:clear_search_link, xpath: "//a[text()='Clear search']")
    element(:search_results_table, css: 'div#partner-list-content table.table-view')

    # Public: Search partner
    #
    # search_key - keywords to be searched
    # filter - select filter from drop down list
    # include_sub_partner - search results including sub partner or not
    #
    # Examples
    #  @bus_admin_console_page.search_list_partner_section.search_partner("qa1+test@mozy.com")
    #
    # Returns nothing
    def search_partner(search_key, filter = 'None', include_sub_partners = true, full_search =true)
      # By default, include sub partners is checked
      if include_sub_partners
        include_sub_partners_cb.check
      else
        include_sub_partners_cb.uncheck
      end
      wait_until_bus_section_load # Wait to load sub partners
      if full_search
        full_search_cb.check
      else
        full_search_cb.uncheck
      end
      search_partner_tb.type_text(search_key)
      partner_filter_select.select(filter)
      search_partner_btn.click
      alert_accept if full_search
      wait_until_bus_section_load
    end

    # Public: Search results hashes
    #         Converts results table into an Array of Hash where the keys of each Hash are the headers in the table.                                                                                               # Example
    #
    #  @bus_admin_console_page.search_list_users_section.search_results_hashes
    #  # => ["User"=>"user@mozy.com", "Name"=>"Test User", "Machines"=>0, "Storage"=>"15 GB", “Storage Used"=>0, "Created"=>"08/15/12"", "Backed Up"=>"never"]
    #
    # Returns hash array
    def search_results_hashes
      search_results_table.rows_text.map{ |row| Hash[*search_results_table.headers_text.zip(row).flatten] }
    end

    # Public: Search results table header row text
    #
    # Example
    #
    #  @bus_admin_console_page.search_list_partner_section.search_results_tb_header_text
    #  # => ["External ID", "Partner", "Created", "Root Admin", "Type", "Users", "Licenses", "Quota"]
    #
    # Returns search results table rows text array
    def search_results_table_headers
      search_results_table.headers_text
    end

    # Public: Search results table body rows text
    #
    # Example
    #
    #  @bus_admin_console_page.search_list_partner_section.search_results_table_rows
    #  # => ["", "Izio Oil & Gas Pipelines Company", "07/11/12", "qa1+frank+hamilton@mozy.com", "MozyEnterprise", "0", "201", "625 GB"]
    #
    # Return search results table body rows text array
    def search_results_table_rows
      search_results_table.rows_text
    end

    # Public: View partner detail by click partner's company name
    #
    # Examples
    #
    #  @bus_admin_console_page.search_list_partner_section.view_partner_detail("Lego Company")
    #
    # Returns nothing
    def view_partner_detail(search_key)
      # Make sure include sub partners checked
      include_sub_partners_cb.check
      wait_until_bus_section_load # Wait to load sub partners
      find(:xpath, "//a[text()='#{search_key}']").click
    end

    # Public: View partner's root admin detail by click root admin email/username
    #
    # Examples
    #
    #  @bus_admin_console_page.search_list_partner_section.view_root_admin_detail("qa1+test@mozy.com")
    #
    # Returns nothing
    def view_root_admin_detail(search_key)
      find(:xpath, "//a[text()='#{search_key}']").click
    end

    def clear_search
      clear_search_link.click
    end

    def search_input_text
      search_partner_tb.value
    end
  end
end
