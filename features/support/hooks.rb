Before do
  # Do things before each scenario.
  FileHelper.clean_up_csv
end

After do |scenario|

end

AfterStep do
  puts Time.now if TIMESTAMP
end

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