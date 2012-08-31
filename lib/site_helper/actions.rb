module SiteHelper
  module Actions
    include Capybara::DSL

    def find_element(type, locator, hidden = false)
      case type
        when :link
          css_str = "a:contains('#{locator}')"
          wait_until { hidden ? !find(:css, css_str).visible? : find(:css, css_str).visible? }
          find(:css, css_str)
        else
          wait_until { hidden ? !find(type, locator).visible? : find(type, locator).visible? }
          find(type, locator)
      end
    end

    def find_elements(type, locator, hidden = false)
      case type
        when :link
          css_str = "a:contains('#{locator}')"
          wait_until { hidden ? !find(css_str).visible? : find(css_str).visible? }
          all(css_str)
        else
          wait_until { hidden ? !find(type, locator).visible? : find(type, locator).visible? }
          all(type, locator)
      end
    end

    def evaluate_script(script)
      page.evaluate_script(script)
    end

    def suppress_alert(accept=true)
      evaluate_script("window.confirm = function() { return #{accept}; }")
    end

    def switch_to_iframe(frame_ids)
      switch_to_default_frame
      frame_ids.each do |id |
        wait_until { find(:id, id).visible? }
        page.driver.browser.switch_to.frame(id)
      end
    end

    def switch_to_default_frame
      page.driver.browser.switch_to.default_content
    end

    def navigate_to_link(link_text)
      find_element(:link, link_text).click
    end
  end
end