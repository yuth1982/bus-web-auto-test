Feature: Adjustable retention at the partner and user group level
  As a Mozy Administrator. I have the ability to enable/disable the data retention capability to different Roles.
  Background:
    Given I log in bus admin console as administrator

  @TC.133059-133064 @bus @data_retention @bus-2.27 @P1
  Scenario: check machine's adr_policy_name when no adr policy set
  #======6 test cases======
    #======step1: create MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC.133059    |   1    |  500 GB    | yes         | yes       |
    #======step2: update role to Business Root which has adr disabled======
    Then I change root role to Business Root
    And I get the partner_id
    And I get the admin id from partner details
    #======step3: act as partner=====
    Then I act as newly created partner account
    #======step4: create multiple users with backup deivces======
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash | server_support |
      | ug1  | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user1 | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ugdf_user2 | (default user group) |  Desktop     |  2            |  1      | Yes          |
      | ugdf_user3 | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ugdf_user4 | (default user group) |  Desktop     |  2            |  1      | Yes          |
    #======step5: delete machine
    When I navigate to Search / List Users section from bus admin console page
    When I search user by:
      | keywords   |
      | ugdf_user2 |
    Then I view user details by ugdf_user2
    And I view machine ugdf_user2_machine_1 details from user details section
    When I delete device by name: ugdf_user2_machine_1
    And the popup message when delete device is Do you want to delete ugdf_user2_machine_1?
    And I refresh User Details section
    Then Device ugdf_user2_machine_1 should not show
    And I close User Details section
    #======step6: stop masquerading from partner======
    And I stop masquerading
    #======step7: search partner and change role to RefID
    #======step7: search partner and change role to RefID
    When I search partner by TC.133059
    And I view partner details by TC.133059
    And I get the partner_id
    And I change root role to FedID role
    #======step8: act as partner======
    Then I act as newly created partner
    #TC.133059 - check adr_policy_name if machine existed
    #======step9: search device and get device id, get device's adr policy name from machine table======
    When I search machine by:
      | machine_name         |
      | ugdf_user1_machine_1 |
    And I view machine details for ugdf_user1_machine_1
    Then I get machine details info
    And ADR policy in DB for device is nil
    And I close machine details section
    And I clear machine search results
    #TC.133061 - check adr_policy_name if machine is a deleted one
    #======step10: search deleted device and get device id, get device's adr policy name from machine table======
    When I search user by:
      | keywords   |
      | ugdf_user2 |
    And I view user details by ugdf_user2
    And I get the user id
    Then ADR policy in DB for deleted device ugdf_user2_machine_1 is nil
    And I clear user search results
    And I close User Details section
    #======step11: stop masquerading from current partner======
    And I stop masquerading
    #TC.133060 - check adr_policy_name if it's new machine=======
    #======step12: search partner======
    When I search partner by TC.133059
    And I view partner details by TC.133059
    And I get the partner_id
    #And I change root role to FedID role
    #======step13: act as partner======
    Then I act as newly created partner
    #======step14: create a new user with backup machine======
    Given I get the partners name TC.133059 and type MozyPro
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user5 | (default user group) | Desktop      |  1            |  1      | Yes          |
    #======step15: search new backup device, get device id and check the adr policy name in db======
    Then I search machine by:
      | machine_name         |
      | ugdf_user5_machine_1 |
    And I view machine details for ugdf_user5_machine_1
    Then I get machine details info
    And ADR policy in DB for device is nil
    And I close machine details section
    And I clear machine search results
    #TC.133062 - check adr_policy_name column when delete machine
    #======step16: search backup machine and delete it======
    When I search machine by:
      | machine_name         |
      | ugdf_user3_machine_1 |
    And I view machine details for ugdf_user3_machine_1
    Then I delete the machine
    #======step17: query adr policy name in db for the deleted machine======
    When I search user by:
      | keywords   |
      | ugdf_user3 |
    And I view user details by ugdf_user3
    And I get the user id
    Then ADR policy in DB for deleted device ugdf_user3_machine_1 is nil
    And I clear user search results
    And I close User Details section
    #TC.133061 - check adr_policy_name column when replace machine
    #=======step18: replace machine======
    When I search machine by:
      | machine_name         |
      | ugdf_user4_machine_1 |
    And I view machine details for ugdf_user4_machine_1
    And I click on the replace machine link
    And I select ugdf_user1_machine_1 to be replaced
    #=======step19: query replace machine in db======
    When I search user by:
      | keywords   |
      | ugdf_user4 |
    And I view user details by ugdf_user4
    And I get the user id
    Then ADR policy in DB for deleted device ugdf_user4_machine_1 is nil
    And I clear user search results
    And I close User Details section
    #======step20: stop masquerading======
    And I stop masquerading
    #======step21: delete partner======
    When I search partner by:
      | name      |
      | TC.133059 |
    Then I view partner details by TC.133059
    And I delete partner account





  @TC.133059smoke @bus @data_retention @bus-2.27 @P1
  Scenario: check machine's adr_policy_name when no adr policy set
    #======step7: search partner and change role to RefID
    When I search partner by TC.133059
    And I view partner details by TC.133059
    And I get the partner_id
    And I change root role to FedID role
    #======step8: act as partner======
    Then I act as newly created partner

    #=======step15: replace machine======
    Given I get the partners name TC.133059 and type MozyPro
    When acting as a MozyPro, I create multiple users and use keyless activation to activate 2 device on each user, meanwhile selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user5 | (default user group) |  Desktop     |  1            |  1      | Yes          |
    #======step12: search new backup device, get device id and check the adr policy name in db======
    When I search machine by:
      | machine_name         |
      | ugdf_user5_machine_1 |
    And I view machine details for ugdf_user5_machine_1
    Then I get machine details info
    And ADR policy in DB for device is nil
    And I close machine details section
    And I clear machine search results
    And I stop masquerading