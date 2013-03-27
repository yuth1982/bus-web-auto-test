module Bus
  # This class manage all sections for bus admin console page
  class AdminConsolePage < SiteHelper::Page

    set_url("#{BUS_ENV['bus_host']}/dashboard")

    # Partner section
    section(:search_list_partner_section, SearchListPartnerSection, id: "partner-list")
    section(:add_new_partner_section, AddNewPartnerSection, id: "partner-new")

    section(:partner_details_section, PartnerDetailsSection, css: "div[id^=partner-show-]")
    section(:admin_details_section, AdminDetailsSection, css: "div[id^=admin-show-]")

    # Configuration section
    section(:account_details_section, AccountDetailsSection, id: "setting-edit_account_settings")
    section(:authentication_policy_section, AuthenticationPolicySection, id: 'authentication_policies-edit')
    section(:client_config_section, ClientConfigSection, id: 'setting-edit_client_config')

    # Users section
    section(:search_list_users_section, SearchListUsersSection, id: "user-list")
    section(:search_list_machines_section, SearchListMachinesSection, id: "machine-list")
    section(:add_new_user_group_section, AddNewUserGroupSection, id: "user_groups-new")
    section(:add_new_user_section, AddNewUserSection, id: "user-new")
    section(:machine_mapping_section, MachineMappingSection, id: "machine-machine_migration")
    section(:user_group_details_section, UserGroupDetailsSection, css: "div[id^=user_groups-show-]")
    section(:list_user_groups_section, ListUserGroupsSection, id: "user_groups-list")
    section(:user_details_section, UserDetailsSection, css: "div[id^=user-show-]")

    # Admin section
    section(:add_new_role_section, AddNewRoleSection, id: "roles-new-content")
    section(:add_new_admin_section, AddNewAdminSection, id: "admin-new")
    section(:search_admins_section, SearchAdminsSection, id: "admin-search")
    section(:role_details_section, RoleDetailsSection, css: "div[id^=roles-show-]")
    section(:list_roles_section, ListRolesSection, id: "roles-list")

    # Resources section
    section(:change_plan_section, ChangePlanSection, id: "resource-change_billing_plan")
    section(:change_payment_info_section, ChangePaymentInfoSection, id: "resource-change_credit_card")
    section(:billing_history_section, BillingHistorySection, id: "resource-all_charges")
    section(:billing_info_section, BillingInfoSection, id: "resource-billing")
    section(:change_period_section, ChangePeriodSection, id: "resource-change_billing_period")
    section(:manage_resources_section, ManageResourcesSection, id: "resource-available_key_list")
    section(:manage_user_group_resources_section, ManageUserGroupResourcesSection , css: "div[id^=resource-group_available_keys-]")
    section(:transfer_resources_section, TransferResourcesSection, id: "resource-transfer_resources")
    section(:purchase_resources_section, PurchaseResourcesSection, id: "resource-purchase_resources")
    section(:return_resources_section, ReturnResourcesSection, id: "resource-unpurchase_resources")

    # Data shuttle section
    section(:data_shuttle_status_section, DataShuttleStatusSection, id: 'resource-data_shuttle_status')
    section(:order_data_shuttle_section, OrderDataShuttleSection, id: 'resource-choose_pro_partner_for_new_seed')
    section(:process_order_section, ProcessOrderSection, css: 'div[id^=resource-create_new_seed-].start-closed')
    section(:view_data_shuttle_orders_section, ViewDataShuttleOrdersSection, id: 'resource-view_seed_device_orders')
    section(:order_details_section, OrderDetailsSection, css: 'div[id^=resource-show_data_shuttle_order-]')

    section(:device_status_section, DeviceStatusSection, css: 'div[id^=resource-show_data_shuttle_device_status-]')
    section(:device_stuck_section, DeviceStuckSection, css: 'div[id^=resource-show_data_shuttle_device_status-]')
    section(:inventory_status_section, InventoryStatusSection, css: 'div[id^=resource-show_drive_inventory_status-]')

    # reports section
    section(:report_builder_section, ReportBuilderSection, id: "jobs-report_builder")
    section(:add_report_section, AddReportSection, xpath: "*")
    section(:scheduled_reports_section, ScheduledReportsSection, id: "jobs-index")
    section(:quick_reports_section, QuickReportsSection, id: "jobs-quick_reports")

    # Private element
    element(:current_admin_div, id: "identify-me")
    element(:stop_masquerading_link, xpath: "//a[text()='stop masquerading']")


    # Popup window
    element(:popup_content_div, css: "div.popup-window-content")
    element(:close_popup_link, css: "div.close_bar a")
    element(:close_btn, css: "div.popup-window-footer input[value=Close]")
    element(:continue_btn, css: "div.popup-window-footer input[value=Continue]")
    element(:cancel_btn, css: "div.popup-window-footer input[value=Cancel]")
    element(:submit_btn, css: "div.popup-window-footer input[value=Submit]")
    element(:buy_more_btn, css: "div.popup-window-footer input[value='Buy More']")
    element(:allocate_resources_btn, css: "div.popup-window-footer input[value=Allocate]")

    # Public: Navigate to menu item on admin console page
    # Note: if bus module is opened, menu will not be clicked
    #
    # Returns nothing
    def navigate_to_menu(link)
      el = find(:xpath, "//a[text()='#{link}']")
      el_class = el.element_parent[:class]
      if el_class.match(/active/).nil?
        el.click
      end
    end

    # Public: Stop Masquerading
    #
    # Returns nothing
    def stop_masquerading
      current_admin = current_admin_div.text
      stop_masquerading_link.click
      wait_until{ current_admin != current_admin_div.text}
    end

    def has_navigation?(link)
      all(:xpath, "//a[text() = '#{link}']")
    end

    def close_stash_invitation_popup
      find_link("Don't Show This Again").click
    end

    def popup_window_content
      popup_content_div.text
    end

    def close_popup_window
      close_popup_link.click
    end

    def buy_more_resources
      buy_more_btn.click
    end

    def allocate_resources
      allocate_resources_btn.click
    end

    def click_close
      close_btn.click
    end

    def click_continue
      continue_btn.click
    end

    def click_cancel
      cancel_btn.click
    end

    def click_submit
      submit_btn.click
    end
  end
end
