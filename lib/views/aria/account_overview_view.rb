module Aria
  # This class provides actions for account overview view
  class AccountOverviewView < PageObject

    section(:account_status_view, AccountStatusView)
    section(:taxpayer_view, TaxpayerView)

    # Private elements
    #
    # Links
    element(:master_plan_link, {:link => "Master Plan"})
    element(:supplemental_plans_link, {:link => "Supplemental Plans"})
    element(:status_link, {:link => "Status"})
    # Tables
    element(:overview_table, {:xpath => "//table[@class='data-table']"})

    def navigate_to_change_status_view
      status_link.click
    end

    def account_status_text
      overview_table.body_rows_text[1][3]
    end
  end
end
