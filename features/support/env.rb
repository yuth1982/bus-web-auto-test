$:.unshift(File.dirname(__FILE__) + '/../../lib')
require 'lib_helper'

Capybara.register_driver :selenium do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile['browser.download.folderList'] = 2
  profile['browser.download.dir'] = FileHelper.ff_download_path
  profile['browser.download.downloadDir'] = FileHelper.ff_download_path
  profile['browser.download.lastDir'] = FileHelper.ff_download_path
  profile['browser.download.manager.showWhenStarting'] = false
  profile['browser.download.manager.closeWhenDone'] = true
  profile['browser.helperApps.neverAsk.saveToDisk'] = "application/csv;text/csv;application/vnd.ms-excel;"
  #profile.native_events = true
  Capybara::Selenium::Driver.new(app, :browser => :firefox, :profile => profile)
end

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.register_driver :webkit do |app|
  options = {
    timeout: DEFAULT_WAIT_TIME,
    ignore_ssl_errors: true
  }
  Capybara::Driver::Webkit.new(app, options)
end

Capybara.javascript_driver = :webkit

Capybara.default_driver = :selenium

Capybara.default_wait_time = DEFAULT_WAIT_TIME