module SiteHelper
  module Components
    # Public: Define a new method with the name of the symbol after locator returns element
    # and highlight element
    #
    # Example
    #   element(:username_tb, id: "username")
    #   # => <Capybara::Element>
    #
    # Returns element
    def element(element_name, element_hash)
      define_method(element_name.to_sym) do
        el = find(element_hash.keys.first, element_hash.values.first)
        el.highlight
        el
      end
      add_existence_checker(element_name,element_hash)
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
      define_method(element_name) do
        all(element_hash.keys.first, element_hash.values.first)
      end
      private element_name
    end

    # Public: Define Partial section of the page
    #
    # Returns page object
    def section(section_name, section_class, element_hash)
      define_method(section_name) do
        section_class.new(find(element_hash.keys[0], element_hash.values[0]))
      end
    end

    private
    # Define an existence check method
    # This method tries to find all elements by given locator with no wait time
    # please make sure your page/section is fully loaded before use this method
    #
    # Example
    #   login_page.has_username_tb?
    #   # => true
    #
    # Returns
    def add_existence_checker(element_name, element_hash)
      method_name = "has_#{element_name}?"
      define_method(method_name.to_sym) do
        all(element_hash.keys.first, element_hash.values.first).size > 0
      end
    end

  end
end
