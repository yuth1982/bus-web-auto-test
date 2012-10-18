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
  end
end



        #when :link
         # css_str = "a:contains('#{locator}')"
