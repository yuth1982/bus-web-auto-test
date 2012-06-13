module AutomationWebDriver
  module Elements
    module Table
      # Public: Element array of table header rows
      #
      # Examples
      #
      #   body_rows
      #   # => Array[Array<Element>]]
      #
      # Returns an array array element of table header rows
      def header_rows
        @rows.map { |row| row.child if row.child.first.tag_name == "th" }.compact
      end

      # Public: Element array of table body rows
      #
      # Examples
      #
      #   table.body_rows
      #   # => Array[Array<Element>]]
      #
      # Returns an array array element of table body rows
      def body_rows
        @rows.map { |row| row.child if row.child.first.tag_name == "td" }.compact
      end

      # Public: String array of table header rows
      #
      # Examples
      #
      #   table.header_row_text
      #   # => [["Plan","Price"]
      #
      # Returns an string array of first header row
      def header_row_text
        header_rows.map { |row| row.map { |cell| cell.text } }
      end

      # Public: String array of table body rows
      #
      # Examples
      #
      #   table.body_row_text
      #   # => [["total","$200.00"],["tax","$15.00"]]
      #
      # Returns an string array of body rows
      def body_rows_text
        body_rows.map { |row| row.map { |cell| cell.text } }
      end
    end
  end
end