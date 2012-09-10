module Bus
  # This class manage all sections for bus admin console page
  class AdminConsolePage < SiteHelper::Page

    set_url("#{Bus::BUS_HOST}/dashboard")

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
    section(:add_new_user_group_section, AddNewUserGroupSection, id: "user_groups-list")
    section(:add_new_user_section, AddNewUserSection, id: "user_groups-new")
    section(:machine_mapping_section, MachineMappingSection, id: "machine-machine_migration")

    # Admin section

    # Resources section
    section(:change_plan_section, ChangePlanSection, id: "resource-change_billing_plan")
    section(:change_payment_info_section, ChangePaymentInfoSection, id: "resource-change_credit_card")
    section(:billing_history_section, BillingHistorySection, id: "resource-all_charges")
    section(:billing_info_section, BillingInfoSection, id: "resource-billing")
    section(:change_period_section, ChangePeriodSection, id: "resource-change_billing_period")
    section(:manage_resources_section, ManageResourcesSection, id: "resource-available_key_list")

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

  end
end
