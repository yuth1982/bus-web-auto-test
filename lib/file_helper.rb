require 'singleton'

class FileHelper
  include Singleton

  def default_download_path
    File.expand_path("../downloads", File.dirname(__FILE__))
  end

  # Public: read csv file
  #
  # Example
  #   FileHelper.read_csv_file("Billing_summary.csv","download_folder")
  #
  # Returns cvs rows array
  def read_csv_file(file_name, file_path = default_download_path)
    report_file = Dir.glob("#{file_path}/#{file_name}.csv").first
    rows = []
    CSV.foreach(report_file) do |row|
      if row.size > 1  #data header and data
        rows << row.map{ |x| x == nil ? "" : x}
      end
    end
    # delete file, todo: move csv file to log folder
     File.delete(report_file)
    rows
  end
end