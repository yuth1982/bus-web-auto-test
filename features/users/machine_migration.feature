Feature: Machine migration (This is only for QA5 environment, This file will be replaced by machine_mapping.feature)

  As an admin
  I want to migrate machines from current owners to new owners
  So that I can proceed my work to migrate users between mozy and ad authentication

  Background:
    Given I log in bus admin console as administrator

  @TC.16266 @regression @smoke
  Scenario: Export the machine-user mapping csv file
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

  @TC.16270
  Scenario: Export a CSV file in Synchronized way after deleting one user-machine mapping
    When I act as partner by:
      | email                                 |
      | machine_migration_add_delete@auto.com |
    And I navigate to the machine mapping page
    And I download the machine csv file
    And I refresh the machine mapping page
    And I rename the machine csv file
    And I delete a new user and machine mapping
    When I download the machine csv file
    Then The exported csv file should be 1 rows less than the former one

  @TC.16271
  Scenario: Export a CSV file in Synchronized way after adding one user-machine mapping
    When I act as partner by:
      | email                                 |
      | machine_migration_add_delete@auto.com |
    And I navigate to the machine mapping page
    And I download the machine csv file
    And I refresh the machine mapping page
    And I rename the machine csv file
    And I add a new user and machine mapping
    When I download the machine csv file
    Then The exported csv file should be 1 rows more than the former one

  @TC.16272
  Scenario: Export a CSV file in Synchronized way while the partner has 10000 machines before
    When I act as partner by:
      | email                  |
      | leongh+system@mozy.com |
    And I navigate to the machine mapping page
    When I download the machine csv file
    Then The exported csv file should be like:(header as below, row number is 9793, order by current owner, no duplicated rows)
      | column 1      |  column 2                              |  column 3       | column 4  |
      | Machine Name  | Machine Hash                           | Current Owner   | New Owner |
      |WIN-F13I7JF06G5|87f9fa5583e952cf76fe53e1eab0123923dc92e4|new_user@test.com|           |

  @TC.16273
  Scenario: Export a CSV file in Synchronized way while the partner has no Mozy users before
    When I act as partner by:
      | name                          |
      | Machine Migration for TC16273 |
    And I navigate to the machine mapping page
    When I download the machine csv file
    Then The exported csv file should be:
      | column 1      |  column 2                              |  column 3       | column 4  |
      | Machine Name  | Machine Hash                           | Current Owner   | New Owner |

  @TC.16275 @positive @regression @smoke
  Scenario: Import a valid CSV file in non-passive way
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

  @TC.16279
  Scenario: Import a CSV file whose type is not CSV in non-passive way
    When I act as partner by:
      | email                           |
      | machine_migration_auto@auto.com |
    And I navigate to the machine mapping page
    When I upload the non-csv file
    Then The import result should be like:
      | column 1      |  column 2        |  column 3                    | column 4                                   | column 5  |   column 6                                                 |
      |Import Results:| -1 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 1 Errors: |   Invalid file. The uploaded file was an invalid CSV file. |

  @TC.16280 @TC.16281 @TC.16282
  Scenario Outline: Import a CSV file with a column absent
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

  @TC.16283
  Scenario: Import a CSV file with a column absent (new owner)
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

  @TC.16284 @TC.16285
  Scenario Outline: Import a CSV file whose one column has unknown value
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

  @TC.16286
  Scenario: Import a CSV file whose one column has unknown value (current Owner)
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

  @TC.16287
  Scenario: Import a CSV file whose one column has unknown value (New Owner)
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

  @TC.16288
  Scenario: Import a CSV file with current owners invalid format
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

  @TC.16289
  Scenario: Import a CSV file with new owners invalid format
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

  @TC.16290
  Scenario: Import a CSV file with mismatched machine name and machine hash
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

  @TC.16291
  Scenario: Import a CSV file with new owner an empty string in non-passive way
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

  @TC.16343
  Scenario: Export a CSV file when the partner has subpartners
    When I act as partner by:
      | name    |
      | Freecom |
    And I navigate to the machine mapping page
    When I download the machine csv file
    And The exported csv file should be:
      | column 1      |  column 2                              |  column 3                              | column 4  |
      | Machine Name  | Machine Hash                           | Current Owner                          | New Owner |
      |SUPPORT-PC     |c58d8af103f37ffa82351ef500115b4b2e32    |hussin.diraki-at-freecom.com@mozy.test  |           |
      |R620           |7a712089bc55ff31aa22efe9fb417083aa795138|ingmar.heinecke-at-freecom.com@mozy.test|           |
      |FREECOM-TEST   |323e04be11da0abb2b3be5070010c617bb3e    |rbartelds-at-gmail.com@mozy.test        |           |
      |BLN039         |351eeb340475694284f7a08218c9474f474afb70|robert.bartelds-at-freecom.com@mozy.test|           |

  @TC.17936
  Scenario: Import a CSV file while two users have same machine
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

  @TC.16276 @slow
  Scenario: Import a CSV file in no passive way while the partner has 10000 machines before
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

