# Partners section
require 'bus_site/sections/partners/add_new_partner_section'
require 'bus_site/sections/partners/search_list_partner_section'
require 'bus_site/sections/partners/partner_details_section'
require 'bus_site/sections/partners/admin_details_section'
require 'bus_site/sections/partners/account_details_section'

# Users section
require 'bus_site/sections/users/add_new_user_section'
require 'bus_site/sections/users/add_new_user_group_section'
require 'bus_site/sections/users/search_list_machines_section'
require 'bus_site/sections/users/search_list_users_section'
require 'bus_site/sections/users/machine_mapping_section'
require 'bus_site/sections/users/list_user_groups_section'
require 'bus_site/sections/users/user_group_details_section'
require 'bus_site/sections/users/user_details_section'

# Admins section
require 'bus_site/sections/admins/add_new_admin_section'
require 'bus_site/sections/admins/add_new_role_section'
require 'bus_site/sections/admins/list_admins_section'
require 'bus_site/sections/admins/list_roles_section'
require 'bus_site/sections/admins/search_admins_section'

#Configuration section
require 'bus_site/sections/configuration/authentication_policy_section'

# Resources section
require 'bus_site/sections/resources/change_plan_section'
require 'bus_site/sections/resources/billing_info_section'
require 'bus_site/sections/resources/change_period_section'
require 'bus_site/sections/resources/billing_history_section'
require 'bus_site/sections/resources/change_payment_info_section'
require 'bus_site/sections/resources/manage_resources_section'
require 'bus_site/sections/resources/manage_group_resources_section'
require 'bus_site/sections/resources/order_data_shuttle_section'
require 'bus_site/sections/resources/process_order_section'
require 'bus_site/sections/resources/view_data_shuttle_orders_section'
require 'bus_site/sections/resources/order_details_section'
require 'bus_site/sections/resources/transfer_resources_section'

# Report section
require 'bus_site/sections/reports/report_builder_section'
require 'bus_site/sections/reports/add_report_section'
require 'bus_site/sections/reports/scheduled_reports_section'
require 'bus_site/sections/reports/quick_reports_section'

# Pages
require 'bus_site/pages/login_page'
require 'bus_site/pages/admin_console_page'
require 'bus_site/pages/user_login_page'
require 'bus_site/pages/user_account_page'
require 'bus_site/pages/authentication_failed_page'
require 'bus_site/bus_site'