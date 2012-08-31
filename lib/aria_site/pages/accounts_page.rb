module Aria
  # This class provides actions for accounts page
  class AccountsPage < SiteHelper::Page
    set_url("/AdminTools.php/Accounts/show")

    section(:side_menu_section, SideMenuSection, id: "sidebar")
    section(:account_overview_section, AccountOverviewSection, id: "content-wrapper")
    section(:notification_method_section, NotificationMethodSection, css: "body.inner-body")
    section(:account_groups_section, AccountGroupsSection, css: "body.inner-body")
    section(:taxpayer_section, TaxpayerSection, css: "body.inner-body")
    section(:account_status_section, AccountStatusSection, css: "body.inner-body")

  end
end