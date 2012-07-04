module AutomationWebDriver
  module Elements
    module Table

      #def rows
      #  find_elements(:tag_name, "tr")
      #end

      # Public: Elements of table header row
      #
      # Examples
      #
      #   header_row
      #   # => Array<Element>]
      #
      # Returns elements of table header row
      def header_row
        find_element(:tag_name, "thead").find_element(:tag_name, "tr").child.compact
      end

      # Public: Element array of table body rows
      #
      # Examples             invoice_settings_dt
      #
      #   table.body_rows
      #   # => Array[Array<Element>]]
      #
      # Returns an array element of table body rows
      def body_rows
        #rows.map { |row| row.child if row.child.first.tag_name == "td" }.compact
        find_element(:tag_name, "tbody").find_elements(:tag_name, "tr").map{ |row| row.child }.compact
      end

      # Public: Elements of table foot row
      #
      # Examples
      #
      #   foot_row
      #   # => Array<Element>]
      #
      # Returns elements of table foot row
      def foot_row
        find_element(:tag_name, "tfoot").find_element(:tag_name, "tr").child.compact
      end

      # Public: String array of table header row
      #
      # Examples
      #
      #   table.header_row_text
      #   # => [["Plan","Price"]]
      #
      # Returns an string array of first header row
      def header_row_text
        header_row.map { |cell| cell.text }
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

      # Public: String array of table foot row
      #
      # Examples
      #
      #   table.foot_row_text
      #   # => [["Plan","Price"]]
      #
      # Returns an string array of first foot row
      def foot_row_text
        header_row.map { |cell| cell.text }
      end
    end
  end
end