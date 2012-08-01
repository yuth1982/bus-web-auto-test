module Aria
  # This class provides actions for accounts page
  class AccountsPage < PageObject

    section(:search_account_view, SearchAccountView)
    section(:account_overview_view, AccountOverviewView)
    section(:notification_method_view, NotificationMethodView)
    section(:account_groups_view, AccountGroupsView)

    # Public: Click link on aira account page top navigation menu
    #
    # Example
    #   @aria_admin_console_page.account_page.navigate_to_link("Account Overview")
    #
    # Returns nothing
    def navigate_to_link(link_name)
      driver.find_element(:xpath, "//a[@title='#{link_name}']").click
    end
  end
end