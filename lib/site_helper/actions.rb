module SiteHelper
  module Actions
    include Capybara::DSL

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

  end
end