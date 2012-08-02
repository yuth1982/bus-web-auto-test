module AutomationWebDriver
  module Elements
    module Table
      # Public: Elements of table header
      #
      # Examples
      #   headers
      #   # => Array<Selenium::WebDriver::Element>
      #
      # Returns WebDriver elements of table header
      def headers
        begin
          find_elements(:xpath, ".//tr/th")
        rescue
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
        begin
          find_elements(:xpath, ".//tbody/tr").map{ |row| row.child }
        rescue
          nil
        end
      end

      # Public: Elements of table foot row
      #
      # Examples
      #   footers
      #   # => Array<Selenium::WebDriver::Element>]
      #
      # Returns elements of table foot row
      def footers
        begin
          find_elements(:xpath, ".//tfoot/tr/td")
        rescue
          nil
        end
      end

      # Public: Table headers text
      #
      # Examples
      #   table.headers_text
      #   # => [["Plan","Price"]]
      #
      # Returns headers text
      def headers_text
        headers.map { |cell| cell.text } unless headers.nil?
      end

      # Public: Table body rows text
      #
      # Examples
      #   table.rows_text
      #   # => [["total","$200.00"],["tax","$15.00"]]
      #
      # Returns table rows text
      def rows_text
        rows.map { |row| row.map { |cell| cell.text } } unless rows.nil?
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
        footers.map { |cell| cell.text } unless footers.nil?
      end
    end
  end
end