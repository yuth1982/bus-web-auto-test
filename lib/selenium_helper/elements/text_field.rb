module AutomationWebDriver
  module Elements
    module TextField
      # Public: type text into text field
      #
      # Example
      #   element.type_text("hello")
      #
      # Returns nothing
      def type_text(value)
        self.clear
        self.send_keys([:control, 'a'], :delete,value.to_s)
      end

      # Public: append text into text field
      #
      # Example
      #   element.append_text("hello")
      #
      # Returns nothing
      def append_text(value)
        self.send_keys(value.to_s)
      end
    end
  end
end