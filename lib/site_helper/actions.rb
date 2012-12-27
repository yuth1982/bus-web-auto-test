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
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.driver.browser.switch_to.default_content
      else
        raise("switch_to_default_frame method only works for Selenium Driver")
      end
    end

    # Public: alert_text
    #
    # Returns nothing
    def alert_text
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.driver.browser.switch_to.alert.text
      else
        raise("alert_text method only works for Selenium Driver")
      end
    end

    # Public: alert_accept
    #
    # Returns nothing
    def alert_accept
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.driver.browser.switch_to.alert.accept
      else
        raise("alert_accept method only works for Selenium Driver")
      end
    end

    # Public: alert_dismiss
    #
    # Returns nothing
    def alert_dismiss
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.driver.browser.switch_to.alert.dismiss
      else
        raise("alert_dismiss method only works for Selenium Driver")
      end
    end

    # Public: Refresh bus admin console section
    #
    # Example:
    #   @bus_site.admin_console_page.refresh_bus_section
    #
    # Returns nothing
    def refresh_bus_section
      root_element.find(:xpath, "h2/a[contains(@onclick,'refresh_module')]").click
      loading = root_element.find(:xpath, "h2/a[contains(@onclick,'toggle_module')]")
      wait_until{ loading[:class].match(/loading/).nil? }
      # I found automation is still too faster, I need force to wait until table is loaded
      # Possible refactor here
      sleep 2
    end

    # Public: close bus admin console section
    #
    # Example:
    #   @bus_site.admin_console_page.close_bus_section
    #
    # Returns nothing
    def close_bus_section
      root_element.find(:css, "a[onclick^='delete_module']").click
    end
  end
end