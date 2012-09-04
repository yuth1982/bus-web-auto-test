module SiteHelper
  module Components
    # Public: Define a new method with the name of the symbol after locator returns element
    #
    # Example
    #   element(:username_tb, id: "username")
    #   # => <Capybara::Element>
    #
    # Returns element
    def element(element_name,element_hash)
      send(:define_method, element_name) do
        find_element(element_hash.keys[0], element_hash.values[0])
      end
      private element_name
    end

    # Public: Define a new method with the name of the symbol after locator returns elements
    #
    # Example
    #   elements(:aria_message_div, xpath: "//div[@id='ariaErrors']//li")
    #   # => <Capybara::Elements>
    #
    # Returns elements
    def elements(element_name,element_hash)
      send(:define_method, element_name) do
        find_elements(element_hash.keys[0], element_hash.values[0])
      end
      private element_name
    end

    # Public: Define Partial section of the page
    #
    # Returns page object
    def section(section_name, section_class, element_hash)
      send(:define_method, section_name) do
        section_class.new(find_element(element_hash.keys[0], element_hash.values[0]))
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
