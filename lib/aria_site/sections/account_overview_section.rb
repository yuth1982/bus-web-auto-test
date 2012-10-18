module Aria
  # This class provides actions for account overview page section
  class AccountOverviewSection < SiteHelper::Section

    # Private elements
    #
    element(:overview_table, xpath: "//div[@id='content-wrapper']//table[@class='data-table']")
    # Public: Click the link on aria account overview page
    #
    # Example
    #   @aria_admin_console_page.accounts_page.account_overview_section.navigate_to_link("Status")
    #
    # Returns nothing
    def navigate_to_link(link_name)
      find_link(link_name).click
    end

    # Public: Aria account status on account overview page
    #
    # Example
    #   @aria_admin_console_page.accounts_page.account_overview_section.account_status
    #   # => "ACTIVE"
    #
    # Returns account status text
    def account_status
      overview_table.rows_text[1][3]
    end
  end
end
