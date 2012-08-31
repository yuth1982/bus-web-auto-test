module SiteHelper
  class Section
    include Capybara::DSL
    include Actions
    extend Components

    attr_reader :root_element

    def initialize(root_element)
      @root_element = root_element
    end

    def find_element(type, locator, hidden = false)
      case type
        when :link
          css_str = "a:contains('#{locator}')"
          wait_until { hidden ? !root_element.find(:css, css_str).visible? : root_element.find(:css, css_str).visible? }
          root_element.find(:css, css_str)
        else
          wait_until { hidden ? !find(type, locator).visible? : root_element.find(type, locator).visible? }
          root_element.find(type, locator)
      end
    end

    def find_elements(type, locator, hidden = false)
      case type
        when :link
          css_str = "a:contains('#{locator}')"
          wait_until { hidden ? !root_element.find(css_str).visible? : root_element.find(css_str).visible? }
          root_element.all(css_str)
        else
          wait_until { hidden ? !root_element.find(type, locator).visible? : root_element.find(type, locator).visible? }
          root_element.all(type, locator)
      end
    end
  end
end
