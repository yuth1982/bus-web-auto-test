module Bus
  # This class provides actions for search list partner view
  class SearchListPartnerSection < PageObject

    # Private elements
    #
    element(:search_partner_tb, {:id => "pro_partner_search1"})
    element(:search_partner_btn, {:xpath => "//div[@id='partner-list-content']//input[@value='Submit']"})
    element(:search_results_table, {:xpath => "//div[@id='partner-list-content']//table[@class='table-view']"})
    element(:clear_search_link, {:link => "Clear search"})
    element(:include_sub_partners_cb, {:id => "include_subpartners"})

    # Public: search results table header row text
    #
    # Example
    #
    #  @@bus_admin_console_page.search_list_partner_section.search_results_tb_header_text
    #  # => ["External ID", "Partner", "Created", "Root Admin", "Type", "Users", "Licenses", "Quota"]
    #
    # Returns search results table rows text array
    def search_results_tb_header_text
      search_results_table.header_row_text
    end

    # Public: search results table body rows text
    #
    # Example
    #
    #  @@bus_admin_console_page.search_list_partner_section.search_results_tb_rows_text
    #  # => ["", "Izio Oil & Gas Pipelines Company", "07/11/12", "qa1+frank+hamilton@mozy.com", "MozyEnterprise", "0", "201", "625 GB"]
    #
    # Return search results table body rows text array
    def search_results_tb_rows_text
      search_results_table.body_rows_text
    end

    # Public: Search partner by search text
    #
    # Examples
    #
    #  @bus_admin_console_page.search_list_partner_section.search_partner("qa1+test@mozy.com")
    #
    # Returns nothing
    def search_partner(search_key)
      include_sub_partners_cb.check
      search_partner_tb.type_text(search_key)
      search_partner_btn.click
      raise "error on search / list partners action" unless clear_search_link.displayed?
    end

    # Public: View partner detail by click partner's company name
    #
    # Examples
    #
    #  @bus_admin_console_page.search_list_partner_section.view_partner_detail("Lego Company")
    #
    # Returns nothing
    def view_partner_detail(search_key)
      driver.find_element(:link, search_key).click
    end

    # Public: View partner's root admin detail by click root admin email/username
    #
    # Examples
    #
    #  @bus_admin_console_page.search_list_partner_section.view_root_admin_detail("qa1+test@mozy.com")
    #
    # Returns nothing
    def view_root_admin_detail(search_key)
      driver.find_element(:link, search_key).click
    end
  end
end