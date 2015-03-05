Before do
  # Do things before each scenario.
  FileHelper.clean_up_csv
  @start_time = Time.now
end

Before do |scenario|
  log = scenario.location.file.gsub(/\\|\//,'.')
  file = File.new("logs/#{log}.#{scenario.location.line.to_s}", 'w')
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
    page.driver.browser.save_screenshot("html-report/#{scenario.__id__}.png")
    embed("#{scenario.__id__}.png", "image/png", "#{scenario.__id__}_screenshot")
  end
end
