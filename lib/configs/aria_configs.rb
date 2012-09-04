module Aria
  # Aria enter page
  ARIA_HOST = ENV['ARIA_HOST'] || 'https://admintools.future.stage.ariasystems.net'
  # Default password for all password field
  DEFAULT_PWD = 'test1234'

  PRIMARY_MENU =
  {
    dashboard: 'Dashboard',
    accounts: 'Accounts',
  }

  SECONDARY_MENU =
  {
    search: 'Search',
    account_overview: 'Account Overview'
  }
end
