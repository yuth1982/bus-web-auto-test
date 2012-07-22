module Aria
  class AccountsPage < PageObject
    section(:search_account_view, SearchAccountView)
    section(:account_overview_view, AccountOverviewView)
    section(:notification_method_view, NotificationMethodView)
    section(:account_groups_view, AccountGroupsView)

    element(:search_link, {:xpath => "//a[@title='Search']"})
    element(:account_overview_link,{:xpath => "//a[@title='Account Overview']"})
    element(:plan_services_link,{:xpath => "//a[@title='Plans & Services']"})
    element(:statements_invoices_link,{:xpath => "//a[@title='Statements & Invoices']"})
    element(:payments_credits_link,{:xpath => "//a[@title='Payments & Credits']"})
    element(:usage_history_link,{:xpath => "//a[@title='Usage History']"})
    element(:create_accounts_link,{:xpath => "//a[@title='Create Accounts']"})

    def navigate_to_link(link_name)
      driver.find_element(:link, link_name).click
    end
  end
end