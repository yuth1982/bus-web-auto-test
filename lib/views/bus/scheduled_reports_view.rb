module Bus
  # This class provides actions for scheduled reports view
  class ScheduledReportsView < PageObject

    # Private elements
    #
    element(:filter_select, {:id => "job_filter"})
    element(:reports_table, {:xpath => "//div[@id='jobs-table']/div/table"})

    def reports_tb_text
      reports_table.text
    end

    def reports_tb_rows_text
      reports_table.body_rows_text.map{|row| row[0..5]}
    end

    def find_report(report_name)
      reports_table.body_rows.select{ |row| row[0].text == report_name}.first
    end

    # Public: Download latest report by name
    #
    # Example
    #
    #
    #
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
      puts "Wait 10 seconds to download csv report file"
      sleep 10
    end

    def read_scheduled_report(report_type)
      partial_file_name = "#{report_type.gsub(" ","-").downcase}.*"
      FileHelper.read_csv_file(partial_file_name)
    end
  end
end
