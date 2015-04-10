require 'os'
require 'base64'

Before do
  # Do things before each scenario.
  FileHelper.clean_up_csv
  @start_time = Time.now
end

def testcase_id(scenario)
  caseId = ''
  scenario.source_tag_names.each { |name|
    if name.length > 2 && name[1..2].downcase.eql?('tc')
      caseId = name[1..name.length]
      break
    end
  }
  caseId
end


#create log file based on scenario name, code location and case id
Before do |scenario|
  lIndex = scenario.location.file.rindex '\\'
  lIndex = scenario.location.file.rindex '/' if lIndex.nil?
  lIndex = -1 if lIndex.nil?
  rIndex = scenario.location.file.index '.'
  sName = scenario.location.file[lIndex+1 .. rIndex-1]

  caseId = testcase_id(scenario)

  file = File.new("logs/#{sName}.#{caseId}.line#{scenario.location.line.to_s}.log", 'w')
  file.puts "Scenario: #{scenario.name}"
  CapybaraHelper::Extension::Context.instance.log.dest = file
  @logFile = file
end

After do |scenario|
  @logFile.close
  CapybaraHelper::Extension::Context.instance.log.dest = nil
end

=begin
Before('@chrome') do
  Capybara.current_driver = :chrome
end

Before('@firefox') do
  Capybara.current_driver = :firefox
end

Before('@ie') do
  Capybara.current_driver = :ie
end

Before('@webkit') do
  Capybara.current_driver = :webkit
end

Before('@firefox_profile') do
  Capybara.current_driver = :firefox_profile
end
=end

After do |scenario|
  if scenario.failed?
    id = testcase_id scenario
    id = scenario.__id__ if id.nil? || id.length == 0
    name = "screenshot_#{id}_line#{scenario.location.line.to_s}.png"
    if OS.windows?
      require 'win32/screenshot'
      require 'win32/api'
      include Win32
      hWnd = Win32::API.new('GetForegroundWindow', 'V', 'L', 'user32').call(0,0)
      Win32::Screenshot::Take.of(:window, :hwnd => hWnd).write(name)
      file = File.open(name, 'rb')
      encoded_img = Base64.encode64(file.read)
      file.close
      File.delete(name)
    else
      #page.driver.browser.save_screenshot("html-report/#{name}")
      encoded_img =  page.driver.browser.screenshot_as(:base64)
    end
    embed("#{encoded_img}", "image/png", "#{name}")
  end
end
