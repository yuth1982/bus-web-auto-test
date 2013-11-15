
module FileHelper

  # Public: Default download folder for files
  #
  # Returns default download path
  def default_download_path
    path = File.expand_path("../#{CONFIGS['global']['download_folder']}", File.dirname(__FILE__))
    Dir.mkdir(path) unless File.exists?(path)
    path
  end

  # Public: Default test data folder for files
  #
  def default_test_data_path
    path = File.expand_path("../#{CONFIGS['global']['test_data_folder']}", File.dirname(__FILE__))
    Dir.mkdir(path) unless File.exists?(path)
    path
  end

  # Public: Download folder for Firefox
  #
  # Returns firefox download folder
  def ff_download_path
    default_download_path.gsub(File::SEPARATOR, File::ALT_SEPARATOR || File::SEPARATOR)
  end

  def ff_profile_path
    File.join(default_test_data_path, "#{PROFILE_NAME}")
  end

  # Public: read csv file
  #
  # Example
  #   FileHelper.read_csv_file("Billing_summary.csv","download_folder")
  #
  # Returns cvs rows array
  def read_csv_file(file_name, file_path = default_download_path)
    report_file = Dir.glob(File.join(file_path, "#{file_name}.csv")).first
    rows = []
    CSV.foreach(report_file) do |row|
      if row.size > 1  #data header and data
        rows << row.map{ |x| x == nil ? "" : x}
      end
    end
    rows
  end

  # Public: write csv file
  #
  # Example
  #   FileHelper.write_csv_file("Billing_summary.csv", [['a', 'b', 'c'],['1', '2', 3]], "download_folder")
  #
  # Returns null
  def write_csv_file(file_name, data, file_path = default_download_path)
    file = File.join(file_path, "#{file_name}.csv")
    CSV.open(file, 'w') do |writer|
      data.each do |row|
        writer << row
      end
    end
  end

  # Public: rename file
  #
  # Example
  #   FileHelper.rename('a.csv', 'b.csv', "download_folder")
  #
  # Returns null
  def rename(old_name, new_name, file_path = default_download_path)
    old_file = File.join(file_path, old_name)
    new_file = File.join(file_path, old_name)
    File.rename(old_file, new_file)
  end

  # Public: delete *.csv files in download folder
  #
  # Returns nothing
  def clean_up_csv
    Dir.glob("#{default_download_path}/*.csv").each{ |path| File.delete(path) }
  end

  def delete_csv(name)
    file = File.join(default_download_path, "#{name}.csv")
    File.delete(file) if File.file?(file)
  end

  # Public: rename file
  #
  # Example
  #   FileHelper.file_exists?('a.csv', "download_folder")
  #
  # Return Boolean
  def file_exists?(file_name, file_path = default_download_path)
    file = File.join(file_path, file_name)
    File.file?(file)
  end

end
