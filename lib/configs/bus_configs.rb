module Bus
  # Bus login page
  BUS_HOST = ENV['BUS_HOST'] || 'https://www.mozypro.com'

  COMPANY_TYPE =
  {
    mozypro: 'MozyPro',
    mozyenterprise: 'MozyEnterprise',
    reseller: 'Reseller'
  }

  RESELLER_TYPE =
  {
    silver: 'Silver',
    gold: 'Gold',
    platinum: 'Platinum'
  }

  MOZY_ROOT_PARTNER =
  {
    mozypro: 'MozyPro',
    mozypro_france: 'MozyPro France',
    mozypro_germany: 'MozyPro Germany',
    mozypro_ireland: 'MozyPro Ireland',
    mozypro_uk: 'MozyPro UK'
  }

  MENU =
  {
    # Partners
    add_new_partner: 'Add New Partner',
    search_list_partner: 'Search / List Partners',
    # Users
    search_list_users: 'Search / List Users',
    search_list_machines: 'Search / List Machines',
    list_user_groups: 'List User Groups',
    add_new_user_group: 'Add New User Group',
    # Admins
    search_admin: 'Search Admins',
    list_admins: 'List Admins',
    add_new_admin: 'Add New Admin',
    list_roles: 'List Roles',
    add_new_role: 'Add New Role',
    list_capabilities: 'List Capabilities',
    #Configurations
    accont_details: 'Account Details',
    password_policy: 'Password Policy', #Eliminated in 2.1
    authentication_policy: 'Authentication Policy',
    # Resources
    change_plan: 'Change Plan',
    order_data_shuttle: 'Order Data Shuttle',
    view_data_shuttle_orders: 'View Data Shuttle Orders',
    data_shuttle_status: 'Data Shuttle Status',
    billing_information: 'Billing Information',
    billing_history: 'Billing History',
    change_payment_information: 'Change Payment Information',
    manage_resources: 'Manage Resources',
    assign_keys: 'Assign Keys',
    transfer_resources: 'Transfer Resources',
    return_unused_resources: 'Return Unused Resources',
    # Reports
    report_builder: 'Report Builder',
    scheduled_reports: 'Scheduled Reports',
    quick_reports: 'Quick Reports'
  }

  # Default password for all password field
  DEFAULT_PWD = 'test1234'
  # partner user email prefix, e.g qa1+reg+test@mozy.com, suffix is fixed
  EMAIL_PREFIX = ENV['EMAIL_PREFIX'] || 'qa1'
end

