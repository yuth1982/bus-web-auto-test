module Bus
  # Database
  #DEMETER = "host=10.29.29.135 port=5432 dbname=demeter user=bus password="

  # Bus login page
  BUS_LOGIN_URL = "https://www.mozypro.com/login/admin?old_school=1"

  COMPANY_TYPE =
  {
      :mozypro => "MozyPro",
      :mozyenterprise => "MozyEnterprise",
      :reseller => "Reseller"
  }

  RESELLER_TYPE =
  {
      :silver => "Silver",
      :gold => "Gold",
      :platinum => "Platinum"
  }

  MOZY_ROOT_PARTNER =
  {
      :mozypro => "MozyPro",
      :mozypro_france => "MozyPro France",
      :mozypro_germany => "MozyPro Germany",
      :mozypro_ireland => "MozyPro Ireland",
      :mozypro_uk => "MozyPro UK"
  }

  # Default password for all password field
  DEFAULT_PWD = "test1234"
  # partner user email prefix, e.g qa1+reg+test@mozy.com, suffix is fixed
  EMAIL_PREFIX = "qa1"
end

