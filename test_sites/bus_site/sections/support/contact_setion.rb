module Bus
  # This class provides actions for contact section
  class ContactSection < SiteHelper::Section
    # Private elements
    #
    element(:my_support_link, xpath: "//a[text()='My Support']")

    # Public: Click My Support
    #
    # Examples:
    #  @bus_site.admin_console_page.contact_section.click_my_support
    #
    # @return [] nothing
    def click_my_support
      my_support_link.click
    end

  end
end
