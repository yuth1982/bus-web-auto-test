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

    # Public: Wait until bus admin console section loaded
    #
    # Example:
    #   @bus_site.admin_console_page.search_list_partner_section.wait_until_bus_section_load
    #
    # Returns nothing
    def wait_until_bus_section_load
      loading = root_element.find(:xpath, "h2/a[contains(@onclick,'toggle_module')]")
      wait_until{ loading[:class].match(/loading/).nil? }
    end
  end
end
