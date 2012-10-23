Before do
  # Do things before each scenario.
  FileHelper.clean_up_csv
  @start_time = Time.now
end

After do |scenario|

end

AfterStep do
  # Todo
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