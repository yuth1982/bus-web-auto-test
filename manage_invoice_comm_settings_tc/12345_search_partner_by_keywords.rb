#$:.unshift(File.dirname(__FILE__) + '/../../lib')
#$:.unshift(File.dirname(__FILE__) + '/../../test_data')
#$:.unshift(File.dirname(__FILE__))

$LOAD_PATH << File.expand_path('../../lib',__FILE__)
$LOAD_PATH << File.expand_path('../../test_data',__FILE__)

require 'test/unit'
require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'lib_helper'
require 'bus_data'
require 'aria_data'

class TestCase12345 < Test::Unit::TestCase
  def setup
    launch_selenium_web_driver(Bus::BUS_LOGIN_URL)
  end

  def teardown
    driver.quit unless driver.nil?
  end

  def test_case_12345
    # Bus Login
    bus_login_page = Bus::LoginPage.new(driver)
    admin = Bus::Admin.new("328342","shipuy@mozy.com","Shipu Yao","test1234")
    bus_login_page.login(admin)

    # get admin console page
    bus_admin_console_page = Bus::AdminConsolePage.new(driver)

    bus_admin_console_page.search_list_partner_link.click

    bus_admin_console_page.search_list_partner_view.search_partner("Roob, Sanford and Braun")

    assert_equal(bus_admin_console_page.search_list_partner_view.search_results_table.first_body_row_text.join(","),
                 ",Roob, Sanford and Braun,02/13/12,qa6+violette+emmerich@mozy.com,Business,0,20,540 GB")
  end
end
