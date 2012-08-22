module Bus
  # This class provides actions for change plan section
  class ChangePlanSection < PageObject

    # Constants
    #
    ADD_ON_LIST_LOC = "addon_products_list"

    element(:current_plan_table, {:xpath => "div[@id='current_resources_area']/table"})
    # Mozypro
    #
    element(:pro_base_plan_select, {:id => "products_base_exclusive"})
    element(:pro_server_plan_cb, {:xpath => "//div[@id='#{ADD_ON_LIST_LOC}']/input[@type='checkbox']"})
    element(:pro_storage_add_on_tb, {:xpath => "//div[@id='#{ADD_ON_LIST_LOC}']/input[@type='text']"})

    # MozyEnterprise
    #
    element(:enterprise_users_tb, {:xpath => "//div[@id='base_plans']//input[starts-with(@id, 'products_base_')]"})
    element(:enterprise_server_plan_select, {:id => "products_addon_exclusive"})
    element(:enterprise_server_add_on_tb, {:xpath => "//div[@id='#{ADD_ON_LIST_LOC}']/input[starts-with(@id, 'products_addon_')]"})

    # Reseller
    #
    element(:reseller_quota, {:id => "products_exclusive_base_qty" })
    element(:reseller_server_add_on_tb, {:xpath => "//div[@id='#{ADD_ON_LIST_LOC}']/input[@type='text']"})
    element(:reseller_server_plan_cb, {:xpath => "//div[@id='#{ADD_ON_LIST_LOC}']/input[@type='checkbox']"})

    # Common
    element(:submit_btn, {:id => "submit_new_resources_btn" })
    element(:coupon_code_tb, {:id => "coupon_code"})
    element(:charge_summary_table, {:xpath => "//div[@id='charge_summary']/table" })
    element(:continue_btn, {:xpath => "//div[@id='change_plan_confirmation']//input[@value='Continue']" })
    element(:cancel_btn, {:xpath => "//div[@id='change_plan_confirmation']//input[@value='Cancel']" })
    element(:message_div, {:xpath => "//div[@id='resource-change_billing_plan-errors']/ul"})

    # Public: Change mozyporo account's plan
    #
    # Example
    #   @bus_admin_console_page.change_plan_section.change_mozypro_plan("100 GB, $39.99","yes","coupon code")
    #
    # Returns nothing
    def change_mozypro_plan(base_plan, server_plan, coupon, storage_add_on=0)
      unless base_plan.empty?
        pro_base_plan_select.displayed?
        pro_base_plan_select.select_by(:text, base_plan, true)
      end
      pro_storage_add_on_tb.type_text(storage_add_on) unless storage_add_on == 0
      unless server_plan.empty?
        pro_server_plan_cb.check if server_plan.eql?("yes")
      end
      unless coupon.empty?
        coupon_code_tb.type_text(coupon)
        # work around for trigger onchange event to enable submit button
        sleep 1
        coupon_code_tb.send_keys([:space])
        #driver.execute_script("document.getElementById('submit_new_resources_btn').disabled=false")
      end
      sleep 5
      confirm_change
    end

    # Public: Change mozyporo account's plan
    #
    # Example
    #   @bus_admin_console_page.change_plan_section.change_mozyenterprise_plan(2,"50 GB Server Plan, $296.78",2,"coupon code")
    #
    # Returns nothing
    def change_mozyenterprise_plan(users, server_plan, server_add_on, coupon)
      enterprise_users_tb.type_text(users) unless users == 0
      enterprise_server_plan_select.select_by(:text, server_plan, true) unless server_plan.empty?
      enterprise_server_add_on_tb.type_text(server_add_on) unless server_add_on == 0
      coupon_code_tb.type_text(coupon)
      confirm_change
    end

    # Public: Change mozyporo account's plan
    #
    # Example
    #   @bus_admin_console_page.change_plan_section.change_reseller_plan("100 GB, $39.99","yes","coupon code")
    #
    # Returns nothing
    def change_reseller_plan(quota, server_plan, server_add_on, coupon)
      reseller_quota.type_text(quota) unless quota == 0
      reseller_server_add_on_tb.type_text(server_add_on)
      unless server_plan.empty
        reseller_server_plan_cb.check if server_plan.eql?("yes")
      end
      coupon_code_tb.type_text(coupon)
      confirm_change
    end

    # Public: Messages for change change plan actions
    #
    # Example
    #  @bus_admin_console_page.change_plan_section.messages
    #  # => "Resources have been changed on your account."
    #
    # Returns success or error message text
    def messages
      message_div.text
    end

    # Public: Change plan charge summary table rows text
    #
    # Example
    #   @bus_admin_console_page.change_plan_section.charge_summary_table_rows
    #   # => [["Discounts Applied","-$19.99"],
    #         ["Charge for upgraded plansl","$52.98"],
    #         ["Total amount to be charged","$32.99"]]
    #
    # Returns order summary table rows text
    def charge_summary_table_rows
      charge_summary_table.rows_text
    end

    # Public: Change plan charge summary table headers text
    #
    # Example
    #   @bus_admin_console_page.change_plan_section.charge_summary_table_headers
    #   # => ["Description", "Amount"]
    #
    # Returns order summary table rows text
    def charge_summary_table_headers
      charge_summary_table.headers_text
    end

    # Public:
    #
    # Example
    #
    #  # => ["10 GB", "50 GB", "100 GB", "250 GB", "500 GB", "1 TB", "2 TB", "4 TB", "8 TB", "12 TB", "16 TB", "20 TB", "24 TB", "28 TB", "32 TB"]
    #
    #
    def mozypro_available_base_plans
      pro_base_plan_select.options.map{ |opt| opt.text.match(/(\d+) (GB|TB)/)[0]}
    end

    # Public: MozyPro current purchase
    #
    def mozypro_base_plan
      pro_base_plan_select.first_selected_option.text
    end

    def mozypro_server_plan?
      pro_server_plan_cb.checked?
    end

    def mozypro_storage_add_on
      pro_storage_add_on_tb.value
    end

    def mozyenterprise_users
      enterprise_users_tb.value
    end

    def mozyenterprise_server_plan
      enterprise_server_plan_select.first_selected_option.text
    end

    def mozyenterprise_server_add_on
      enterprise_server_add_on_tb.value
    end

    private
    def confirm_change
      submit_btn.click
      continue_btn.click
      sleep 20 # force wait for change plan
    end
  end
end