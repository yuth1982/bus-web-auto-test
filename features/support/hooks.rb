
After do |scenario|
  if scenario.failed?
    dir = File.expand_path("../../logs", File.dirname(__FILE__))
    driver.save_screenshot("#{dir}/#{scenario.name.gsub(/\s+/,"_")}_#{Time.now.strftime("%Y%m%dT%H%M")}.png")
  end
  driver.quit unless driver.nil?
end

#AfterStep do
#  @last_step_window_handles = driver.window_handles
#end