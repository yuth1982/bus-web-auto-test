module CapybaraHelper
  module Elements
    module Link
      # Public: Link's href attribute value
      #
      # Returns a string of link's href attribute value
      def href
        self[:href]
      end
    end
  end
end