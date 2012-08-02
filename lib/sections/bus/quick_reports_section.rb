module Bus
  # This class provides actions for quick reports page section
  class QuickReportsSection < PageObject

    # Private elements
    #
    element(:link_desc_table, {:xpath => "//div[@id='jobs-quick_reports-content']/div/table"})

    # Public: Quick report links and description text
    #
    # Example
    #   @bus_admin_console_page.quick_reports_section.link_desc_tb_rows_text
    #
    # Returns links and description text
    def link_desc_tb_rows_text
      link_desc_table.rows_text
    end

    # Public: Click quick report name to download the report
    #
    # Example
    #   @bus_admin_console_page.quick_reports_section.download_report("Credit Card Transactions (CSV)")
    #
    # Returns download file to destination folder
    def download_report(report_name)
      driver.find_element(:link, report_name).click
      puts "Wait 10 seconds to download csv report file"
      sleep 10
    end

    # Public: Read downloaded quick report
    #
    # Example
    #   @bus_admin_console_page.scheduled_reports_section.read_quick_report("Users (CSV)")
    #
    # Returns report csv file rows
    def read_quick_report(report_type)
      partial_file_name = report_type.gsub(" ","_").downcase
      FileHelper.instance.read_csv_file(partial_file_name)
    end
  end
end