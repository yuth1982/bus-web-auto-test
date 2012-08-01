module Aria
  # This class provides actions for account overview view
  class AccountOverviewView < PageObject

    section(:account_status_view, AccountStatusView)
    section(:taxpayer_view, TaxpayerView)

    # Private elements
    #
    element(:overview_table, {:xpath => "//div[@id='content-wrapper']//table[@class='data-table']"})

    # Public: Click the link on aria account overview page
    #
    # Example
    #   @aria_admin_console_page.accounts_page.account_overview_view.navigate_to_link("Status")
    #
    # Returns nothing
    def navigate_to_link(link_name)
      driver.find_element(:link, link_name).click
    end

    # Public: Aria account status on account overview page
    #
    # Example
    #   @aria_admin_console_page.accounts_page.account_overview_view.account_status_text
    #   # => "ACTIVE"
    #
    # Returns account status text
    def account_status_text
      overview_table.body_rows_text[1][3]
    end
  end
end
