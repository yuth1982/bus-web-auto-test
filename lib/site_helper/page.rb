module SiteHelper
  class Page
    include Capybara::DSL
    include Actions
    extend Components

    def self.url
      @url
    end

    def url
      self.class.url
    end

    def self.set_url(page_url)
      @url = page_url
    end

    def load
      raise "NoUrlForPage" if url.nil?
      page.reset_session!
      visit(url)
    end

    # Public: Get all cookies from current page
    #
    # Example:
    #   @bus_site.login_page.cookies
    #   # => Array<Hash>
    #
    # Returns Array<Hash> - list of cookies
    def cookies
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.driver.browser.manage.all_cookies
      else
        raise("cookies method only works for Selenium Driver")
      end
    end
  end
end
