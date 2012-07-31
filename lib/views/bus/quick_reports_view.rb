module Bus
  # This class provides actions for quick reports view
  class QuickReportsView < PageObject

    # Private elements
    #
    element(:link_desc_table, {:xpath => "//div[@id='jobs-quick_reports-content']/div/table"})

    def link_desc_tb_rows_text
      link_desc_table.body_rows_text
    end

    # Public: Click quick report name to download the report
    #
    # Example
    #   @bus_admin_console_page.quick_reports_view.download_report("Credit Card Transactions (CSV)")
    #
    # Return download file to destination folder
    def download_report(report_name)
      driver.find_element(:link, report_name).click
      puts "Wait 10 seconds to download csv report file"
      sleep 10
    end

    def read_csv_report(report_type)
      dir = File.expand_path("../../../downloads", File.dirname(__FILE__))
      partial_file_name = report_type.gsub(" ","_").downcase
      report_file = Dir.glob("#{dir}/#{partial_file_name}.csv").first
      rows = []
      CSV.foreach(report_file) do |row|
        if row.size > 1  #data header and data
          rows << row.map{ |x| x == nil ? "" : x}[1..-1]
        end
      end
      # delete file, todo: move csv file to log folder
      File.delete(report_file)
      rows
    end
  end
end