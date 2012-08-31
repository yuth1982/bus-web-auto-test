module CapybaraHelper
  module Elements
    module CheckBox
      # Public: Is the CheckBox checked?
      #
      # Examples
      #   checkbox.checked?
      #   # => true
      #
      # Returns Boolean
      def checked?
        self.selected?
      end

      # Public: Make CheckBox checked
      #
      # Returns nothing
      def check
        self.click unless checked?
      end

      # Public: Make CheckBox unchecked
      #
      # Returns nothing
      def uncheck
        self.click if checked?
      end
    end
  end
end