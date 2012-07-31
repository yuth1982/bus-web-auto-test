module Aria
  # This class provides actions for accounts page
  class AccountsPage < PageObject
    section(:search_account_view, SearchAccountView)
    section(:account_overview_view, AccountOverviewView)
    section(:notification_method_view, NotificationMethodView)
    section(:account_groups_view, AccountGroupsView)

    def navigate_to_link(link_name)
      driver.find_element(:xpath, "//a[@title='#{link_name}']").click
    end
  end
end