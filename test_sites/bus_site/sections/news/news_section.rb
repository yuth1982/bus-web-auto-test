module Bus
  # This class provides actions for news section
  class NewsSection < SiteHelper::Section


    # Public: get new windows page title
    #
    #
    # Example
    #   @bus_site.admin_console_page.news_section.get_page_title
    #
    # @return [] nothing
    def get_new_window_page_title()
      page.driver.browser.switch_to().window(page.driver.browser.window_handles.last)
      title = page.driver.browser.title
      page.driver.browser.close
      page.driver.browser.switch_to().window(page.driver.browser.window_handles.last)
      title
    end

    # Public: check the div is visible
    #
    #
    # Example
    #   @bus_site.admin_console_page.news_section.find_div_is_visiable(id)
    #
    # @return [] nothing
    def find_div_is_visiable(id)
      find(:xpath, "//div[@id='#{id}']").visible?
    end

  end
end
