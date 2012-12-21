module Bus
  # This class provides actions for change plan section
  class ChangePlanSection < SiteHelper::Section

    # Plans
    element(:pro_base_plan_select, id: "products_base_exclusive")
    element(:enterprise_users_tb, css: "input[id^=products_base_]")

    element(:storage_add_on_tb, css: "input[id^=products_addon_]")
    element(:server_plan_select, css: "select[id^=products_addon_]")
    element(:server_plan_change_link, css: "span#clickable-change-link a")
    element(:coupon_code_tb, id: "coupon_code")
    element(:server_plan_status_span, id: "server-pass-status")

    # Common
    element(:current_plan_table, css: "div#current_resources_area table")
    element(:submit_btn, id: "submit_new_resources_btn" )
    element(:charge_summary_table, css: "div#charge_summary table")
    element(:continue_btn, css: "div#change_plan_confirmation input[value=Continue]")
    element(:cancel_btn, css: "div#change_plan_confirmation input[value=Cancel]")
    element(:message_div, css: "div#resource-change_billing_plan-errors ul")

    # Public: Change MozyPro plan
    #
    # Example
    #   @bus_site.admin_console_page.change_mozypro_plan('100 GB', 'yes', '2', 'COUPONCODE')
    #
    # Returns nothing
    def change_mozypro_plan(base_plan, server_plan, storage_add_on, coupon)
      server_plan_locator = "//label[contains(text(),'Server Plan')]"
      # Find current server plan id e.g. 'products_addon_10353251, Server Plan, $12.99'
      current_server_plan_id = find(:xpath, server_plan_locator)[:for]
      unless base_plan.nil?
        pro_base_plan_select.select(base_plan)
        wait_until{
          # Wait for ajax call back
          # Find target server plan id e.g. 'products_addon_10353259, Server Plan, $19.99'
          target_server_plan_id = find(:xpath, server_plan_locator)[:for]
          target_server_plan_id != current_server_plan_id
        }
      end

      unless server_plan.nil?
        server_plan_change_link.click
        wait_until{ server_plan_select.visible? }
        server_plan_select.select(server_plan.capitalize)
      end

      unless storage_add_on.nil?
        storage_add_on_tb.type_text(storage_add_on)
      end

      coupon_code_tb.type_text(coupon) unless coupon.nil?
      confirm_change
    end

    # Public: Change MozypEnterprise plan
    #
    # Example
    #   @bus_site.admin_console_page.change_mozyenterprise_plan(2,"50 GB Server Plan, $296.78",2,"COUPONCODE")
    #
    # Returns nothing
    def change_mozyenterprise_plan(users, server_plan, server_add_on, coupon)
      enterprise_users_tb.type_text(users) unless users.nil?
      server_plan_select.select(server_plan) unless server_plan.nil?
      storage_add_on_tb.type_text(server_add_on) unless server_add_on.nil?
      coupon_code_tb.type_text(coupon) unless coupon.nil?
      confirm_change
    end

    # Public: Change reseller plan
    #
    # Example
    #   @bus_site.admin_console_page.change_reseller_plan(100,"yes",2,"COUPONCODE")
    #
    # Returns nothing
    def change_reseller_plan(server_plan, server_add_on)
      storage_add_on_tb.type_text(server_add_on) unless server_add_on.nil?
      unless server_plan.nil?
        server_plan_change_link.click
        wait_until{ server_plan_select.visible? }
        server_plan_select.select(server_plan.capitalize)
      end
      confirm_change
    end

    # Public: Return messages for change plan actions
    #
    # Example
    #  @bus_site.admin_console_page.change_plan_section.messages
    #  # => "Resources have been changed on your account."
    #
    # Returns success or error message text
    def messages
      message_div.text
    end

    # Public: Return change plan charge summary table rows text
    #
    # Example
    #   @bus_site.admin_console_page.change_plan_section.charge_summary_table_rows
    #   # => [["Discounts Applied","-$19.99"],
    #         ["Charge for upgraded plansl","$52.98"],
    #         ["Total amount to be charged","$32.99"]]
    #
    # Returns order summary table rows text
    def charge_summary_table_rows
      charge_summary_table.rows_text
    end

    # Public: Return change plan charge summary table headers text
    #
    # Example
    #   @bus_site.admin_console_page.change_plan_section.charge_summary_table_headers
    #   # => ["Description", "Amount"]
    #
    # Returns order summary table rows text
    def charge_summary_table_headers
      charge_summary_table.headers_text
    end

    def current_plan_table_headers
      current_plan_table.headers_text
    end

    # Public:
    #
    # Example
    #  @bus_site.admin_console_page.mozypro_available_base_plans
    #  # => ["10 GB", "50 GB", "100 GB", "250 GB", "500 GB", "1 TB", "2 TB", "4 TB", "8 TB", "12 TB", "16 TB", "20 TB", "24 TB", "28 TB", "32 TB"]
    #
    #  Return an array of mozypro base plans
    def mozypro_available_base_plans
      pro_base_plan_select.options.map{ |opt| opt.text.match(/(\d+) (GB|TB)/)[0]}
    end

    # Public: MozyPro current purchase
    #
    # Example
    #   @bus_site.admin_console_page.change_plan_section
    #
    # Returns string
    def mozypro_base_plan
      pro_base_plan_select.first_selected_option.text
    end

    # Public: Current server plan status
    #
    # Example
    #   @bus_site.admin_console_page.change_plan_section.server_plan_status
    #
    # Returns string
    def server_plan_status
      server_plan_status_span.text
    end

    # Public: Storage add on value
    #
    # Example
    #   @bus_site.admin_console_page.change_plan_section.storage_add_on
    #
    # Returns string
    def storage_add_on
      storage_add_on_tb.value
    end

    # Public: MozyEnterprise current users
    #
    # Example
    #   @bus_site.admin_console_page.change_plan_section.mozyenterprise_users
    #
    # Returns string
    def mozyenterprise_users
      enterprise_users_tb.value
    end

    # Public: MozyEnterprise current server plan
    #
    # Example
    #   @bus_site.admin_console_page.change_plan_section.mozyenterprise_server_plan
    #
    # Returns string
    def mozyenterprise_server_plan
      server_plan_select.first_selected_option.text
    end

    private

    # Private: Confirm change plan
    #
    # Example
    #   @bus_site.admin_console_page.change_plan_section.confirm_change
    #
    # Returns nothing
    def confirm_change
      page.execute_script("document.getElementById('submit_new_resources_btn').disabled=false")
      sleep 2 # refactor later
      submit_btn.click
      continue_btn.click
    end
  end
end