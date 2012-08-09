module Bus
  # This class provides actions for scheduled reports page section
  class ScheduledReportsSection < PageObject

    # Private elements
    #
    element(:filter_select, {:id => "job_filter"})
    element(:reports_table, {:xpath => "//div[@id='jobs-table']/div/table"})

    # Public: Reports table entire text
    #
    # Example
    #   @bus_admin_console_page.scheduled_reports_section.reports_tb_text
    #   # => "No results found"
    #
    # Returns reports table text
    def reports_tb_text
      reports_table.text
    end

    # Public: First 6 columns of reports table body rows text
    #
    # Example
    #   @bus_admin_console_page.scheduled_reports_section.reports_tb_rows_text
    #   # => [["Billing Summary Test Report", "Billing Summary", "@email", "Daily", "Run"]]
    #
    # Returns first 6 columns of reports table rows text
    def reports_tb_rows_text
      reports_table.rows_text.map{|row| row[0..4]}
    end

    # Public: Find first matched reports row text by reports name
    #
    # Example
    #   @bus_admin_console_page.scheduled_reports_section.find_report("Billing Summary Test Report")
    #   # => ["Billing Summary Test Report", "Billing Summary", "qa1+ronald+parker+2237@mozy.com", "Daily", "Run", "Wed Aug 01, 2012", "Download", "-"]
    #
    # Returns first matched reports row text
    def find_report(report_name)
      reports_table.rows.select{ |row| row[0].text == report_name}.first
    end

    # Public: Download latest reports to download folder
    #
    # Example
    #   @bus_admin_console_page.scheduled_reports_section.download_report("Billing Summary Test Report")
    #
    # Returns nothing
    def download_report(report_name)
      wait = 0
      report_row = ""
      while wait < BROWSER_IMPLICIT_WAIT
        report_row = find_report(report_name)
        message = report_row[6].text
        case
          when message.include?("(Error)")
            raise "Unable to create #{report_name}"
          when message.include?("Download")
            break
          else
        end
        wait = wait + 1
        sleep 1
      end
      report_row[6].find_element(:link, "Download").click
      puts "Wait 10 seconds to download csv reports file"
      sleep 10
    end

    # Public: Read downloaded scheduled reports
    #
    # Example
    #   @bus_admin_console_page.scheduled_reports_section.read_scheduled_report("Billing Summary Test Report")
    #
    # Returns reports csv file rows
    def read_scheduled_report(report_type)
      partial_file_name = "#{report_type.gsub(" ","-").downcase}.*"
      FileHelper.instance.read_csv_file(partial_file_name)
    end
  end
end
