module Bus
  # This class manage all sections for bus admin console page
  class AdminConsolePage < SiteHelper::Page

    set_url("#{BUS_ENV['bus_host']}/dashboard")

    # Partner section
    section(:search_list_partner_section, SearchListPartnerSection, id: "partner-list")
    section(:add_new_partner_section, AddNewPartnerSection, id: "partner-new")

    section(:partner_details_section, PartnerDetailsSection, xpath: "//div[starts-with(@id, 'partner-show-')]")
    section(:admin_details_section, AdminDetailsSection, xpath: "//div[starts-with(@id, 'admin-show-')]")

    # Configuration section
    section(:account_details_section, AccountDetailsSection, id: "setting-edit_account_settings")
    section(:authentication_policy_section, AuthenticationPolicySection, id: 'authentication_policies-edit')

    # Users section
    section(:search_list_users_section, SearchListUsersSection, id: "user-list")
    section(:search_list_machines_section, SearchListMachinesSection, id: "machine-list")
    section(:add_new_user_group_section, AddNewUserGroupSection, id: "user_groups-new")
    section(:add_new_user_section, AddNewUserSection, id: "user-new")
    section(:machine_mapping_section, MachineMappingSection, id: "machine-machine_migration")
    section(:user_group_details_section, UserGroupDetailsSection, xpath: "//div[starts-with(@id, 'user_groups-show-')]")
    section(:list_user_groups_section, ListUserGroupsSection, id: "user_groups-list")
    section(:user_details_section, UserDetailsSection, xpath: "//div[starts-with(@id, 'user-show-')]")

    # Admin section

    # Resources section
    section(:change_plan_section, ChangePlanSection, id: "resource-change_billing_plan")
    section(:change_payment_info_section, ChangePaymentInfoSection, id: "resource-change_credit_card")
    section(:billing_history_section, BillingHistorySection, id: "resource-all_charges")
    section(:billing_info_section, BillingInfoSection, id: "resource-billing")
    section(:change_period_section, ChangePeriodSection, id: "resource-change_billing_period")
    section(:manage_resources_section, ManageResourcesSection, id: "resource-available_key_list")
    section(:manage_user_group_resources_section, ManageUserGroupResourcesSection , xpath: "//div[starts-with(@id, 'resource-group_available_keys-')]")
    section(:transfer_resources_section, TransferResourcesSection, id: "resource-transfer_resources")


    # Data shuttle section
    section(:order_data_shuttle_section, OrderDataShuttleSection, id: "resource-choose_pro_partner_for_new_seed")
    section(:process_order_section, ProcessOrderSection, xpath: "//div[starts-with(@id, 'resource-create_new_seed-')]")
    section(:view_data_shuttle_orders_section, ViewDataShuttleOrdersSection, id: "resource-view_seed_device_orders")
    section(:order_details_section, OrderDetailsSection, xpath: "//div[starts-with(@id, 'resource-show_data_shuttle_order-')]")

    # reports section
    section(:report_builder_section, ReportBuilderSection, id: "jobs-report_builder")
    section(:add_report_section, AddReportSection, xpath: "*")
    section(:scheduled_reports_section, ScheduledReportsSection, id: "jobs-index")
    section(:quick_reports_section, QuickReportsSection, id: "jobs-quick_reports")

    # Private element
    element(:stop_masquerading_link, xpath: "//a[text()='stop masquerading']")

    # Popup window
    element(:popup_content_div, xpath: "//div[@class='popup-window-content']")
    element(:close_popup_btn, xpath: "//div[@class='popup-window-footer']/input[@value='Close']")
    element(:continue_btn, xpath: "//div[@class='popup-window-footer']/input[@value='Continue']")
    element(:cancel_btn, xpath: "//div[@class='popup-window-footer']/input[@value='Cancel']")
    element(:buy_more_btn, xpath: "//div[@class='popup-window-footer']/input[@value='Buy More']")
    element(:allocate_resources_btn, xpath: "//div[@class='popup-window-footer']/input[@value='Allocate']")

    # Public: Navigate to menu item on admin console page
    # Note: if bus module is opened, menu will not be clicked
    #
    # Returns nothing
    def navigate_to_menu(link)
      el = find_link(link)
      el_class = el.element_parent[:class]
      if el_class.match(/active/).nil?
        el.click
      end
    end

    def stop_masquerading
      stop_masquerading_link.click
    end

    def close_stash_invitation_popup
      find_link("Don't Show This Again").click
    end

    def popup_window_content
      popup_content_div.text
    end

    def buy_more_resources
      buy_more_btn.click
    end

    def allocate_resources
      allocate_resources_btn.click
    end

    def close_popup_window
      close_popup_btn.click
    end

    def click_continue
      continue_btn.click
    end

    def click_cancel
      cancel_btn.click
    end
  end
end
