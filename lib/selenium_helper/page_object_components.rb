module AutomationWebDriver
  module PageObjectComponents
  # define a new method with the name of the symbol after locator that returns the value
    def element(element_sym,element_hash, opt = {})
      send(:define_method, element_sym) do
        begin
          driver.find_element(element_hash)
        rescue Timeout::Error => ex
            # set element to nil is timeout
          nil
        end
      end
    end

    def elements(element_sym,element_hash)
      send(:define_method, element_sym) do
        begin
          driver.find_elements(element_hash)
        rescue Timeout::Error => ex
          # set element to nil is timeout
          nil
        end
      end
    end

    def section(page_sym,page_class)
      send(:define_method, page_sym) do
        raise "#{page_class} does not inherit from PageObject" unless page_class.superclass == PageObject
        page_class.new(driver)
      end
    end
  end
end
