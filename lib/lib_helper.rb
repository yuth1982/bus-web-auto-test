$:.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'bundler'
Bundler.setup
require "selenium-webdriver"
require 'nokogiri'
require 'forgery'
require 'csv'

require "selenium_web_driver/create_selenium_web_driver"
require "selenium_web_driver/selenium_helper"
require "selenium_web_driver/driver_ext"
require "selenium_web_driver/page_object_components"
require "selenium_web_driver/page_object"

require "selenium_web_driver/elements/text_field"
require "selenium_web_driver/elements/link"
require "selenium_web_driver/elements/checkbox"
require "selenium_web_driver/elements/table"
require "selenium_web_driver/elements/element"

require "data_obj/bus/partner"
require "data_obj/bus/mozypro"
require "data_obj/bus/mozyenterprise"
require "data_obj/bus/reseller"
require "data_obj/bus/admin"
require "data_obj/bus/promotion"
require "data_obj/aria/admin"
require "data_obj/aria/account"
require "data_obj/aria/plan_mapping"

require "views/bus/add_new_partner_view"
require "views/bus/add_new_promo_view"
require "views/bus/search_list_partner_view"
require "views/bus/partner_details_view"
require "views/bus/billing_info_view"
require "views/bus/billing_history_view"
require "views/bus/purchase_resources_view"
require "views/bus/return_resources_view"
require "views/bus/admin_details_view"
require "views/bus/account_details_view"
require "views/bus/order_data_shuttle_view"
require "views/bus/machines_view"
require "views/bus/scheduled_reports_view"
require "views/bus/report_builder_view"

require "views/aria/search_account_view"
require "views/aria/account_status_view"
require "views/aria/account_overview_view"
require "views/aria/notification_method_view"

require "pages/bus/login_page"
require "pages/bus/admin_console_page"
require "pages/bus/invoice_page"
require "pages/aria/login_page"
require "pages/aria/accounts_page"
require "pages/aria/admin_console_page"
require "pages/zimbra/login_page"
require "pages/zimbra/mail_main_page"

include AutomationWebDriver::CreateSeleniumWebDriver
include AutomationWebDriver::Elements
