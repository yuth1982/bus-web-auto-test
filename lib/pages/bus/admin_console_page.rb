module Bus
  # This class provides actions for bus admin console page
  class AdminConsolePage < PageObject

    section(:add_new_partner_section, AddNewPartnerSection)
    section(:search_list_partner_section, SearchListPartnerSection)
    section(:partner_details_section, PartnerDetailsSection)
    section(:billing_info_section, BillingInfoSection)
    section(:change_period_section, ChangePeriodSection)
    section(:billing_history_section, BillingHistorySection)
    section(:admin_details_section, AdminDetailsSection)
    section(:account_details_section, AccountDetailsSection)

    section(:order_data_shuttle_section, OrderDataShuttleSection)
    section(:process_order_section, ProcessOrderSection)
    section(:view_data_shuttle_orders_section, ViewDataShuttleOrdersSection)
    section(:order_details_section, OrderDetailsSection)

    section(:report_builder_section, ReportBuilderSection)
    section(:scheduled_reports_section, ScheduledReportsSection)
    section(:quick_reports_section, QuickReportsSection)

    section(:change_payment_info_section, ChangePaymentInfoSection)

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
