module Bus
  class OrderDataShuttleView < PageObject
    # Search section elements
    element(:search_partner_tb, {:id => "pro_partner_search"})
    element(:search_partner_btn, {:xpath => "//div[@id='resource-choose_pro_partner_for_new_seed-content']//input[@value='Submit']"})
    element(:search_results_table, {:xpath => "//div[@id='resource-choose_pro_partner_for_new_seed-content']//table[@class='table-view']"})
    element(:clear_search_link, {:link => "Clear search"})

    # Verify Shipping Address section elements
    element(:name_tb, {:id => "seed_device_order_name"})
    element(:address1_tb, {:id => "seed_device_order_address1"})
    element(:address2_tb, {:id => "seed_device_order_address2"})
    element(:city_tb, {:id => "seed_device_order_city"})
    element(:state_tb, {:id => "seed_device_order_state"})
    element(:country_select, {:id => "seed_device_order_country"})
    element(:zip_tb, {:id => "seed_device_order_zip"})
    element(:phone_tb, {:id => "seed_device_order_phone_number"})
    element(:power_adapter_select, {:id => "seed_device_order_sku"})
    element(:verify_address_next, {:xpath => "//div[@id='wizard-buttons-right']//input[@value='Next']"})

    # Create Order section elements
    elements(:tables, {:xpath => "//form[@id='resource-create_new_seed_form']//table[@class='table-view']"})
    element(:add_new_key, {:link => "Add New Key"})
    element(:order_quota, {:id => "ordered_licenses_-1_quota"})
    element(:order_assign_to, {:id => "ordered_licenses_-1_assigned_to"})
    # Summary section elements


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
    #  view_partner_detail("Lego Company")
    #
    # Returns Nothing
    def view_order_detail(company_name)
      driver.find_element(:link, company_name).click
    end

    def available_keys_table
      tables[0]
    end

    def order_keys_table
      tables[1]
    end


  end
end