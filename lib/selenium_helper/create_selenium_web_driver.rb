module AutomationWebDriver
  module CreateSeleniumWebDriver
    # Public: Returns main driver instance of Selenium::WebDriver::Driver
    attr_reader :driver

    # Public: launch web browser
    #
    # url - Opens the specified URL in the browser
    #
    # Examples
    #
    #   launch_selenium_web_driver("www.google.com")
    #
    # Returns nothing
    def launch_selenium_web_driver(url)
      # do not create a new browser instance
      if @driver.nil?
        @driver = Selenium::WebDriver.for(:firefox, :profile => custom_profile)
        @driver.manage.timeouts.implicit_wait = BROWSER_IMPLICIT_WAIT
      end
      @driver.navigate.to(url)
    end

    # Public:
    #
    #
    #
    # Returns firefox profile
    def custom_profile
      dir = File.expand_path("../../downloads", File.dirname(__FILE__))
      profile = Selenium::WebDriver::Firefox::Profile.new
      profile['browser.download.folderList'] = 2
      profile['browser.download.dir'] = "#{dir}"
      profile['browser.download.manager.showWhenStarting'] = false
      profile['browser.download.manager.closeWhenDone'] = true
      profile['browser.helperApps.neverAsk.saveToDisk'] = "application/csv;text/csv"
      profile
    end
  end
end