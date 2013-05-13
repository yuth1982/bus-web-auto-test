Feature: Resource Summary

  As an Mozy administrator
  I want to see my account level available storage and devices
  So that I can quickly a purchasing decision

  Background:
    Given I log in bus admin console as administrator

  @TC.20783
  Scenario: 20783 [Itemized]Available and Used, Used/Total has correct values when 0<used<total
    When I act as partner by:
      | email                                     |
      | test_resource_summary_enterprise@auto.com |
    And I navigate to Resource Summary section from bus admin console page
    Then Itemized storage summary should be:
      | Desktop Used | Desktop Total | Server Used | Server Total | Available | Used  |
      | 30 GB        | 200 GB        | 0           | 100 GB       | 270 GB    | 30 GB |
    And Itemized device summary should be:
      | Desktop Used | Desktop Total | Server Used | Server Total | Available | Used |
      | 1            | 8             | 0           | 200          | 207       | 1    |

  @TC.20787
  Scenario: 20787 [Itemized]Total=Available+Used and Total_Used=sum(storage type) when 0<used<total
    When I act as partner by:
      | email                                     |
      | test_resource_summary_enterprise@auto.com |
    And I navigate to Resource Summary section from bus admin console page
    Then The following equation about storage for Itemized partner is right
      | Available | + | Used | == | Desktop Total | + |Server Total |
    And The following equation about storage for Itemized partner is right
      | Desktop Used | + | Server Used | == | Used |
    And The following equation about device for Itemized partner is right
      | Available | + | Used | == | Desktop Total | + |Server Total |
    And The following equation about device for Itemized partner is right
      | Desktop Used | + | Server Used | == | Used |


  @TC.20803
  Scenario: 20803 [Bundled]Available and Used, Used/Total has correct values when 0<used<total
    When I act as partner by:
      | email                                             |
      | test_resource_summary_bundled@auto.com 	          |
    And I navigate to Resource Summary section from bus admin console page
    Then Bundled storage summary should be:
      | Available | Used  |
      | 70 GB     | 30 GB |