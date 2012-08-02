module AutomationWebDriver
  module PageObjectComponents

    # Public: Define a new method with the name of the symbol after locator returns element
    #
    # Example
    #   element(:username_tb, {:id => "username"})
    #   # => <WebDriver::Element>
    #
    # Returns element
    def element(element_sym,element_hash)
      send(:define_method, element_sym) do
        driver.find_element(element_hash)
      end
      add_element_name(element_sym)
      private element_sym
    end

    # Public: Define a new method with the name of the symbol after locator returns elements
    #
    # Example
    #   elements(:aria_message_div, {:xpath => "//div[@id='ariaErrors']//li"})
    #   # => <WebDriver::Elements>
    #
    # Returns elements
    def elements(element_sym,element_hash)
      send(:define_method, element_sym) do
        driver.find_elements(element_hash)
      end
      add_element_name(element_sym)
      private element_sym
    end

    # Public: Define Partial section of the page
    #
    # Returns page object
    def section(page_sym,page_class)
      send(:define_method, page_sym) do
        raise "#{page_class} does not inherit from PageObject" unless page_class.superclass == PageObject
        page_class.new(driver)
      end
    end

    # Public: Add element name into list
    #
    # Returns nothing
    def add_element_name(element_name)
      @element_names ||= []
      @element_names << element_name
    end

    # Public: Element names in the page object
    #
    # return element names array
    def element_names
      @element_names
    end
  end
end
