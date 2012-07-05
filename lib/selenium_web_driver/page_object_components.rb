module AutomationWebDriver
  module PageObjectComponents
    # when this module is loaded, add on the ClassMethods module
    def self.included base
      base.extend ClassMethods
    end

    module ClassMethods

      # define a new method with the name of the symbol after locator that returns the value
      def element(element_sym,element_hash, opt = {})
        send(:define_method, element_sym) do
          begin
            driver.find_element(element_hash)
          rescue => ex
            wait = Selenium::WebDriver::Wait.new(:timeout => Bus::BROWSER_RESCUE_WAIT) # seconds
            wait.until { driver.find_element(element_hash) }
          end
        end
      end

      def elements(element_sym,element_hash)
        send(:define_method, element_sym) do
          begin
            driver.find_elements(element_hash)
          rescue => ex
            wait = Selenium::WebDriver::Wait.new(:timeout => Bus::BROWSER_RESCUE_WAIT) # seconds
            wait.until { driver.find_elements(element_hash) }
          end
        end
      end

      def component(page_sym,page_class)
        send(:define_method, page_sym) do
          raise "#{page_class} does not inherit from PageObject" unless page_class.superclass == PageObject
          page_class.new(driver)
        end
      end
    end
  end
end