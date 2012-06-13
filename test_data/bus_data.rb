module Bus
# Database
DEMETER = "host=10.29.29.135 port=5432 dbname=demeter user=bus password="

  # Bus enter page
  BUS_LOGIN_URL = "https://www.mozypro.com/login/admin?old_school=1"

  # Browser settings
  BROWSER_IMPLICIT_WAIT = 300

  COMPANY_TYPE =
  {
    :reseller             => 'Reseller',
    :mozypro              => 'MozyPro',
    :mozyenterprise       => 'MozyEnterprise',
  }

  MOZY_ROOT_PARTNER =
  {
    :mozy_pro             => 'MozyPro',
    :mozy_pro_france      => 'MozyPro France',
    :mozy_pro_germany     => 'MozyPro Germany',
    :mozy_pro_ireland     => 'MozyPro Ireland',
    :mozy_pro_uk          => 'MozyPro UK',
  }

  DEFAULT_PWD = "test1234"


end
