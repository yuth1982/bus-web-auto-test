Before do
  # Do things before each scenario.
  FileHelper.clean_up_csv
  @start_time = Time.now
end

After do |scenario|

end

AfterStep do |scenario|
  loading = all(:css, 'h2 a[onclick^=toggle_module].title')
  loading.each do |one|
    unless one[:class].nil?
      wait_until{ one[:class].match(/loading/).nil? }
    end
  end
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

Before('@firefox_profile') do
  Capybara.current_driver = :firefox_profile
end