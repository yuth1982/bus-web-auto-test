module AutomationWebDriver
  module PageValidator

    # Public: Validate all element in page object
    #
    # Returns nothing
    def validate_elements
      page_class = self.class
      raise("Cannot find driver") if driver.nil?
      missing_elements = []
      puts "class #{page_class}"
      page_object = page_class.new(driver)
      raise "Could not find web driver elements in #{page_class}" if page_class.element_names.nil?
      page_class.element_names.each do |element_name|
        puts "Validating #{element_name}"
        begin
          page_object.method(element_name).call
        rescue
          puts "Could not find #{element_name}"
          missing_elements.push(element_name)
        end
      end
      if missing_elements.length > 0
        puts "Missing Elements:"
        missing_elements.each do |element|
        puts element
        end
      end
      raise "Found Missing Elements: #{missing_elements.inspect}" if missing_elements.length > 0
    end
  end
end