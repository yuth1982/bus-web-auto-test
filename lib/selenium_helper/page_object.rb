class PageObject
  extend AutomationWebDriver::PageObjectComponents
  include AutomationWebDriver::PageValidator
  include AutomationWebDriver::CreateSeleniumWebDriver

  def initialize(driver)
    @driver = driver
  end

  def refresh_page
    @driver.navigate.refresh
  end
end