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
  end
end
