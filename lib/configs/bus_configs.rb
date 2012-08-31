module Bus
  # Bus login page
  BUS_HOST = ENV["BUS_HOST"] || "https://www.mozypro.com"

  COMPANY_TYPE =
  {
    mozypro: "MozyPro",
    mozyenterprise: "MozyEnterprise",
    reseller: "Reseller"
  }

  RESELLER_TYPE =
  {
    silver: "Silver",
    gold: "Gold",
    platinum: "Platinum"
  }

  MOZY_ROOT_PARTNER =
  {
    mozypro: "MozyPro",
    mozypro_france: "MozyPro France",
    mozypro_germany: "MozyPro Germany",
    mozypro_ireland: "MozyPro Ireland",
    mozypro_uk: "MozyPro UK"
  }

  # Default password for all password field
  DEFAULT_PWD = "test1234"
  # partner user email prefix, e.g qa1+reg+test@mozy.com, suffix is fixed
  EMAIL_PREFIX = ENV["EMAIL_PREFIX"] || "qa1"
end

