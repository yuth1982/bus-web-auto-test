module Bus
  class AdminConsolePage < PageObject

  component(:add_new_partner_view, AddNewPartnerView)
  component(:search_list_partner_view, SearchListPartnerView)
  component(:partner_details_view, PartnerDetailsView)
  component(:billing_info_view, BillingInfoView)
  component(:billing_history_view, BillingHistoryView)
  component(:purchase_resources_view, PurchaseResourcesView)
  component(:return_resources_view, ReturnResourcesView)
  component(:admin_details_view, AdminDetailsView)
  component(:account_details_view, AccountDetailsView)
  component(:order_data_shuttle_view, OrderDataShuttleView)
  component(:machines_view, MachinesView)
  component(:scheduled_reports_view, ScheduledReportsView)
  component(:report_builder_view, ReportBuilderView)
  component(:change_payment_view, ChangePaymentInfoView)

  # Top identify section
  element(:stop_masquerading, {:link => "stop masquerading"})

  # Internal tools links
  #
  element(:add_new_promo_link, {:link => "Add New Promotion"})

  # Partners links
  #
  element(:search_list_partner_link, {:link => "Search / List Partners"})
  element(:add_new_partner_link, {:link => "Add New Partner"})

  # Users links
  #
  element(:search_list_user_link, {:link => "Search / List Users"})
  element(:search_list_machines_link, {:link => "Search / List Machines"})
  element(:list_user_group_link, {:link => "List User Groups"})
  element(:add_new_user_group_link, {:link => "Add New User Group"})

  # Admins links
  #
  element(:search_admins_link, {:link => "Search Admins"})
  element(:list_admins_link, {:link => "List Admins"})
  element(:add_new_admin_link, {:link => "Add New Admin"})
  element(:list_roles_link, {:link => "List Roles"})
  element(:add_new_role_link, {:link => "Add New Role"})

  # Configurations links
  #
  element(:account_details_link, {:link => "Account Details"})
  element(:client_configuration_link, {:link => "Client Configuration"})
  element(:network_domains_link, {:link => "Network Domains"})
  element(:dea_domains_link, {:link => "DEA Domains"})
  element(:list_pro_plans_link, {:link => "List Pro Plans"})
  element(:add_new_pro_plan_link, {:link => "Add New Pro Plan"})
  element(:password_policy_link, {:link => "Password Policy"})

  # Branding / Customization links

  # BDS Remote Backup Client links

  # Resources links
  element(:order_data_shuttle_link, {:link => "Order Data Shuttle"})
  element(:view_data_shuttle_orders_link, {:link => "View Data Shuttle Orders"})
  element(:data_shuttle_status_link, {:link => "Data Shuttle Status"})
  element(:purchase_resources_link, {:link => "Purchase Resources"})
  element(:billing_information_link, {:link => "Billing Information"})
  element(:billing_history_link, {:link => "Billing History"})
  element(:change_payment_info_link, {:link => "Change Payment Information"})
  element(:assign_keys_link, {:link => "Assign Keys"})
  element(:transfer_resources_link, {:link => "Transfer Resources"})
  element(:return_unused_resources_link, {:link => "Return Unused Resources"})
  element(:download_client_link, {:link => "Download BDS Remote Backup Client"})

  # Graphs & Reports navigation links
  #
  element(:report_builder_link, {:link => "Report Builder"})
  element(:scheduled_reports_link, {:link => "Scheduled Reports"})
  element(:quick_reports_link, {:link => "Quick Reports"})
  element(:backup_history_link, {:link => "Backup History"})
  element(:new_users_link, {:link => "New Users"})
  element(:backup_health_link, {:link => "Backup Health"})
  element(:email_alerts_link, {:link => "Email Alerts (beta)"})
  end
end
