module AutomationWebDriver
  module PageObjectComponents
    def add_element_name element_name
      @element_names ||= []
      @element_names << element_name
    end

    def element_names
      @element_names
    end

  # define a new method with the name of the symbol after locator that returns the value
    def element(element_sym,element_hash)
      send(:define_method, element_sym) do
        begin
          driver.find_element(element_hash)
        rescue Timeout::Error => ex
            # set element to nil is timeout
          nil
        end
      end
      add_element_name(element_sym)
      private element_sym
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
      add_element_name(element_sym)
      private element_sym
    end

    def section(page_sym,page_class)
      send(:define_method, page_sym) do
        raise "#{page_class} does not inherit from PageObject" unless page_class.superclass == PageObject
        page_class.new(driver)
      end
    end
  end
end
