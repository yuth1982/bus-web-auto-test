module Bus
  # This class provides actions for change plan section
  class ChangePlanSection < SiteHelper::Section

    # Plans
    element(:pro_base_plan_select, id: "products_base_exclusive")
    element(:enterprise_users_tb, css: "input[id^=products_base_]")
    element(:desktop_licenses_tb, xpath: "//div[@id='base_plans']/div[3]/input")
    element(:server_licenses_tb, xpath: "//div[@id='base_plans']/div[4]/input")
    
    element(:storage_add_on_tb, css: "input[id^=products_addon_]")
    element(:server_plan_select, css: "select[id^=products_addon_]")
    element(:server_plan_change_link, css: "span#clickable-change-link a")
    element(:coupon_code_tb, id: "coupon_code")
    element(:server_plan_status_span, id: "server-pass-status")

    # Itemized
    elements(:itemized_plans_tbs, css: "div#base_plans_group input")

    # Common
    element(:current_plan_table, css: "div#current_resources_area table")
    element(:submit_btn, id: "submit_new_resources_btn" )
    element(:charge_summary_table, css: "div#charge_summary table")
    element(:continue_btn, css: "div#change_plan_confirmation input[value=Continue]")
    element(:cancel_btn, css: "div#change_plan_confirmation input[value=Cancel]")
    element(:message_div, css: "div#resource-change_billing_plan-errors ul")

    # Public: Reseller Supplemental Plans Hashes
    #
    #
    def reseller_supp_plans_hash
      storage_add_on_label = find(:css, "label[for=#{storage_add_on_tb.id}]").text
      {'storage add on type' => storage_add_on_label.split(',')[0],
       '# storage add on' => storage_add_on_tb.value,
       'has server plan' => server_plan_status_span.text}
    end

    # Public: Change MozyPro plan
    # 
    # @param [Integer] users
    # @param [String] server_plan
    # @param [Integer] server_add_on
    # @param [String] coupon
    # @param [Object] user_group
    #
    # Example
    #   @bus_site.admin_console_page.change_mozypro_plan('100 GB', 'yes', '2', 'COUPONCODE', @user_group)
    #
    # @return [nothing]

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
    # @param [Integer] users
    # @param [String] server_plan
    # @param [Integer] server_add_on
    # @param [String] coupon
    # @param [Object] user_group
    #
    # Example
    #   @bus_site.admin_console_page.change_mozyenterprise_plan(2,"50 GB Server Plan, $296.78",2,"COUPONCODE", @user_group)
    #
    # @return [nothing]
    def change_mozyenterprise_plan(users, server_plan, server_add_on, coupon, user_group)

      unless users.nil?
        if !user_group.nil? && user_group.name == "(default user group)"
          #update @user_group obj will refactor later
          user_group.desktop_device = users.to_i
        end
        wait_until { enterprise_users_tb.visible? }
        enterprise_users_tb.type_text(users)
      end
      
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
    
    # Public: Change itemized plan
    #
    # @param [String] server_licenses
    # @param [String] desktop_licenses
    # @param [Object] user_group
    #
    # Example
    #  @bus_site.admin_console_page.change_plan_section.change_itemized_plan("2", "2", @user_group)
    #
    # @return [nothing]     
    def change_itemized_plan(server_licenses, desktop_licenses, user_group)
      
      unless server_licenses.nil?
        if !user_group.nil? && user_group.name == "(default user group)"
          #update @user_group obj will refactor later
          user_group.server_device = user_group.server_device + server_licenses.to_i
        end
        wait_until { server_licenses_tb.visible? }
        server_licenses = server_licenses.to_i + server_licenses_tb.value.to_i
        server_licenses_tb.type_text(server_licenses)
      end
      
      unless desktop_licenses.nil?
        if !user_group.nil? && user_group.name == "(default user group)"
          #update @user_group obj will refactor later
          user_group.desktop_device = user_group.desktop_device + desktop_licenses.to_i
        end
        wait_until { desktop_licenses_tb.visible? }
        desktop_licenses = desktop_licenses.to_i + desktop_licenses_tb.value.to_i
        desktop_licenses_tb.type_text(desktop_licenses)
      end

      confirm_change
      
    end

    # Public: Change itemized partner plan
    #
    # Example
    #   @bus_site.admin_console_page.change_itemized_partner_plan('1','2','1','2')
    #
    # Returns nothing
    def change_itemized_partner_plan(server_license, server_quota, desktop_license, desktop_quota)
      wait_until_bus_section_load
      itemized_plans_tbs[0].type_text(server_quota) unless server_quota.nil?
      itemized_plans_tbs[1].type_text(desktop_quota) unless desktop_quota.nil?
      itemized_plans_tbs[2].type_text(desktop_license) unless desktop_license.nil?
      itemized_plans_tbs[3].type_text(server_license) unless server_license.nil?
      confirm_change
    end

    # Public: Current itemized account resources
    #
    # Example
    #  @bus_admin_console_page.purchase_resources_section.current_purchased_resources
    #  # => "server_plan => 1, server_quota => 2, desktop_license => 1, desktop_quota => 3"
    #
    # Returns resource object contains number of server license, server quota, desktop license and desktop quota
    def current_itemized_resources
      wait_until_bus_section_load
      resources = Struct.new(:server_license, :server_quota, :desktop_license, :desktop_quota)
      server_license = itemized_plans_tbs[3].value.to_i
      server_quota = itemized_plans_tbs[0].value.to_i
      desktop_license = itemized_plans_tbs[2].value.to_i
      desktop_quota = itemized_plans_tbs[1].value.to_i
      resources.new(server_license, server_quota, desktop_license, desktop_quota)
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

    def itemized_current_plan_hash
      wait_until_bus_section_load
      Hash['server quota' => itemized_plans_tbs[0].value, 'desktop quota' => itemized_plans_tbs[1].value, 'desktop license' => itemized_plans_tbs[2].value, 'server license' => itemized_plans_tbs[3].value]
    end

    private

    # Private: Confirm change plan
    #
    # @param [none]
    #
    # Example
    #   @bus_site.admin_console_page.change_plan_section.confirm_change
    #
    # @return [nothing] 
    def confirm_change
      wait_until { submit_btn.visible? }
      submit_btn.click
      wait_until { continue_btn.visible? }
      continue_btn.click
    end
  end
end