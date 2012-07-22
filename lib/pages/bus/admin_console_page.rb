module Bus
  class AdminConsolePage < PageObject

    section(:add_new_partner_view, AddNewPartnerView)
    section(:search_list_partner_view, SearchListPartnerView)
    section(:partner_details_view, PartnerDetailsView)
    section(:billing_info_view, BillingInfoView)
    section(:change_period_view, ChangePeriodView)
    section(:billing_history_view, BillingHistoryView)
    section(:purchase_resources_view, PurchaseResourcesView)
    section(:return_resources_view, ReturnResourcesView)
    section(:admin_details_view, AdminDetailsView)
    section(:account_details_view, AccountDetailsView)

    section(:order_data_shuttle_view, OrderDataShuttleView)
    section(:process_order_view, ProcessOrderView)
    section(:view_data_shuttle_orders_view, ViewDataShuttleOrdersView)
    section(:order_details_view, OrderDetailsView)

    section(:machines_view, MachinesView)
    section(:report_builder_view, ReportBuilderView)
    section(:scheduled_reports_view, ScheduledReportsView)
    section(:quick_reports_view, QuickReportsView)

    section(:change_payment_view, ChangePaymentInfoView)

    element(:corporate_invoices_link, {:link => "Corporate Invoices"}) # This link should not exist

    def navigate_to_link(link_name)
      driver.find_element(:link, link_name).click
    end
  end
end
