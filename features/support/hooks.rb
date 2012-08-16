Before do
  # Do things before each scenario.
  FileHelper.instance.clean_up_csv
end

After do |scenario|
  begin
    step "I log in bus admin console as administrator"
    step "I delete the new partner account"
  rescue
    puts "Failed to delete partner"
  end
    # Do things after each scenario.
  if scenario.failed?
    dir = File.expand_path("../../logs", File.dirname(__FILE__))
    driver.save_screenshot("#{dir}/#{scenario.name.gsub(/\s+/,"_")}_#{Time.now.strftime("%Y%m%dT%H%M")}.png") if SCREEN_SHOT
  end
  driver.quit unless driver.nil?
end

#AfterStep do
#  @last_step_window_handles = driver.window_handles
#end