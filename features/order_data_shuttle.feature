Feature:
  Order data shuttle

  Background:
    Given I log in bus admin console as administrator

  @add-new-key-1
    Scenario: Verify shipping address UI fields
      When I navigate to order data shuttle view
      And I order data shuttle for Centizu Company

  @add-new-key-1
  Scenario: Add a new key
    When I navigate to order data shuttle view
    And I order data shuttle for Centizu Company
    And I add a new key of 20 GB quota, assigned to qa1+data+shuttle+test@mozy.com

