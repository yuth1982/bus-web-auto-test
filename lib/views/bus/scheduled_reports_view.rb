module Bus
  class ScheduledReportsView < PageObject
    element(:filter_select, {:id => "job_filter"})
    element(:reports_table, {:xpath => "//div[@id='jobs-table']/div/table"})

    def find_report(report_name)
      reports_table.body_rows.select{ |row| row[0].text == report_name}.first
    end

    # Download latest report by name
    def download_report(report_name)
      wait = 0
      report_row = ""
      while wait < Bus::BROWSER_IMPLICIT_WAIT
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

    def read_csv_report(report_type)
      dir = File.expand_path("../../../downloads", File.dirname(__FILE__))
      partial_file_name = report_type.gsub(" ","-").downcase
      report_file = Dir.glob("#{dir}/#{partial_file_name}.*.csv").first
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
