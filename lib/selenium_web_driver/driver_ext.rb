# This class creates methods extend to Selenium::WebDriver::Driver class
#
class Selenium::WebDriver::Driver

  def switch_to_last_opened_window
    sleep 2
    self.switch_to.window self.window_handles.last
  end

  #def close_active_window
  #  driver.browser.close
  #  switch_to_last_opened_window
  #end

  def scroll_to_top
    self.execute_script("window.scrollTo(0,0)")
  end

  def scroll_to_bottom
    self.execute_script("window.scrollTo(0, window.document.documentElement.scrollHeight)")
  end

  def screen_width
    self.execute_script("return screen.width;")
  end

  def screen_height
    self.execute_script("return screen.height;")
  end

  def page_y_offset
    self.execute_script("return window.pageYOffset;")
  end

  def scroll_down
    height = page_y_offset + 200
    self.execute_script("window.scrollTo(0, #{height})")
  end

end
