Feature: Change VAT Number


  Background:
    Given I log in bus admin console as administrator

  #
  #Partner Admin Change/Partner Details
  #
  @TC.2000001 @bus @change_vat_number
  Scenario: 2000001 Partner admin change VAT number with valid value
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | server plan |  cc number         |
      | 1      | 100 GB    | Italy   |  yes        |  4916921703777575  |
    And the partner is successfully added.
    And I log in bus admin console as new partner admin
    Then I open partner details by partner name in header
    When I change the partner contact information to:
      | VAT Number:     |
      | IT03018900245   |
    Then Partner contact information is changed
#    And Partner contact information should be:
#      | VAT Number:     |
#      | IT03018900245   |
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.2000002 @bus @change_vat_number
  Scenario: 2000002 Partner admin change VAT number with other country's VAT number
    When I add a new MozyPro partner:
      | period | base plan | country | cc number         |
      | 1      | 50 GB     | France  | 4485393141463880  |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    Then I open partner details by partner name in header
    When I change the partner contact information to:
      | VAT Number:     |
      | IT03018900245   |
    Then VAT number shouldn't be changed and the error message should be:
    """
    Error updating VAT info. Please try again.
    """
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.2000003 @bus @change_vat_number
  Scenario: 2000003 Partner admin change VAT number with invalid value
    When I add a new MozyPro partner:
      | period | base plan | country |  cc number         |
      | 12     | 50 GB     | France  |  4485393141463880  |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    Then I open partner details by partner name in header
    When I change the partner contact information to:
      | VAT Number:     |
      | IT03            |
    Then VAT number shouldn't be changed and the error message should be:
    """
    Error updating VAT info. Please try again.
    """
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.2000004 @bus @change_vat_number
  Scenario: 2000004 Partner admin change VAT number with blank value should succeed
    When I add a new MozyEnterprise partner:
      | period | base plan | country | vat number    |  cc number         |
      | 24     | 50 GB     | France  | FR08410091490 |  4485393141463880  |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    Then I open partner details by partner name in header
    When I change the partner contact information to:
      | VAT Number:     |
      |                 |
    Then Partner contact information is changed
#    And Partner contact information should be:
#      | VAT Number:     |
#      |                 |
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  #
  #Partner Admin Change/VAT Number in "Change Contact Country"
  #
  @TC.2000005 @bus @change_vat_number
  Scenario: 2000005 Partner admin change from EU country to Non-EU country check VAT Number
    When I add a new Reseller partner:
      | period | country |  cc number        |
      | 12     | France  |  4485393141463880 |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    Then I open partner details by partner name in header
    Then I am partner admin and I change contact country to Non-EU country
    Then VAT number field of Change Contact Country section should disappear
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.2000006 @bus @change_vat_number
  Scenario: 2000006 Partner admin change from Non-EU country to EU country check VAT Number
    When I add a new Reseller partner:
      | period | country        | cc number        |
      | 12     | United States  | 4916655952145825 |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    Then I open partner details by partner name in header
    Then I am partner admin and I change contact country to EU country
    Then VAT number field of Change Contact Country section should appear
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.2000007 @bus @change_vat_number
  Scenario: 2000007 Partner admin change VAT number with valid value should succeed
    When I add a new MozyEnterprise partner:
      | period | base plan | country |  cc number        |
      | 24     | 50 GB     | France  | 4485393141463880  |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    Then I open partner details by partner name in header
    And I change contact country and VAT number to:
      | Country | VAT Number    |
      | France  | FR08410091490 |
    Then Change contact country and VAT number should succeed and the message should be:
    """
    Your contact country was successfully updated.
    """
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.2000008 @bus @change_vat_number
  Scenario: 2000008 Partner admin change VAT number with other country's VAT number
    When I add a new MozyEnterprise partner:
      | period | base plan | country | cc number         |
      | 24     | 50 GB     | France  | 4485393141463880  |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    Then I open partner details by partner name in header
    And I change contact country and VAT number to:
      | Country | VAT Number    |
      | France  | DE812321109   |
    Then Change contact country and VAT number shouldn't succeed and the message should be:
    """
     Vat number is not valid
    """
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.2000009 @bus @change_vat_number
  Scenario: 2000009 Partner admin change VAT number with invalid value
    When I add a new MozyEnterprise partner:
      | period | base plan | country | cc number         |
      | 24     | 50 GB     | France  | 4485393141463880  |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    Then I open partner details by partner name in header
    And I change contact country and VAT number to:
      | Country | VAT Number    |
      | France  | invalid11     |
    Then Change contact country and VAT number shouldn't succeed and the message should be:
    """
     Vat number is not valid
    """
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.2000010 @bus @change_vat_number
  Scenario: 2000010 Partner admin change VAT number with blank value should succeed
    When I add a new MozyPro partner:
      | period | base plan | country | vat number     | cc number         |
      | 24     | 50 GB     | France  | FR08410091490  | 4485393141463880  |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    Then I open partner details by partner name in header
    And I change contact country and VAT number to:
      | Country | VAT Number    |
      | France  | @blank_space  |
    Then Change contact country and VAT number should succeed and the message should be:
    """
    Your contact country was successfully updated.
    """
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  #
  #Partner Admin Change/billing information
  #
  @TC.2000011 @bus @change_vat_number
  Scenario: 2000011 Contact country is EU country, check billing information section should have VAT table
    When I add a new MozyPro partner:
      | period | base plan | country | vat number     | cc number         |
      | 24     | 50 GB     | France  | FR08410091490  | 4485393141463880  |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    When I navigate to Billing Information section from bus admin console page
    Then VAT table should display
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.2000012 @bus @change_vat_number
  Scenario: 2000012 Contact country is Non-EU country, check billing information section shouldn't have VAT table
    When I add a new MozyPro partner:
      | period | base plan | country        | cc number          |
      | 24     | 50 GB     | United States  | 4916655952145825   |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    When I navigate to Billing Information section from bus admin console page
    Then VAT table shouldn't display
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.2000013 @bus @change_vat_number
  Scenario: 2000013 billing information section, change vat number with valid value
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          |
      | 24     | 50 GB     | France   | 4485393141463880   |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    When I navigate to Billing Information section from bus admin console page
    Then I change VAT number to:
      | VAT number     |
      | FR08410091490  |
    Then VAT number was saved successfully:
      | VAT number     |
      | FR08410091490  |
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.2000014 @bus @change_vat_number
  Scenario: 2000014 billing information section, change vat number with other country's VAT number
    When I add a new MozyPro partner:
      | period | base plan | country          | cc number          |
      | 24     | 50 GB     | United Kingdom   | 4916783606275713   |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    When I navigate to Billing Information section from bus admin console page
    Then I change VAT number to:
      | VAT number     |
      | FR08410091490  |
    Then Fail to change VAT number:
    """
    VAT number is invalid. Please try again.
    """
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.2000015 @bus @change_vat_number
  Scenario: 2000015 billing information section, change vat number with invalid VAT number
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          |
      | 24     | 50 GB     | France   | 4485393141463880   |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    When I navigate to Billing Information section from bus admin console page
    Then I change VAT number to:
      | VAT number     |
      | invalid_number |
    Then Fail to change VAT number:
    """
    VAT number is invalid. Please try again.
    """
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.2000016 @bus @change_vat_number
  Scenario: 2000016 billing information section, change vat number with blank value
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          | vat number    |
      | 24     | 50 GB     | France   | 4485393141463880   | FR08410091490 |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    When I navigate to Billing Information section from bus admin console page
    Then I change VAT number to:
      | VAT number   |
      | @blank_value |
    Then VAT number was saved successfully:
      | VAT number   |
      | @blank_value |
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.2000017 @bus @change_vat_number
  Scenario: 2000017 billing information section, delete vat number
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          | vat number    |
      | 24     | 50 GB     | France   | 4485393141463880   | FR08410091490 |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    When I navigate to Billing Information section from bus admin console page
    Then I delete VAT number
    Then VAT number was deleted successfully
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  #
  #BUS Admin Change/Partner Details
  #
  @TC.2000018 @bus @change_vat_number
  Scenario: 2000018 BUS admin change partner's contact country from EU country to Non-EU country, check VAT number field
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          |
      | 24     | 1 TB      | France   | 4485393141463880   |
    Then New partner should be created
    Then I am BUS admin and I change contact country to Non-EU country
    Then VAT number field of Partner Details section should disappear
    And I delete partner account

  @TC.2000019 @bus @change_vat_number
  Scenario: 2000019 BUS admin change partner's contact country from Non-EU country to EU country, check VAT number field
    When I add a new MozyPro partner:
      | period | base plan | country        | server plan |  cc number         |
      | 1      | 100 GB    | United States  |  yes        |  4916655952145825  |
    Then New partner should be created
    Then I am BUS admin and I change contact country to EU country
    Then VAT number field of Partner Details section should appear
    And I delete partner account

  @TC.2000020 @bus @change_vat_number
  Scenario: 2000020 BUS admin change partner's contact country (with a vat number) from EU country to Non-EU country, save changes
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          | vat number    |
      | 12     | 50 GB     | France   | 4485393141463880   | FR08410091490 |
    Then New partner should be created
    Then I expand contact info from partner details section
    When I change the partner contact information to:
      | Contact Country: |
      | United States    |
    Then Partner contact information is changed
    And Partner contact information should be:
      | Contact Country:  |
      | United States     |
    And I delete partner account

  @TC.2000021 @bus @change_vat_number
  Scenario: 2000021 BUS admin edit partner's VAT number with other country's VAT number
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          |
      | 12     | 50 GB     | France   | 4485393141463880   |
    Then New partner should be created
    Then I expand contact info from partner details section
    When I change the partner contact information to:
      | VAT Number:      |
      | DE812321109      |
    Then VAT number shouldn't be changed and the error message should be:
    """
    Error updating VAT info. Please try again.
    """
    And I delete partner account

  @TC.2000022 @bus @change_vat_number
  Scenario: 2000022 BUS admin edit partner's VAT number with invalid value
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          |
      | 12     | 50 GB     | France   | 4485393141463880   |
    Then New partner should be created
    Then I expand contact info from partner details section
    When I change the partner contact information to:
      | VAT Number:      |
      | invalid_number   |
    Then VAT number shouldn't be changed and the error message should be:
    """
    Error updating VAT info. Please try again.
    """
    And I delete partner account

  @TC.2000023 @bus @change_vat_number
  Scenario: 2000023 BUS admin edit partner's VAT number with blank value
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          | vat number    |
      | 1      | 50 GB     | France   | 4485393141463880   | FR08410091490 |
    Then New partner should be created
    Then I expand contact info from partner details section
    When I change the partner contact information to:
      | VAT Number:      |
      |                  |
    Then Partner contact information is changed
#    And Partner contact information should be:
#      | VAT Number:     |
#      |                 |
    And I delete partner account

  @TC.2000024 @bus @change_vat_number
  Scenario: 2000024 BUS admin edit partner's contact country and VAT number with valid value
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          | vat number    |
      | 24     | 50 GB     | France   | 4485393141463880   | FR08410091490 |
    Then New partner should be created
    Then I expand contact info from partner details section
    When I change the partner contact information to:
      | Contact Country: | VAT Number:      |
      | Germany          | DE812321109      |
    Then Partner contact information is changed
#    And Partner contact information should be:
#      | Contact Country: | VAT Number:      |
#      | Germany          | DE812321109      |
    And I delete partner account

  #
  #BUS Admin Change/act as partner: Partner Details
  #
  @TC.2000025 @bus @change_vat_number
  Scenario: 2000025 act as partner and change contact country from EU country to Non-EU country, check VAT number field
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          |
      | 12     | 1 TB      | France   | 4485393141463880   |
    Then New partner should be created
    When I act as newly created partner account
    Then I open partner details by partner name in header
    Then I am BUS admin and I change contact country to Non-EU country
    Then VAT number field of Partner Details section should disappear
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.2000026 @bus @change_vat_number
  Scenario: 2000026 act as partner and change contact country from Non-EU country to EU country, check VAT number field
    When I add a new MozyPro partner:
      | period | base plan | country        | server plan |  cc number         |
      | 1      | 4 TB      | United States  |  yes        |  4916655952145825  |
    Then New partner should be created
    When I act as newly created partner account
    Then I open partner details by partner name in header
    Then I am BUS admin and I change contact country to EU country
    Then VAT number field of Partner Details section should appear
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.2000027 @bus @change_vat_number
  Scenario: 2000027 act as partner and change contact country (with a vat number) from EU country to Non-EU country, save changes
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          | vat number    |
      | 12     | 4 TB      | France   | 4485393141463880   | FR08410091490 |
    Then New partner should be created
    When I act as newly created partner account
    Then I open partner details by partner name in header
    When I change the partner contact information to:
      | Contact Country: |
      | United States    |
    Then Partner contact information is changed
    And Partner contact information should be:
      | Contact Country:  |
      | United States     |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.2000028 @bus @change_vat_number
  Scenario: 2000028 act as partner and edit its VAT number with other country's VAT number
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          |
      | 12     | 100 GB    | France   | 4485393141463880   |
    Then New partner should be created
    When I act as newly created partner account
    Then I open partner details by partner name in header
    When I change the partner contact information to:
      | VAT Number:      |
      | DE812321109      |
    Then VAT number shouldn't be changed and the error message should be:
    """
    Error updating VAT info. Please try again.
    """
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.2000029 @bus @change_vat_number
  Scenario: 2000029 act as partner and edit its VAT number with invalid value
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          |
      | 12     | 100 GB    | France   | 4485393141463880   |
    Then New partner should be created
    When I act as newly created partner account
    Then I open partner details by partner name in header
    When I change the partner contact information to:
      | VAT Number:      |
      | invalid_number   |
    Then VAT number shouldn't be changed and the error message should be:
    """
    Error updating VAT info. Please try again.
    """
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.2000030 @bus @change_vat_number
  Scenario: 2000030 act as partner and edit its VAT number with blank value
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          | vat number    |
      | 24     | 50 GB     | France   | 4485393141463880   | FR08410091490 |
    Then New partner should be created
    When I act as newly created partner account
    Then I open partner details by partner name in header
    When I change the partner contact information to:
      | VAT Number:      |
      |                  |
    Then Partner contact information is changed
#    And Partner contact information should be:
#      | VAT Number:     |
#      |                 |
  When I stop masquerading
  And I search and delete partner account by newly created partner company name

  @TC.2000031 @bus @change_vat_number
  Scenario: 2000031 act as partner, edit its contact country and VAT number with valid value
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          | vat number    |
      | 24     | 100 GB    | France   | 4485393141463880   | FR08410091490 |
    Then New partner should be created
    When I act as newly created partner account
    Then I open partner details by partner name in header
    When I change the partner contact information to:
      | Contact Country: | VAT Number:      |
      | Germany          | DE812321109      |
    Then Partner contact information is changed
#    And Partner contact information should be:
#      | Contact Country: | VAT Number:      |
#      | Germany          | DE812321109      |
  When I stop masquerading
  And I search and delete partner account by newly created partner company name

  #
  #BUS Admin Change/billing information
  #
  @TC.2000032 @bus @change_vat_number
  Scenario: 2000032 act as a partner which contact country is EU country, check billing information section should have VAT table
    When I add a new MozyPro partner:
      | period | base plan | country | vat number     | cc number         |
      | 24     | 50 GB     | France  | FR08410091490  | 4485393141463880  |
    Then New partner should be created
    When I act as newly created partner account
    When I navigate to Billing Information section from bus admin console page
    Then VAT table should display
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.2000033 @bus @change_vat_number
  Scenario: 2000033 act as a partner which contact country is Non-EU country, check billing information section shouldn't have VAT table
    When I add a new MozyPro partner:
      | period | base plan | country        | cc number          |
      | 24     | 50 GB     | United States  | 4916655952145825   |
    Then New partner should be created
    When I act as newly created partner account
    When I navigate to Billing Information section from bus admin console page
    Then VAT table shouldn't display
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.2000034 @bus @change_vat_number
  Scenario: 2000034 act as a partner and then go to billing information section, change vat number with valid value
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          |
      | 24     | 50 GB     | France   | 4485393141463880   |
    Then New partner should be created
    When I act as newly created partner account
    When I navigate to Billing Information section from bus admin console page
    Then I change VAT number to:
      | VAT number     |
      | FR08410091490  |
    Then VAT number was saved successfully:
      | VAT number     |
      | FR08410091490  |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.2000035 @bus @change_vat_number
  Scenario: 2000035 act as a partner and then go to billing information section, change vat number with other country's VAT number
    When I add a new MozyPro partner:
      | period | base plan | country          | cc number          |
      | 24     | 50 GB     | United Kingdom   | 4916783606275713   |
    Then New partner should be created
    When I act as newly created partner account
    When I navigate to Billing Information section from bus admin console page
    Then I change VAT number to:
      | VAT number     |
      | FR08410091490  |
    Then Fail to change VAT number:
    """
    VAT number is invalid. Please try again.
    """
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.2000036 @bus @change_vat_number
  Scenario: 2000036 act as a partner and then go to billing information section, change vat number with invalid VAT number
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          |
      | 24     | 50 GB     | France   | 4485393141463880   |
    Then New partner should be created
    When I act as newly created partner account
    When I navigate to Billing Information section from bus admin console page
    Then I change VAT number to:
      | VAT number     |
      | invalid_number |
    Then Fail to change VAT number:
    """
    VAT number is invalid. Please try again.
    """
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.2000037 @bus @change_vat_number
  Scenario: 2000037 act as a partner and then go to billing information section, change vat number with blank value
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          | vat number    |
      | 24     | 50 GB     | France   | 4485393141463880   | FR08410091490 |
    Then New partner should be created
    When I act as newly created partner account
    When I navigate to Billing Information section from bus admin console page
    Then I change VAT number to:
      | VAT number   |
      | @blank_value |
    Then VAT number was saved successfully:
      | VAT number   |
      | @blank_value |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.2000038 @bus @change_vat_number
  Scenario: 2000038 act as a partner and then go to billing information section, delete vat number
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          | vat number    |
      | 24     | 50 GB     | France   | 4485393141463880   | FR08410091490 |
    Then New partner should be created
    When I act as newly created partner account
    When I navigate to Billing Information section from bus admin console page
    Then I delete VAT number
    Then VAT number was deleted successfully
    When I stop masquerading
    And I search and delete partner account by newly created partner company name












