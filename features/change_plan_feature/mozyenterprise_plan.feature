Feature:

  Background:
    Given I log in bus admin console as administrator

  @TC.16841
  Scenario: 16841 MozyPro Enterprise Yearly to 50 GB Add-on
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 10    |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
    | users | server plan                  | server add-on |
    | 20    | 50 GB Server Plan, $296.78   | 1             |
    Then Change plan charge summary should be:
    | Description                | Amount    |
    | Charge for upgraded plans  | $2,291.67 |
    Then Account plan should be changed
    Then MozyEnterprise current purchase should be 50 GB Server Plan, $296.78

# Show / Hide direct link   Mozy-16865:MozyPro Enterprise 250 Server Add-on Yearly to 500 GB Add-on
# Show / Hide direct link   Mozy-16955:MozyPro Enterprise 500 Server Add-on 2 year to 1 TB Add-on
# Show / Hide direct link   Mozy-16997:MozyPro Enterprise 1 TB Server Add-on 3 year to 2 TB Add-on

  #Show / Hide direct link   Mozy-17735:MozyPro Enterprise 2 TB Server Add-on 2 year to 1 TB Add-on
# Show / Hide direct link   Mozy-17733:MozyPro Enterprise 4 TB Server Add-on 3 year to 2 TB Add-on
  #Show / Hide direct link   Mozy-17740:MozyPro Enterprise 1 TB Server Add-on Yearly to 500 GB Add-on