Before do
  # Do things before each scenario.
  FileHelper.clean_up_csv
end

After do |scenario|

end

AfterStep do
  puts Time.now if TIMESTAMP
end

Before('@selenium_chrome') do
  Capybara.current_driver = :selenium_chrome
end