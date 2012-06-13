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
        @driver = Selenium::WebDriver.for(:firefox)
        @driver.manage.timeouts.implicit_wait = Bus::BROWSER_IMPLICIT_WAIT
      end
      @driver.navigate.to(url)
    end
  end
end