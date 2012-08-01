require 'singleton'

class FileHelper
  include Singleton

  # Public: Default download folder for files
  #
  # Returns default download path
  def default_download_path
    File.expand_path("../downloads", File.dirname(__FILE__))
  end

  # Public: Download folder for Firefox
  #
  # Returns firefox download folder
  def ff_download_path
    default_download_path.gsub(File::SEPARATOR, File::ALT_SEPARATOR || File::SEPARATOR)
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
