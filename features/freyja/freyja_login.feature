Feature: Login to Freyja

  @TC.120248 @freyja @log_in_home
  Scenario: MozyHome user log into Freyja with valid username and password
    When I navigate to MozyHome login page
    And I log into MozyHome freyja with username jeffw+qa13scroll@mozy.com and password test1234
    Then I login freyja successfully  
  @TC.120248 @freyja @log_in_mozypro
  Scenario: MozyPro user log into Freyja with valid username and password
    When I navigate to MozyPro login page
    And I log into MozyPro freyja with username jeffw+qa13brandold@mozy.com and password test1234
    Then I login freyja successfully
  @TC.120248 @freyja @log_in_mozyenterprise
  Scenario: MozyEnterprise user log into Freyja with valid username and password
    When I navigate to MozyEnterprise login page
    And I log into MozyEnterprise freyja with username jeffw+qa13dps@mozy.com and password test1234
    Then I login freyja successfully
  @TC.120248 @freyja @log_in_oem
  Scenario: OEM user log into Freyja with valid username and password
    When I navigate to OEM login page
    And I log into OEM freyja with username marshallk+oem@mozy.com and password Test1234!
    Then I login freyja successfully
