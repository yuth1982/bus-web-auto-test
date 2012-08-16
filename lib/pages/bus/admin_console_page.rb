module Bus
  # This class manage all sections for bus admin console page
  class AdminConsolePage < PageObject

    # Partner section
    section(:add_new_partner_section, AddNewPartnerSection)
    section(:search_list_partner_section, SearchListPartnerSection)
    section(:partner_details_section, PartnerDetailsSection)
    section(:admin_details_section, AdminDetailsSection)

    # Configuration section
    section(:account_details_section, AccountDetailsSection)

    # Users section
    section(:add_new_user_group_section, AddNewUserGroupSection)
    section(:add_new_user_section, AddNewUserSection)
    section(:search_list_machines_section, SearchListMachinesSection)
    section(:search_list_users_section, SearchListUsersSection)

    # Admin section

    # Resources section
    section(:change_plan_section, ChangePlanSection)
    section(:change_payment_info_section, ChangePaymentInfoSection)
    section(:billing_history_section, BillingHistorySection)
    section(:billing_info_section, BillingInfoSection)
    section(:change_period_section, ChangePeriodSection)
    section(:manage_resources_section, ManageResourcesSection)

    # Data shuttle section
    section(:order_data_shuttle_section, OrderDataShuttleSection)
    section(:process_order_section, ProcessOrderSection)
    section(:view_data_shuttle_orders_section, ViewDataShuttleOrdersSection)
    section(:order_details_section, OrderDetailsSection)

    # Reports section
    section(:report_builder_section, ReportBuilderSection)
    section(:scheduled_reports_section, ScheduledReportsSection)
    section(:quick_reports_section, QuickReportsSection)

    # Public: Click link on bus admin console navigation menu
    #
    # Example
    #   @bus_admin_console_page.navigate_to_link("Add New Partner")
    #
    # Returns nothing
    def navigate_to_link(link_name)
      driver.find_element(:link, link_name).click
    end

  end
end
