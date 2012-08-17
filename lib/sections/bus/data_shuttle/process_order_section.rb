module Bus
  # This class provides actions for order a new data shuttle page section
  class ProcessOrderSection < PageObject

    # Private elements
    #
    # Verify shipping address section
    element(:verify_shipping_address_table, {:xpath => "//form[@id='resource-create_new_seed_form']/div/ul[2]/li/table"})

    element(:all_msg_div, {:xpath => "//ul[@class='flash successes' or @class='flash errors']"})
    element(:message_div, {:xpath => "//ul[@class='flash successes' or @class='flash errors']/li"})

    element(:name_tb, {:id => "seed_device_order_name"})
    element(:address1_tb, {:id => "seed_device_order_address1"})
    element(:address2_tb, {:id => "seed_device_order_address2"})
    element(:city_tb, {:id => "seed_device_order_city"})
    element(:state_tb, {:id => "seed_device_order_state"})
    element(:country_select, {:id => "seed_device_order_country"})
    element(:zip_tb, {:id => "seed_device_order_zip"})
    element(:phone_tb, {:id => "seed_device_order_phone_number"})
    element(:power_adapter_select, {:id => "seed_device_order_sku"})
    elements(:next_btns, {:xpath => "//div[@id='wizard-buttons-right']//input[@value='Next']"})

    # Create order section
    elements(:keys_tables, {:xpath => "//form[@id='resource-create_new_seed_form']/div/ul[2]/li[2]//table[@class='table-view']"})
    element(:add_new_key, {:link => "Add New Key"})

    # Summary section
    elements(:summary_tables, {:xpath => "//form[@id='resource-create_new_seed_form']/div/ul[2]/li[3]//table[@class='table-view']"})
    element(:num_win_drivers_tb, {:id => "seed_device_order_win_drive_num"})
    element(:num_mac_drivers_tb, {:id => "seed_device_order_mac_drive_num"})
    element(:is_ship_driver_cb, {:id => "seed_device_order_skip_order_fulfillment"})
    element(:submit_order_btn, {:id => "seed_wizard_finish_button"})

    def address_desc_column_text
      verify_shipping_address_table.rows_text.map{ |row| row[0] }
    end

    # Public: Click create order tab
    #
    # Example
    #    @bus_admin_console_page.process_order_section.go_to_create_order_section
    #
    # Return nothing
    def go_to_create_order_section
        next_btns[0].click
    end

    # Public: Click summary tab
    #
    # Example
    #    @bus_admin_console_page.process_order_section.go_to_summary_section
    #
    # Return nothing
    def go_to_summary_section
      next_btns[1].click
    end

    # Public: Shipping address text
    #
    def shipping_address
      [name_tb.value,address1_tb.value,address2_tb.value,city_tb.value,state_tb.value,country_select.first_selected_option.text,zip_tb.value,phone_tb.value,power_adapter_select.first_selected_option.text]
    end

    # Public: Process a data shuttle order
    #
    #  Example
    #    @bus_admin_console_page.process_order_section.create_order(order_object)
    #
    # Return nothing
    def create_order(order)
      # fill shipping address section
      power_adapter_select.select_by(:text, order.adapter_type)
      go_to_create_order_section
      sleep 10 # wait for load create order section
      # fill create order section
      case order.key_from
        when "available"
          # Add key from available keys
          add_available_key.click
        when "new"
          add_new_key.click
        else
          raise "Please order key from either available keys or add a new key"
      end
      sleep 15 # wait for load order keys
      os_tb.select_by(:text, order.os)
      order_quota_tb.type_text(order.quota)
      order_assign_to_tb.type_text(order.assign_to)
      go_to_summary_section
      sleep 10 # wait for load summary section

      # fill summary section
      if all_msg_div.text.empty?
        discount_tb.type_text(order.discount)
        discount_tb.send_keys(:tab)  # focus out of discount text box, make sure discount amount changes
        sleep 2
        num_win_drivers_tb.type_text(order.num_win_drivers) if order.num_win_drivers > 0
        num_mac_drivers_tb.type_text(order.num_mac_drivers) if order.num_mac_drivers > 0
        is_ship_driver_cb.check unless order.ship_driver
        submit_order_btn.click
      end
      sleep 10 # wait for complete ordering data shuttle
    end

    # Public: Messages for process order actions
    #
    # Example
    #  @bus_admin_console_page.process_order_section.messages
    #  # => "Please select the power adapter type."
    #
    # Returns success or error message text
    def messages
      message_div.text
    end

    # Public: Data shuttle order summary table rows text
    #
    # Example
    #   @bus_admin_console_page.add_new_partner_section.order_summary_table_rows
    #   # => [["Data Shuttle 1.8 TB","1","$137.50"],
    #         ["Total Price","","$137.50"]]
    #
    # Returns order summary table rows text
    def order_summary_table_rows
      summary_tables[1].rows_text
    end

    def num_win_driver_ordered
      num_win_drivers_tb.value
    end

    def num_mac_driver_ordered
      num_mac_drivers_tb.value
    end

    private

    def available_keys_table
      keys_tables[0]
    end

    def order_keys_table
      keys_tables[1]
    end

    def add_available_key
      available_keys_table.rows.first.last.find_element(:tag_name,"a")
    end

    def os_tb
      order_keys_table.rows.first[2].find_element(:tag_name,"select")
    end

    def order_quota_tb
      order_keys_table.rows.first[4].find_element(:tag_name,"input")
    end

    def order_assign_to_tb
      order_keys_table.rows.first[5].find_element(:tag_name,"input")
    end

    def licence_key_table
      summary_tables[0]
    end

    def discount_tb
      licence_key_table.rows.first.last.find_element(:tag_name, "input")
    end

  end
end
