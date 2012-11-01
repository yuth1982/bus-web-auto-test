module SiteHelper
  class Section
    include Capybara::DSL
    include Actions
    extend Components

    attr_reader :root_element

    def initialize(root_element)
      @root_element = root_element
    end

    def find(type, locator)
      root_element.find(type, locator)
    end

    def all(type, locator)
      root_element.all(type, locator)
    end

    def find_link(locator)
      root_element.find_link(locator)
    end

  end
end
