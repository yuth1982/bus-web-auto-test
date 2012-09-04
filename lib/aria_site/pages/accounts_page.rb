module Aria
  # This class provides actions for accounts page
  class AccountsPage < SiteHelper::Page
    set_url("#{Aria::ARIA_HOST}/AdminTools.php/Accounts/show")

    section(:side_menu_section, SideMenuSection, id: 'sidebar')
    section(:account_overview_section, AccountOverviewSection, id: 'content-wrapper')
    section(:notification_method_section, NotificationMethodSection, xpath: '*')
    section(:account_groups_section, AccountGroupsSection, xpath: '*')
    section(:taxpayer_section, TaxpayerSection, xpath: '*')
    section(:account_status_section, AccountStatusSection, xpath: '*')
  end
end