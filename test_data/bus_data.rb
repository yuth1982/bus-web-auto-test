module Bus
  # Database
  #DEMETER = "host=10.29.29.135 port=5432 dbname=demeter user=bus password="

  # Bus login page
  BUS_LOGIN_URL = "https://www.mozypro.com/login/admin?old_school=1"

  # Browser time out in seconds
  BROWSER_IMPLICIT_WAIT = 60

  COMPANY_TYPE =
  {
    :reseller             => 'Reseller',
    :mozypro              => 'MozyPro',
    :mozyenterprise       => 'MozyEnterprise',
  }

  RESELLER_TYPE =
  {
    :silver               => 'Silver Reseller',
    :gold                 => 'Gold Reseller',
    :platinum             => 'Platinum Reseller',
  }

  MOZY_ROOT_PARTNER =
  {
    :mozy_pro             => 'MozyPro',
    :mozy_pro_france      => 'MozyPro France',
    :mozy_pro_germany     => 'MozyPro Germany',
    :mozy_pro_ireland     => 'MozyPro Ireland',
    :mozy_pro_uk          => 'MozyPro UK',
  }
  # Default password for all password field
  DEFAULT_PWD = "test1234"
  # partner user email prefix, e.g qa1+reg+test@mozy.com, suffix is fixed
  EMAIL_PREFIX = "qa1"
  # Log level control, e.g display partner.to_s
  DEBUG = true
end

