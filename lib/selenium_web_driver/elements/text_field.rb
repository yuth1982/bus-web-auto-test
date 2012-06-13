module AutomationWebDriver
  module Elements
    module TextField
      # Public: type text into text field
      #
      # value - input text
      #
      # Returns nothing
      def type_text(value)
        self.clear
        self.send_keys(value.to_s)
      end

      # Public: append text into text field
      #
      # value - input text
      #
      # Returns nothing
      def append_text(value)
        self.send_keys(value.to_s)
      end
    end
  end
end