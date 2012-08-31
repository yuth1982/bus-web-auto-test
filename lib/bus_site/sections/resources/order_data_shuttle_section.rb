module Bus
  # This class provides actions for order data shuttle page section
  class OrderDataShuttleSection < SiteHelper::Section

    # Private elements
    #
    # Search section elements
    element(:search_partner_tb, id: "pro_partner_search")
    element(:search_partner_btn, xpath: "//div[@id='resource-choose_pro_partner_for_new_seed-content']//input[@value='Submit']")
    element(:search_results_table, xpath: "//div[@id='resource-choose_pro_partner_for_new_seed-content']//table[@class='table-view']")
    element(:clear_search_link, link: "Clear search")

    # Public: Search partner by search text
    #
    # Examples
    #
    #  search_partner("qa1+test@mozy.com")
    #
    # Returns Nothing
    def search_partner(search_key)
      search_partner_tb.type_text(search_key)
      search_partner_btn.click
    end

    # Public: View partner detail by click partner's company name
    #
    # Examples
    #
    #  view_order_detail("Lego Company")
    #
    # Returns Nothing
    def view_order_detail(company_name)
      find_element(:link, company_name).click
    end
  end
end
