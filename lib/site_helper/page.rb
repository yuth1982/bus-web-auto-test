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
  end
end
