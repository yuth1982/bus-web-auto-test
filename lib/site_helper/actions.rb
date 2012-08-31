module SiteHelper
  module Actions
    include Capybara::DSL

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