module SiteHelper
  class Iframe
    include Capybara::DSL
    extend Components

    def initialize(iframe_element)
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.driver.browser.switch_to.frame(iframe_element.base.native)
      else
        raise('Error: Selenium WebDriver Required.')
      end
    end
  end
end