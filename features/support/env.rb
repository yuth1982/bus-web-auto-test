require "#{File.dirname(__FILE__)}/../../test_sites/test_sites"

Capybara.register_driver :firefox do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile['browser.download.folderList'] = 2
  profile['browser.download.dir'] = FileHelper.ff_download_path
  profile['browser.download.downloadDir'] = FileHelper.ff_download_path
  profile['browser.download.lastDir'] = FileHelper.ff_download_path
  profile['browser.download.manager.showWhenStarting'] = false
  profile['browser.download.manager.closeWhenDone'] = true
  profile['browser.helperApps.neverAsk.saveToDisk'] = "application/csv;text/csv;application/vnd.ms-excel;
application/x-msdos-program;application/x-apple-diskimage;application/x-debian-package;application/x-redhat-package-manager"
  profile.assume_untrusted_certificate_issuer = false
  #profile.native_events = true
  Capybara::Selenium::Driver.new(app, :browser => :firefox, :profile => profile)
end

Capybara.register_driver :firefox_profile do |app|
  profile_address = "#{FileHelper.default_test_data_path}/#{CONFIGS['global']['profile_name']}"
  profile = Selenium::WebDriver::Firefox::Profile.new profile_address
  profile.add_extension("#{FileHelper.default_test_data_path}/autoauth-2.1-fx+fn.xpi")
  Capybara::Selenium::Driver.new(app, :browser => :firefox, :profile => profile)
end

Capybara.register_driver :firefox_debug do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile.add_extension("#{FileHelper.default_test_data_path}/firebug-1.11.4-fx.xpi")
  Capybara::Selenium::Driver.new(app, :browser => :firefox, :profile => profile)
end

Capybara.register_driver :chrome do |app|
  prefs = {
      :download => {
          :prompt_for_download => false,
          :default_directory => FileHelper.ff_download_path
      }
  }
  Capybara::Selenium::Driver.new(app, :browser => :chrome, :prefs => prefs)
end

Capybara.register_driver :ie do |app|
  Capybara::Selenium::Driver.new(app, :browser => :internet_explorer)
end

Capybara.register_driver :webkit do |app|
  options = {
    timeout: CONFIGS['global']['default_wait_time'],
    ignore_ssl_errors: true
  }
  Capybara::Driver::Webkit.new(app, options)
end

case BROWSER
  when "firefox"
    Capybara.default_driver = :firefox
  when "firefox_profile"
    Capybara.default_driver = :firefox_profile
  when "chrome"
    Capybara.default_driver = :chrome
  when "ie"
    Capybara.default_driver = :ie
  when "webkit"
    Capybara.default_driver = :webkit
  else
    raise "Unknown browser, please check env variable br"
end

Capybara.default_wait_time = CONFIGS['global']['default_wait_time']

# Setup Aria API
AriaApi::Configuration.auth_key = ARIA_API_ENV['auth_key']
AriaApi::Configuration.client_no = ARIA_API_ENV['client_no']
AriaApi::Configuration.url = ARIA_API_ENV['url']
