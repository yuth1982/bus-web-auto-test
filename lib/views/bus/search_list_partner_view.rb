module Bus
  class SearchListPartnerView < PageObject
    element(:search_partner_tb, {:id => "pro_partner_search"})
    element(:search_partner_btn, {:xpath => "//div[@id='partner-list-content']//input[@value='Submit']"})
    element(:search_results_table, {:xpath => "//div[@id='partner-list-content']//table[@class='table-view']"})
    element(:clear_search_link, {:link => "Clear search"})
    element(:include_sub_partners_cb, {:id => "include_subpartners"})
    # Public: Search partner by search text
    #
    # Examples
    #
    #  search_partner("qa1+test@mozy.com")
    #
    # Returns Nothing
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
    #  view_partner_detail("Lego Company")
    #
    # Returns Nothing
    def view_partner_detail(search_key)
      driver.find_element(:link, search_key).click
    end

    # Public: View partner's root admin detail by click root admin email/username
    #
    # Examples
    #
    #  view_root_admin_detail("qa1+test@mozy.com")
    #
    # Returns Nothing
    def view_root_admin_detail(search_key)
      driver.find_element(:link, search_key).click
    end
  end
end