#If you want to run these testcases in other environment other than QA5, You need to prepare these data
#To do: I will add a new feature to prepare these data automately
#(1). Add some partner with the following partner name and admin if not exist
# | partner name                      | admin                                    | usage                               |
# | Machine Migration Automation      | machine_migration_auto@auto.com          | general                             |
# | Machine Migration Add Delete Test | machine_migration_add_delete@auto.com    | add and delete user machine mapping |
# | Fed ID Partner                    | leongh+system@mozy.com                   | 10000 user machine mappings         |
# | Machine Migration for TC16273     | machine_migraion_tc16273@auto.com        | 0 user machine mappings             |
# | Freecom                           | robert.bartelds-at-freecom.com@mozy.test | a partner which has subpartner      |
# | Machine Migration for TC17936     | machine_migraion_tc17936@auto.com        | 2 users have the same machine       |
#(2). Bifrostcli needed for the "Machine Migration Add Delete Test"
#a. Download mozybfstcli from git repo and run 'python setup.py install' to install it
#b. Change /etc/mozybfst.yml according to "Machine Migration Add Delete Test", in QA5, 1 example is like:
#    secret: 5NDOVgE2OpdpZc5IPBEA8ZuQ6t2Ch7094MGoHg8nElxK6geBlpCFSSRxAt028Qa5
#    group_id: 129736

Feature: Machine migration (This is only for QA5 environment, This file will be replaced by machine_mapping.feature)

  As an admin
  I want to migrate machines from current owners to new owners
  So that I can proceed my work to migrate users between mozy and ad authentication

  Background:
    Given I log in bus admin console as administrator

  @TC.16266 @regression @smoke @bus @2.5 @machine_migration
  Scenario: 16266 Export the machine-user mapping csv file
    When I act as partner by:
      | email                           |
      | machine_migration_auto@auto.com |
    And I navigate to the machine mapping page
    When I click the export machine csv button
    Then There should be export message to inform that it is exporting
    And The exported csv file should be like:(header as below, row number is 3, order by current owner, no duplicated rows)
      | column 1      |  column 2                              |  column 3       | column 4  |
      | Machine Name  | Machine Hash                           | Current Owner   | New Owner |
      |WIN-F13I7JF06G5|87f9fa5583e952cf76fe53e1eab0123923dc92e4|new_user@test.com|           |

  @TC.16270 @TC.16271 @bus @2.5 @machine_migration
  Scenario: 16271 Export a CSV file in Synchronized way after adding/deleting one user-machine mapping
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name                   |
      | 12     | 8     | 100 GB      | yes       | Machine Migration Add & Delete |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I navigate to the machine mapping page
    And I download the machine csv file
    And I rename the machine csv file
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.16270.User | (default user group) | Desktop      | 50            | 3       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name  |
      | @user_email | Machine1     | Desktop      | @partner_name |
    And I navigate to the machine mapping page
    When I download the machine csv file
    Then The exported csv file should be 1 rows more than the former one
    And I rename the machine csv file
    # now delete the user machine
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I delete user
    And I navigate to the machine mapping page
    When I download the machine csv file
    Then The exported csv file should be 1 rows less than the former one
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.16272 @bus @2.5 @machine_migration
  Scenario: 16272 Export a CSV file in Synchronized way while the partner has 10000 machines before
    When I act as partner by:
      | email                  |
      | leongh+system@mozy.com |
    And I navigate to the machine mapping page
    When I download the machine csv file
    Then The exported csv file should be like:(header as below, row number is 9793, order by current owner, no duplicated rows)
      | column 1      |  column 2                              |  column 3       | column 4  |
      | Machine Name  | Machine Hash                           | Current Owner   | New Owner |
      |WIN-F13I7JF06G5|87f9fa5583e952cf76fe53e1eab0123923dc92e4|new_user@test.com|           |

  @TC.16273 @bus @2.5 @machine_migration
  Scenario: 16273 Export a CSV file in Synchronized way while the partner has no Mozy users before
    When I act as partner by:
      | name                          |
      | Machine Migration for TC16273 |
    And I navigate to the machine mapping page
    When I download the machine csv file
    Then The exported csv file should be:
      | column 1      |  column 2                              |  column 3       | column 4  |
      | Machine Name  | Machine Hash                           | Current Owner   | New Owner |

  @TC.16275 @positive @regression @smoke @bus @2.5 @machine_migration
  Scenario: 16275 Import a valid CSV file in non-passive way
    When I act as partner by:
      | email                           |
      | machine_migration_auto@auto.com |
    And I navigate to the machine mapping page
    And I download the machine csv file
    And I change the csv file by adding new owners to the machines
    When I upload the machine csv file
    Then There should be import message to inform that it is importing
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   |
      |Import Results:| 3 rows imported |3 machines moved to new users | 0 machines skipped (no new user specified) |

  @TC.16279 @bus @2.5 @machine_migration
  Scenario: 16279 Import a CSV file whose type is not CSV in non-passive way
    When I act as partner by:
      | email                           |
      | machine_migration_auto@auto.com |
    And I navigate to the machine mapping page
    When I upload the non-csv file
    Then The import result should be like:
      | column 1      |  column 2        |  column 3                    | column 4                                   | column 5  |   column 6                                                 |
      |Import Results:| -1 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 1 Errors: |   Invalid file. The uploaded file was an invalid CSV file. |

  @TC.16280 @TC.16281 @TC.16282 @bus @2.5 @machine_migration
  Scenario Outline: 16280 16281 16282 Import a CSV file with a column absent
    When I act as partner by:
      | email                           |
      | machine_migration_auto@auto.com |
    And I navigate to the machine mapping page
    And I download the machine csv file
    And I make the <column> absent
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   | column 5  | column 6                                                                                         |
      |Import Results:| 3 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 3 Errors: | Row 2 - Invalid record - one or more of machine name, machine hash, and current owner are blank. |

  Examples:
    | column        |
    | Machine Name  |
    | Machine Hash  |
    | Current Owner |

  @TC.16283 @bus @2.5 @machine_migration
  Scenario: 16283 Import a CSV file with a column absent (new owner)
    When I act as partner by:
      | email                           |
      | machine_migration_auto@auto.com |
    And I navigate to the machine mapping page
    And I download the machine csv file
    And I make the New Owner absent
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   |
      |Import Results:| 3 rows imported |0 machines moved to new users | 3 machines skipped (no new user specified) |

  @TC.16284 @TC.16285 @bus @2.5 @machine_migration
  Scenario Outline: 16284 16285 Import a CSV file whose one column has unknown value
    When I act as partner by:
      | email                           |
      | machine_migration_auto@auto.com |
    And I navigate to the machine mapping page
    And I download the machine csv file
    And I make the <column> an unknown value
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   | column 5  | column 6        |
      |Import Results:| 3 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 3 Errors: | Unknown machine |

  Examples:
    | column        |
    | Machine Name  |
    | Machine Hash  |

  @TC.16286 @bug @2.5 @machine_migration
  Scenario: 16286 Import a CSV file whose one column has unknown value (current Owner)
    When I act as partner by:
      | email                           |
      | machine_migration_auto@auto.com |
    And I navigate to the machine mapping page
    And I download the machine csv file
    And I make the Current Owner an unknown value
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   | column 5  | column 6             |
      |Import Results:| 3 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 3 Errors: | does not own machine |

  @TC.16287 @bug @2.5 @machine_migration
  Scenario: 16287 Import a CSV file whose one column has unknown value (New Owner)
    When I act as partner by:
      | email                           |
      | machine_migration_auto@auto.com |
    And I navigate to the machine mapping page
    And I download the machine csv file
    And I make the New Owner an unknown value
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   | column 5  | column 6          |
      |Import Results:| 3 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 3 Errors: | Unknown new owner |

  @TC.16288 @bug @2.5 @machine_migration
  Scenario: 16288 Import a CSV file with current owners invalid format
    When I act as partner by:
      | email                           |
      | machine_migration_auto@auto.com |
    And I navigate to the machine mapping page
    And I download the machine csv file
    And I make the Current Owner an invalid value
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   | column 5  | column 6             |
      |Import Results:| 3 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 3 Errors: | does not own machine |

  @TC.16289 @bug @2.5 @machine_migration
  Scenario: 16289 Import a CSV file with new owners invalid format
    When I act as partner by:
      | email                           |
      | machine_migration_auto@auto.com |
    And I navigate to the machine mapping page
    And I download the machine csv file
    And I make the New Owner an invalid value
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   | column 5  | column 6          |
      |Import Results:| 3 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 3 Errors: | Unknown new owner |

  @TC.16290 @bug @2.5 @machine_migration
  Scenario: 16290 Import a CSV file with mismatched machine name and machine hash
    When I act as partner by:
      | email                           |
      | machine_migration_auto@auto.com |
    And I navigate to the machine mapping page
    And I download the machine csv file
    And I make a column with mismatched machine name and machine hash
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   | column 5  | column 6        |
      |Import Results:| 3 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 3 Errors: | Unknown machine |

  @TC.16291 @bug @2.5 @machine_migration
  Scenario: 16291 Import a CSV file with new owner an empty string in non-passive way
    When I act as partner by:
      | email                           |
      | machine_migration_auto@auto.com |
    And I navigate to the machine mapping page
    And I download the machine csv file
    And I make the new owner column with a space
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   |
      |Import Results:| 3 rows imported |0 machines moved to new users | 3 machines skipped (no new user specified) |

  @TC.16343 @bug @2.5 @machine_migration
  Scenario: 16343 Export a CSV file when the partner has subpartners
    When I act as partner by:
      | email                                    |
      | robert.bartelds-at-freecom.com@mozy.test |
    And I navigate to the machine mapping page
    When I download the machine csv file
    And The exported csv file should be:
      | column 1      | column 2                                 | column 3                                 | column 4  |
      | Machine Name  | Machine Hash                             | Current Owner                            | New Owner |
      | SUPPORT-PC    | c58d8af103f37ffa82351ef500115b4b2e32     | hussin.diraki-at-freecom.com@mozy.test   |           |
      | R620          | 7a712089bc55ff31aa22efe9fb417083aa795138 | ingmar.heinecke-at-freecom.com@mozy.test |           |
      | FREECOM-TEST  | 323e04be11da0abb2b3be5070010c617bb3e     | rbartelds-at-gmail.com@mozy.test         |           |
      | BLN039        | 351eeb340475694284f7a08218c9474f474afb70 | robert.bartelds-at-freecom.com@mozy.test |           |

  @TC.17936 @bug @2.2 @machine_migration
  Scenario: 17936 Import a CSV file while two users have same machine
    When I act as partner by:
      | email                            |
      | machine_migraion_tc17936@auto.com |
    And I navigate to the machine mapping page
    And I download the machine csv file
    And I change the csv file by moving the machines to new users
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   |
      |Import Results:| 2 rows imported |2 machines moved to new users | 0 machines skipped (no new user specified) |

  @TC.16276 @slow @bug @2.5 @machine_migration
  Scenario: 16276 Import a CSV file in no passive way while the partner has 10000 machines before
    When I act as partner by:
      | email                  |
      | leongh+system@mozy.com |
    And I navigate to the machine mapping page
    And I download the machine csv file
    And I change the csv file by adding new owners to the machines for 9793 machines
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2          |  column 3                       | column 4                                   |
      |Import Results:| 9793 rows imported |9793 machines moved to new users | 0 machines skipped (no new user specified) |

