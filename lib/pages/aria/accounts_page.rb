module Aria
  class AccountsPage < PageObject
    component(:search_account_view, SearchAccountView)
    component(:account_overview_view, AccountOverviewView)
    component(:notification_method_view, NotificationMethodView)

    element(:search_link,{:xpath => "//a[@title='Search']"})
    element(:account_overview_link,{:xpath => "//a[@title='Account Overview']"})
    element(:plan_services_link,{:xpath => "//a[@title='Plans & Services']"})
    element(:statements_invoices_link,{:xpath => "//a[@title='Statements & Invoices']"})
    element(:payments_credits_link,{:xpath => "//a[@title='Payments & Credits']"})
    element(:usage_history_link,{:xpath => "//a[@title='Usage History']"})
    element(:create_accounts_link,{:xpath => "//a[@title='Create Accounts']"})

    element(:notify_method_link, {:link => "Notification Method"})
    element(:taxpayer_information_link, {:link => "Taxpayer Information"})
  end
end