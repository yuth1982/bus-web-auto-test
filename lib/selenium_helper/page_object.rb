class PageObject
  extend AutomationWebDriver::PageObjectComponents
  include AutomationWebDriver::CreateSeleniumWebDriver

  # Public: Initialize a Page Object
  #
  # driver - Selenium web driver
  def initialize(driver)
    @driver = driver
  end

  # Public: Refresh entire page
  #
  # Returns nothing
  def refresh_page
    @driver.navigate.refresh
  end

end