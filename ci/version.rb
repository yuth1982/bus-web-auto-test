require "httparty"
module Version
  include HTTParty
  file = nil
  begin
    res = post('https://www.mozypro.com/version.txt')
    version = res.to_s
    if version.end_with?("\n")
      version = version[0, version.length-1]
    end
    file = File.new("version.#{version}", 'w')
    file.puts version
  rescue Exception => ex
      Log.debug(ex.to_s)
  ensure
      file.close if !file.nil?
  end

end