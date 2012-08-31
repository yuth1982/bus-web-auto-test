module CapybaraHelper
  module Elements
    # This module parse html table header, body and footer elements
    # Tests: TC.17955, TC.15385, TC.17881, TC.16184
    #
    module Table
      # Public: Elements of table header
      #
      # Examples
      #   headers
      #   # => Array<Selenium::WebDriver::Element>
      #
      # Returns WebDriver elements of table header
      def headers
        cell_matrix = self.all("tr").map{ |row| row.child}
        size = cell_matrix.first.select{ |cell| cell.tag_name == "th"}.length
        if size > 1
          cell_matrix.first
        else
          nil
        end
      end

      # Public: WebDriver elements list of table body rows
      #
      # Examples
      #   table.rows
      #   # => Array[Array<Selenium::WebDriver::Element>]
      #
      # Returns list of WebDriver elements
      def rows
        cell_matrix = self.all("tbody/tr").map{ |row| row.child}
        size = cell_matrix.first.select{ |cell| cell.tag_name == "th"}.length
        if size > 1
          cell_matrix[1..-1]
        else
          cell_matrix
        end
        #find_elements(:xpath, ".//tbody/tr/td").each_slice(headers.length).to_a
      end

      # Public: Elements of table foot row
      #
      # Examples
      #   footers
      #   # => Array<Selenium::WebDriver::Element>]
      #
      # Returns elements of table foot row
      def footers
        all("tfoot/tr").child
      end

      # Public: Table headers text
      #
      # Examples
      #   table.headers_text
      #   # => [["Plan","Price"]]
      #
      # Returns headers text
      def headers_text
        headers.map { |cell| cell.text }
      end

      # Public: Table body rows text
      #
      # Examples
      #   table.rows_text
      #   # => [["total","$200.00"],["tax","$15.00"]]
      #
      # Returns table rows text
      def rows_text
        rows.map { |row| row.map { |cell| cell.text } }
      end

      # Public: Table footers text
      #
      # Examples
      #
      #   table.footers_text
      #   # => ["footer 1","footer 2"]
      #
      # Returns table footers text
      def footers_text
        footers.map { |cell| cell.text }
      end
    end
  end
end