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
      loading = root_element.find(:css, "h2 a[onclick^=toggle_module]")
      unless loading[:class].nil?
        wait_until{ loading[:class].match(/loading/).nil? }
      end
      # I found automation is still too faster, I need force to wait until table is loaded
      # Possible refactor here
      sleep 2
    end

    # Public: Is section visible and active
    #
    # Example:
    #   @bus_site.admin_console_page.search_list_partner_section.section_visible?
    #
    # Returns bool
    def section_visible?
      root_element.visible?
    end
  end
end
