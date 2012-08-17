Before do
  # Do things before each scenario.
  FileHelper.instance.clean_up_csv
end

After do |scenario|
  if DELETE_TEST_PARTNER
    begin
      step "I log in bus admin console as administrator"
      step "I delete the new partner account"
    rescue
      puts "Failed to delete partner"
    end
  end
    # Do things after each scenario.
  if scenario.failed?
    if SCREEN_SHOT
      dir = File.expand_path("../../logs", File.dirname(__FILE__))
      driver.save_screenshot("#{dir}/#{scenario.name.gsub(/\s+/,"_")}_#{Time.now.strftime("%Y%m%dT%H%M")}.png")
    end
  end
  driver.quit unless driver.nil?
end

AfterStep do
  puts Time.now if TIMESTAMP
end