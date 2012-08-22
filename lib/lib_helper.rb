$:.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'bundler'
Bundler.setup
require "selenium-webdriver"
require 'rspec'
require 'nokogiri'
require 'forgery'
require 'csv'

require 'configs/global_configs'
require 'configs/bus_configs'
require 'configs/aria_configs'
require 'configs/zimbra_configs'
require 'file_helper'

require "selenium_helper/create_selenium_web_driver"
require "selenium_helper/page_object_components"
require "selenium_helper/page_object"

require "selenium_helper/elements/text_field"
require "selenium_helper/elements/link"
require "selenium_helper/elements/checkbox"
require "selenium_helper/elements/table"
require "selenium_helper/elements/select"
require "selenium_helper/elements/element"

require "data_obj/bus/partner/partner_account"
require "data_obj/bus/partner/mozypro"
require "data_obj/bus/partner/mozyenterprise"
require "data_obj/bus/partner/reseller"
require "data_obj/bus/partner/credit_card"
require "data_obj/bus/partner/company_info"
require "data_obj/bus/partner/partner_info"
require "data_obj/bus/partner/admin_info"
require "data_obj/bus/report/report"
require "data_obj/bus/report/billing_detail_report"
require "data_obj/bus/report/billing_summary_report"
require "data_obj/bus/data_shuttle_order"
require "data_obj/bus/user"
require "data_obj/bus/admin"

require "sections/bus/add_new_partner_section"
require "sections/bus/search_list_partner_section"
require "sections/bus/partner_details_section"
require "sections/bus/admin_details_section"
require "sections/bus/account_details_section"

# Users section
require "sections/bus/users/add_new_user_section"
require "sections/bus/users/add_new_user_group_section"
require "sections/bus/users/search_list_machines_section"
require "sections/bus/users/search_list_users_section"
# Admins section
require "sections/bus/admins/add_new_admin_section"
require "sections/bus/admins/add_new_role_section"
require "sections/bus/admins/list_admins_section"
require "sections/bus/admins/list_roles_section"
require "sections/bus/admins/search_admins_section"
# Resources section
require "sections/bus/resources/change_plan_section"
require "sections/bus/resources/billing_info_section"
require "sections/bus/resources/change_period_section"
require "sections/bus/resources/billing_history_section"
require "sections/bus/resources/change_payment_info_section"
require "sections/bus/resources/manage_resources_section"
# Data shuttle section under resources section
require "sections/bus/data_shuttle/order_data_shuttle_section"
require "sections/bus/data_shuttle/process_order_section"
require "sections/bus/data_shuttle/view_data_shuttle_orders_section"
require "sections/bus/data_shuttle/order_details_section"
# Report section
require "sections/bus/report_builder_section"
require "sections/bus/scheduled_reports_section"
require "sections/bus/quick_reports_section"

# Aria section
require "sections/aria/search_account_section"
require "sections/aria/account_status_section"
require "sections/aria/taxpayer_section"
require "sections/aria/account_groups_section"
require "sections/aria/account_overview_section"
require "sections/aria/notification_method_section"

# Page section
require "pages/bus/login_page"
require "pages/bus/admin_console_page"
require "pages/aria/login_page"
require "pages/aria/accounts_page"
require "pages/aria/admin_console_page"
require "pages/zimbra/login_page"
require "pages/zimbra/mail_main_page"

include AutomationWebDriver::CreateSeleniumWebDriver
include AutomationWebDriver::Elements
