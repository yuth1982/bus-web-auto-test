@no_cucumber = true
require_relative "../features/support/env.rb"

#class Bus_Automation

  @browser = :firefox

  def set_browser(sym)
    #@browser- :chrome,:firefox,:ie,:webkit, :firefox_profile
    @browser = sym
  end

  def open_browser
    FileHelper.clean_up_csv
    @start_time = Time.now
    Capybara.current_driver = @browser
  end

  def close_browser
  end

#end