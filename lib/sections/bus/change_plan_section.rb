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
    element(:pro_server_add_on_cb, {:xpath => "//div[@id='#{ADD_ON_LIST_LOC}']/input[starts-with(@id, 'products_addon_')]"})

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
    def change_mozypro_plan(base_plan, server_plan, coupon)
      pro_base_plan_select.displayed?
      pro_base_plan_select.select_by(:text, base_plan)
      sleep 5 # Wait for load server plan
      @driver.execute_script("document.getElementById('change_billing_plan_form').onchange")
      unless server_plan == ""
        pro_server_add_on_cb.check if server_plan.eql?("yes")
      end
      coupon_code_tb.type_text(coupon)
      confirm_change
    end

    # Public: Change mozyporo account's plan
    #
    # Example
    #   @bus_admin_console_page.change_plan_section.change_mozyenterprise_plan(2,"50 GB Server Plan, $296.78",2,"coupon code")
    #
    # Returns nothing
    def change_mozyenterprise_plan(users, server_plan, server_add_on, coupon)
      enterprise_users_tb.type_text(users)
      enterprise_server_plan_select.select_by(:text, server_plan)
      enterprise_server_add_on_tb.type_text(server_add_on)
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
      unless server_plan == ""
        reseller_server_plan_cb.check if server_plan.eql?("yes")
      end
      coupon_code_tb.type_text(coupon)
      confirm_change
    end

    # Public: Messages for change change plan actions
    #
    # Example
    #  @bus_admin_console_page.change_plan_section.message_text
    #  # => "Resources have been changed on your account."
    #
    # Returns success or error message text
    def message_text
      message_div.text
    end

    # Public: Change plan charge summary table rows text
    #
    # Example
    #   @bus_admin_console_page.change_plan_section.charge_summary_tb_rows_text
    #   # => [["Discounts Applied","-$19.99"],
    #         ["Charge for upgraded plansl","$52.98"],
    #         ["Total amount to be charged","$32.99"]]
    #
    # Returns order summary table rows text
    def charge_summary_tb_rows_text
      charge_summary_table.rows_text
    end

    # Public: Change plan charge summary table headers text
    #
    # Example
    #   @bus_admin_console_page.change_plan_section.charge_summary_tb_headers_text
    #   # => ["Description", "Amount"]
    #
    # Returns order summary table rows text
    def charge_summary_tb_headers_text
      charge_summary_table.headers_text
    end

    private
    def confirm_change
      # Force enable submit button
      driver.execute_script("document.getElementById('submit_new_resources_btn').disabled=false")
      submit_btn.click
      continue_btn.click
      sleep 20 # force wait for change plan
    end
  end
end