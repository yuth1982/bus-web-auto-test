$:.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'bundler'
Bundler.setup
require "selenium-webdriver"
require 'nokogiri'
require 'forgery'
require 'csv'

require "selenium_helper/create_selenium_web_driver"
require "selenium_helper/page_object_components"
require "selenium_helper/page_object"

require "selenium_helper/elements/text_field"
require "selenium_helper/elements/link"
require "selenium_helper/elements/checkbox"
require "selenium_helper/elements/table"
require "selenium_helper/elements/element"

require "data_obj/bus/partner_account"
require "data_obj/bus/mozypro"
require "data_obj/bus/mozyenterprise"
require "data_obj/bus/reseller"
require "data_obj/bus/credit_card"
require "data_obj/bus/company_info"
require "data_obj/bus/partner_info"
require "data_obj/bus/admin_info"
require "data_obj/bus/data_shuttle_order"
require "data_obj/bus/report"
require "data_obj/bus/billing_detail_report"
require "data_obj/bus/billing_summary_report"

require "sections/bus/add_new_partner_section"
require "sections/bus/search_list_partner_section"
require "sections/bus/partner_details_section"
require "sections/bus/billing_info_section"
require "sections/bus/change_period_section"
require "sections/bus/billing_history_section"
require "sections/bus/admin_details_section"
require "sections/bus/account_details_section"
require "sections/bus/data_shuttle/order_data_shuttle_section"
require "sections/bus/data_shuttle/process_order_section"
require "sections/bus/data_shuttle/view_data_shuttle_orders_section"
require "sections/bus/data_shuttle/order_details_section"
require "sections/bus/report_builder_section"
require "sections/bus/scheduled_reports_section"
require "sections/bus/quick_reports_section"
require "sections/bus/change_payment_info_section"

require "sections/aria/search_account_section"
require "sections/aria/account_status_section"
require "sections/aria/taxpayer_section"
require "sections/aria/account_groups_section"
require "sections/aria/account_overview_section"
require "sections/aria/notification_method_section"

require "pages/bus/login_page"
require "pages/bus/admin_console_page"
require "pages/aria/login_page"
require "pages/aria/accounts_page"
require "pages/aria/admin_console_page"
require "pages/zimbra/login_page"
require "pages/zimbra/mail_main_page"

include AutomationWebDriver::CreateSeleniumWebDriver
include AutomationWebDriver::Elements
