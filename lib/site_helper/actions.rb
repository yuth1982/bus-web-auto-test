module SiteHelper
  module Actions
    include Capybara::DSL

    # Public: Switch page content to iframe
    #
    # Example:
    #    switch_to_iframe(%w( outerFrame mainFrame work_frm inner_work_frm ))
    #    or
    #    switch_to_iframe('outerFrame')
    #
    # Returns nothing
    def switch_to_iframe(frame_ids)
      switch_to_default_frame
      case frame_ids
        when String
          sleep 5 # Force wait
          page.driver.browser.switch_to.frame(frame_ids)
        when Array
          frame_ids.each do |id |
            sleep 5 # Force wati
            page.driver.browser.switch_to.frame(id)
          end
        else
          raise "Unknown input value type"
      end
    end

    # Public: switch
    #
    # Returns nothing
    def switch_to_default_frame
      page.driver.browser.switch_to.default_content
    end

    # Public: alert_text
    #
    # Returns nothing
    def alert_text
      page.driver.browser.switch_to.alert.text
    end

    # Public: alert_accept
    #
    # Returns nothing
    def alert_accept
      page.driver.browser.switch_to.alert.accept
    end

    # Public: alert_dismiss
    #
    # Returns nothing
    def alert_dismiss
      page.driver.browser.switch_to.alert.dismiss
    end

    # Public: Refresh bus admin console section
    # This method is only for bus admin console pages
    #
    # Returns nothing
    def refresh_bus_section
      self.find(:css, "img[alt='Refresh']").click
      wait_until{ self.find(:xpath, "//a[contains(@onclick,'toggle_module')]")[:class] != "title loading" }
      # I found automation is still too faster, I need force to wait until table is loaded
      # Possible refactor here
      sleep 2
    end
  end
end