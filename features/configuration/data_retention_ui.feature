Feature: Adjustable retention at the partner and user group level

  As a Mozy Administrator. I have the ability to enable/disable the data retention capability to different Roles.

  Background:
    Given I log in bus admin console as administrator

  @TC.132819 @bus @data_retention @bus-2.27 @P1
  Scenario: As a mozyPro admin, click Data Retention, go to Data Retention section, check default info here. create data retention for partner with subpartner.
    #======1 test cases======
    When I add a new MozyPro partner:
      | period |  base plan | server plan | net terms |
      |   1    |  100 GB    | yes         | yes       |
    And I change root role to FedID role
    And I get the partner_id
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) |  Server      |  1            |  1      |
    Then 1 new user should be created
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Perisods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole    | yearly | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name      |
      | adr_sub_partner_1 |
    Then New partner should be created
    Then Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned |
      | 0    | 0         | 0        | 0    | Unlimited | Unlimited|
    Then the pooled resource section of subpartner should have edit link
    When I navigate to Data Retention section from bus admin console page
    Then partner adr policy should be None
    And user group adr policy should be:
      | Name                 | Policy |
      | (default user group) | None   |
    And sub partner adr policy should be:
      | Name              | Policy |
      | adr_sub_partner_1 | None   |


  @TC.132820-132831 @bus @data_retention @bus-2.27 @P1
  Scenario: Admin creates ADR policy on user group.
  #======9 test cases======
  #======two groups, set policy to (default user group) on main page, set policy to group1 on popup======
  #======create a MozyPro partner======
    When I add a new MozyPro partner:
      | period |  base plan | server plan | net terms |
      |   1    |  50 GB    | yes         | yes       |
    And I change root role to FedID role
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add a new Bundled user group:
      | name          | storage_type | install_region_override | enable_stash | server_support |
      | qa-test-group | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I navigate to Data Retention section from bus admin console page
    Then partner adr policy should be None
    And user group adr policy should be:
      | Name                 | Policy |
      | (default user group) | None   |
      | qa-test-group        | None   |
    When I click user group (default user group) adr policy
    Then available adr policy names should be:
      | policy              |
      | 7 Days              |
      | 14 Days             |
      | 1 Month (daily)     |
      | 2 Months (weekly)   |
      | 3 Months (weekly)   |
      | 6 Months (monthly)  |
      | 1 Year (monthly)    |
      | 2 Years (quarterly) |
      | 3 Years (quarterly) |
      | 4 Years (quarterly) |
      | 5 Years (quarterly) |
      | 6 Years (quarterly) |
      | 7 Years (quarterly) |
    #TC.132820 - create a policy but clicking Cancel button
    When I set adr policy 1 Month (daily) but click cancel
    Then user group adr policy should be:
      | Name                 | Policy |
      | (default user group) | None   |
      | qa-test-group        | None   |
    #TC.132821 - input invalid password when creating new ADR policy, error message returned.
    When I click user group (default user group) adr policy
    And I try to set adr policy to 1 Month (daily) but input invalid password h@llo0WOrld
    Then user group adr policy should be:
      | Name                 | Policy |
      | (default user group) | None   |
      | qa-test-group        | None   |
    #TC.132822 - create ADR policy for (default user group)and verify the result on both UI and on db.
    And ADR policy in DB for user group (default user group) is nil
    And I close opened data retention section
    When I click user group (default user group) adr policy
    And I set adr policy to 3 Months (weekly)
    Then Change ADR Policy section message should be Update data retention policy successfully.
    When I refresh Data Retention section
    Then user group adr policy should be:
      | Name                 | Policy             |
      | (default user group) | 3 Months (weekly)  |
      | qa-test-group        | None               |
    #TC.132823/132829 - Click on user group policy and select policy, click <Cancel> button to cancel the creation.
    When I click user group qa-test-group adr policy
    And I click button to invoke adr popup dialog
    And I navigate to new window
    And default adr policy name on popup dialog should be 7 Days
    And I select adr policy on popup dialog to 3 Months (weekly) but click cancel button
    And I close new window
    Then I refresh Data Retention section
    And user group adr policy should be:
      | Name                 | Policy             |
      | (default user group) | 3 Months (weekly)  |
      | qa-test-group        | None               |
    #TC.`132830 - create policy from the Data Retention popup dialog, input invalid password
    When I click user group qa-test-group adr policy
    And I click button to invoke adr popup dialog
    And I navigate to new window
    And I select adr policy on popup dialog to 1 Month (daily) but input invalid password h@llo0WOrld
    And I close new window
    Then I refresh Data Retention section
    And user group adr policy should be:
      | Name                 | Policy             |
      | (default user group) | 3 Months (weekly)  |
      | qa-test-group        | None               |
    #TC132831 - create policy from the Data Retention popup dialog, input correct password
    When I click user group qa-test-group adr policy
    And I click button to invoke adr popup dialog
    And I navigate to new window
    And I set adr policy on popup dialog to 1 Month (daily)
    And I close new window
    Then I refresh Data Retention section
    And user group adr policy should be:
      | Name                 | Policy             |
      | (default user group) | 3 Months (weekly)  |
      | qa-test-group        | 1 Month (daily)    |


  @TC.132841-132849 @bus @data_retention @bus-2.27 @P1
  Scenario: Admin creates ADR policy on user group
  #======two groups, set policy to group1 on main page, set policy to (default user group) on popup======
  #======create a MozyPro partner======
    When I add a new MozyPro partner:
      | period |  base plan | server plan | net terms |
      |   1    |  50 GB    | yes         | yes       |
    And I change root role to FedID role
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add a new Bundled user group:
      | name          | storage_type | install_region_override | enable_stash | server_support |
      | qa-test-group | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I navigate to Data Retention section from bus admin console page
    Then partner adr policy should be None
    And user group adr policy should be:
      | Name                 | Policy |
      | (default user group) | None   |
      | qa-test-group        | None   |
    When I click user group (default user group) adr policy
    Then available adr policy names should be:
      | policy              |
      | 7 Days              |
      | 14 Days             |
      | 1 Month (daily)     |
      | 2 Months (weekly)   |
      | 3 Months (weekly)   |
      | 6 Months (monthly)  |
      | 1 Year (monthly)    |
      | 2 Years (quarterly) |
      | 3 Years (quarterly) |
      | 4 Years (quarterly) |
      | 5 Years (quarterly) |
      | 6 Years (quarterly) |
      | 7 Years (quarterly) |
   #TC.132842 - create a policy but clicking Cancel button
    When I set adr policy 1 Month (daily) but click cancel
    Then user group adr policy should be:
      | Name                 | Policy |
      | (default user group) | None   |
      | qa-test-group        | None   |
    And I close opened data retention section
   #TC.132843 - input invalid password when creating new ADR policy, error message returned.
    When I click user group qa-test-group adr policy
    And I try to set adr policy to 1 Month (daily) but input invalid password h@llo0WOrld
    Then user group adr policy should be:
      | Name                 | Policy |
      | (default user group) | None   |
      | qa-test-group        | None   |
   #TC.132844 - create ADR policy for (default user group)and verify the result on both UI and on db.
    And ADR policy in DB for user group qa-test-group is nil
    And I close opened data retention section
    When I click user group qa-test-group adr policy
    And I set adr policy to 3 Months (weekly)
    Then Change ADR Policy section message should be Update data retention policy successfully.
    When I refresh Data Retention section
    Then user group adr policy should be:
      | Name                 | Policy             |
      | (default user group) | None               |
      | qa-test-group        | 3 Months (weekly)  |
   #TC.132846/132847 - Click on user group policy and select policy, click <Cancel> button to cancel the creation.
    When I click user group (default user group) adr policy
    And I click button to invoke adr popup dialog
    And I navigate to new window
    And default adr policy name on popup dialog should be 7 Days
    And I select adr policy on popup dialog to 3 Months (weekly) but click cancel button
    And I close new window
    Then I refresh Data Retention section
    And user group adr policy should be:
      | Name                 | Policy             |
      | (default user group) | None               |
      | qa-test-group        | 3 Months (weekly)  |
    #TC.132848 - create policy from the Data Retention popup dialog, input invalid password
    When I click user group (default user group) adr policy
    And I click button to invoke adr popup dialog
    And I navigate to new window
    And I select adr policy on popup dialog to 1 Month (daily) but input invalid password h@llo0WOrld
    And I close new window
    Then I refresh Data Retention section
    And user group adr policy should be:
      | Name                 | Policy             |
      | (default user group) | None               |
      | qa-test-group        | 3 Months (weekly)  |
    #TC.132849 - create policy from the Data Retention popup dialog, input correct password
    When I click user group (default user group) adr policy
    And I click button to invoke adr popup dialog
    And I navigate to new window
    And I set adr policy on popup dialog to 1 Month (daily)
    And I close new window
    Then I refresh Data Retention section
    And user group adr policy should be:
      | Name                 | Policy             |
      | (default user group) | 1 Month (daily)    |
      | qa-test-group        | 3 Months (weekly)  |


  @TC.132859-132867 @bus @data_retention @bus-2.27 @P1
  Scenario: change adr policy for antother user group with an existing ADR policy
  #======9 test cases======
  #======three groups, all have adr policy set======
  #======create a MozyPro partner======
    When I add a new MozyPro partner:
      | period |  base plan | server plan | net terms |
      |   1    |  50 GB    | yes         | yes       |
    And I change root role to FedID role
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add a new Bundled user group:
      | name           | storage_type | install_region_override | enable_stash | server_support |
      | qa-test-group1 | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    And I add a new Bundled user group:
      | name           | storage_type | install_region_override | enable_stash | server_support |
      | qa-test-group2 | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I navigate to Data Retention section from bus admin console page
    Then partner adr policy should be None
    And user group adr policy should be:
      | Name                 | Policy |
      | (default user group) | None   |
      | qa-test-group1       | None   |
      | qa-test-group2       | None   |
    When I click user group (default user group) adr policy
    Then available adr policy names should be:
      | policy              |
      | 7 Days              |
      | 14 Days             |
      | 1 Month (daily)     |
      | 2 Months (weekly)   |
      | 3 Months (weekly)   |
      | 6 Months (monthly)  |
      | 1 Year (monthly)    |
      | 2 Years (quarterly) |
      | 3 Years (quarterly) |
      | 4 Years (quarterly) |
      | 5 Years (quarterly) |
      | 6 Years (quarterly) |
      | 7 Years (quarterly) |
  #======create policy on three user groups======
  #======(default user group) adr policy = 1 Month (daily)======
    When I click user group (default user group) adr policy
    And I set adr policy to 1 Month (daily)
    Then Change ADR Policy section message should be Update data retention policy successfully.
    And I close opened data retention section
  #======qa-test-group1 adr policy = 3 Months (weekly)======
    When I click user group qa-test-group1 adr policy
    And I set adr policy to 3 Months (weekly)
    Then Change ADR Policy section message should be Update data retention policy successfully.
    And I close opened data retention section
  #======qa-test-group2 adr policy = 6 Months (monthly)======
    When I click user group qa-test-group2 adr policy
    And I set adr policy to 6 Months (monthly)
    Then Change ADR Policy section message should be Update data retention policy successfully.
    And I close opened data retention section
    Then user group adr policy should be:
      | Name                 | Policy            |
      | (default user group) | 1 Month (daily)   |
      | qa-test-group1       | 3 Months (weekly) |
      | qa-test-group2       | 6 Months (monthly)|
  #TC.132860 - create a policy on qa-test-troup1 but clicking Cancel button
    Given I click user group qa-test-group1 adr policy
    When I set adr policy 1 Year (monthly) but click cancel
    Then user group adr policy should be:
      | Name                 | Policy            |
      | (default user group) | 1 Month (daily)   |
      | qa-test-group1       | 3 Months (weekly) |
      | qa-test-group2       | 6 Months (monthly)|
    And I close opened data retention section
  #TC.132861 - input invalid password when creating new ADR policy, error message returned.
    When I click user group qa-test-group1 adr policy
    And I try to set adr policy to 1 Year (monthly) but input invalid password h@llo0WOrld
    Then user group adr policy should be:
      | Name                 | Policy            |
      | (default user group) | 1 Month (daily)   |
      | qa-test-group1       | 3 Months (weekly) |
      | qa-test-group2       | 6 Months (monthly)|
    And I close opened data retention section
  #TC132862 - create ADR policy for qa-test-group1 and verify the result on both UI and on db.
    Given ADR policy in DB for user group qa-test-group1 is Mozy3Month_weekly
    When I click user group qa-test-group1 adr policy
    And I set adr policy to 1 Year (monthly)
    Then Change ADR Policy section message should be Update data retention policy successfully.
    When I refresh Data Retention section
    Then user group adr policy should be:
      | Name                 | Policy            |
      | (default user group) | 1 Month (daily)   |
      | qa-test-group1       | 1 Year (monthly)  |
      | qa-test-group2       | 6 Months (monthly)|
    And I close opened data retention section
   #TC.132864/132865 - Click on user group policy and select policy, click <Cancel> button to cancel the creation.
    Given ADR policy in DB for user group qa-test-group2 is Mozy6Month_monthly
    When I click user group qa-test-group2 adr policy
    And I click button to invoke adr popup dialog
    And I navigate to new window
    And I select adr policy on popup dialog to 3 Years (quarterly) but click cancel button
    And I close new window
    Then I refresh Data Retention section
    And user group adr policy should be:
      | Name                 | Policy            |
      | (default user group) | 1 Month (daily)   |
      | qa-test-group1       | 1 Year (monthly)  |
      | qa-test-group2       | 6 Months (monthly)|
    #TC132866 - create policy from the Data Retention popup dialog, input incorrect password
    When I click user group qa-test-group2 adr policy
    And I click button to invoke adr popup dialog
    And I navigate to new window
    And I select adr policy on popup dialog to 3 Years (quarterly) but input invalid password h@llo0WOrld
    And I close new window
    Then I refresh Data Retention section
    And user group adr policy should be:
      | Name                 | Policy            |
      | (default user group) | 1 Month (daily)   |
      | qa-test-group1       | 1 Year (monthly)  |
      | qa-test-group2       | 6 Months (monthly)|
    #TC.132867 - create policy from the Data Retention popup dialog, input correct password
    When I click user group qa-test-group2 adr policy
    And I click button to invoke adr popup dialog
    And I navigate to new window
    And I set adr policy on popup dialog to 3 Years (quarterly)
    And I close new window
    Then I refresh Data Retention section
    And user group adr policy should be:
      | Name                 | Policy             |
      | (default user group) | 1 Month (daily)    |
      | qa-test-group1       | 1 Year (monthly)   |
      | qa-test-group2       | 3 Years (quarterly)|


  @TC.133015-133020 @bus @data_retention @bus-2.27 @P1
  Scenario: create and update ADR policy for partner
    #======6 test cases======
    #======create a MozyPro partner======
    When I add a new MozyPro partner:
      | period |  base plan | server plan | net terms |
      |   1    |  50 GB    | yes         | yes       |
    And I change root role to FedID role
    And I get the admin id from partner details
    When I act as newly created partner account
  #TC.133015 - Act as parnter, create adr policy on partner buc clicking cancel======
    When I navigate to Data Retention section from bus admin console page
    Then partner adr policy should be None
    When I click partner adr policy
    And I set adr policy 7 Days but click cancel
    Then I refresh Data Retention section
    And partner adr policy should be None
    And I close opened data retention section
  #TC.133016 - create ADR policy on partner with incorrect password======
    When I click partner adr policy
    And partner adr policy should be None
    And I try to set adr policy to 7 Days but input invalid password h@llo0WOrld
    Then I refresh Data Retention section
    And partner adr policy should be None
    And I close opened data retention section
  #TC.133017 - create ADR policy on partner with correct password======
    When I click partner adr policy
    And partner adr policy should be None
    And I set adr policy to 7 Days
    Then I refresh Data Retention section
    And partner adr policy should be 7 Days
    And I close opened data retention section
  #TC.133018 - update ADR policy on parnter but click Cancel======
    When I click partner adr policy
    And partner adr policy should be 7 Days
    And I set adr policy 14 Days but click cancel
    Then I refresh Data Retention section
    And partner adr policy should be 7 Days
    And I close opened data retention section
  #TC.133019 -  update ADR policy on partner but with incorrect passwrod======
    When I click partner adr policy
    And partner adr policy should be 7 Days
    And I try to set adr policy to 14 Days but input invalid password h@llo0WOrld
    Then I refresh Data Retention section
    And partner adr policy should be 7 Days
    And I close opened data retention section
  #TC.133020 -  update ADR policy on partner with correct passwrod======
    When I click partner adr policy
    And partner adr policy should be 7 Days
    And I set adr policy to 14 Days
    Then I refresh Data Retention section
    And partner adr policy should be 14 Days
    And I close opened data retention section


  @TC.132883-132884 @bus @data_retention @bus-2.27 @P1
  Scenario: search sub-partner for partner
    #======2 test cases======
    #======create a MozyPro partner======
    When I add a new MozyPro partner:
      | period |  base plan | server plan | net terms |
      |   1    |  100 GB    | yes         | yes       |
    And I change root role to FedID role
    And I get the partner_id
    And I get the admin id from partner details
    #======act as the newly created partner, create subplan and subrole======
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) |  Server      |  1            |  1      |
    Then 1 new user should be created
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Perisods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly   | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    #======create a new sub partner======
    When I add a new sub partner:
      | Company Name       |
      | sub_partner_132883 |
    Then New partner should be created
    #TC.132883 - Search the sub partner with keyword "partner_132883"======
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by:
      | name               |
      | sub_partner_132883 |
    Then I view partner details by sub_partner_132883
    #TC.132884 - Search the sub partner with keyword "partner_132883_invalid"======
    Given I clear partner search results
    When I search partner by:
      | name                   |
      | partner_132883_invalid |
    Then Partner search results should be empty
    Then I stop masquerading
    #======repeart #TC.132883 and #TC.132884 at root partner level======
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by:
      | name                   |
      | partner_132883_invalid |
    Then Partner search results should be empty
    Given I clear partner search results
    And I search partner by:
      | name               |
      | sub_partner_132883 |
    Then I view partner details by sub_partner_132883
    #======Delete the subpartner======
    And I delete partner account


  @TC.132997-132999 @TC.133024-026 @133030-133032 @bus @data_retention @bus-2.27 @P1
  Scenario: search sub-partner for partner
    #======9 test cases======
    #======create a MozyPro partner======
    When I add a new MozyPro partner:
      | period |  base plan | server plan | net terms |
      |   1    |  100 GB    | yes         | yes       |
    And I change root role to FedID role
    And I get the partner_id
    And I get the admin id from partner details
    #======act as the newly created partner, create subplan and subrole======
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) |  Server      |  1            |  1      |
    Then 1 new user should be created
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Perisods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly   | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    #======create a new sub partner======
    When I add a new sub partner:
      | Company Name       |
      | sub_partner_132997 |
    Then New partner should be created
    #======TC.132997 - TC.132999, create ADR policy for sub partner======
    #TC.132997 - cancel create ADR policy for sub partner======
    Given I navigate to Data Retention section from bus admin console page
    When I click sub partner sub_partner_132997 adr policy
    And I set adr policy 2 Years (quarterly) but click cancel
    Then I refresh Data Retention section
    And sub partner adr policy should be:
      | sub parnter name   | policy |
      | sub_partner_132997 | None   |
    And I close opened data retention section
    #TC.132998 - create ADR policy with wrong password======
    When I click sub partner sub_partner_132997 adr policy
    And I try to set adr policy to 2 Years (quarterly) but input invalid password h@llo0WOrld
    Then I refresh Data Retention section
    And sub partner adr policy should be:
      | sub parnter name   | policy |
      | sub_partner_132997 | None   |
    And I close opened data retention section
    #TC.132999 - create ADR policy with correct password======
    When I click sub partner sub_partner_132997 adr policy
    And I set adr policy to 2 Years (quarterly)
    Then I refresh Data Retention section
    And sub partner adr policy should be:
      | sub parnter name   | policy               |
      | sub_partner_132997 | 2 Years (quarterly)  |
    And I close opened data retention section
    #======TC.133024 - TC.133026, update ADR policy for sub partner======
    #TC.133024 - cancel update ADR policy for sub partner======
    When I click sub partner sub_partner_132997 adr policy
    And I set adr policy 4 Years (quarterly) but click cancel
    Then I refresh Data Retention section
    And sub partner adr policy should be:
      | sub parnter name   | policy               |
      | sub_partner_132997 | 2 Years (quarterly)  |
    And I close opened data retention section
    #TC.133025 - update ADR policy with wrong password======
    When I click sub partner sub_partner_132997 adr policy
    And I try to set adr policy to 4 Years (quarterly) but input invalid password h@llo0WOrld
    Then I refresh Data Retention section
    And sub partner adr policy should be:
      | sub parnter name   | policy               |
      | sub_partner_132997 | 2 Years (quarterly)  |
    And I close opened data retention section
    #TC.133026 - update ADR policy with correct password======
    When I click sub partner sub_partner_132997 adr policy
    And I set adr policy to 4 Years (quarterly)
    Then I refresh Data Retention section
    And sub partner adr policy should be:
      | sub parnter name   | policy               |
      | sub_partner_132997 | 4 Years (quarterly)  |
    And I close opened data retention section
   #======TC.133030 - TC.133032, update ADR policy for sub partner======
   #TC.133030 - cancel create adr policy from parent partner======
    When I click partner adr policy
    And I set adr policy 5 Years (quarterly) but click cancel
    And I refresh Data Retention section
    Then partner adr policy should be None
    And sub partner adr policy should be:
      | sub parnter name   | policy               |
      | sub_partner_132997 | 4 Years (quarterly)  |
    And I close opened data retention section
    #TC.133031 - create ADR policy from parent partner with incorrect password======
    When I click partner adr policy
    And I try to set adr policy to 5 Years (quarterly) but input invalid password h@llo0WOrld
    And I refresh Data Retention section
    Then partner adr policy should be None
    And sub partner adr policy should be:
      | sub parnter name   | policy               |
      | sub_partner_132997 | 4 Years (quarterly)  |
    And I close opened data retention section
    #TC.133032 - create ADR policy from parent partner with correct password======
    When I click partner adr policy
    And I set adr policy to 5 Years (quarterly)
    And I refresh Data Retention section
    Then partner adr policy should be 5 Years (quarterly)
    And sub partner adr policy should be:
      | sub parnter name   | policy               |
      | sub_partner_132997 | 4 Years (quarterly)  |
    And I close opened data retention section
    And I stop masquerading
    #======Delete the sub partner======
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by:
      | name               |
      | sub_partner_132997 |
    Then I view partner details by sub_partner_132997
    And I delete partner account


  @TC.133012-133014 @TC.133036-133038 @TC.133033-133035 @bus @data_retention @bus-2.27 @P1
  Scenario: create ADR policy for a layer 2 sub partner
    #======9 test cases======
    #======TC.133012-014, TC.133036-038, TC.133033-035======
    When I add a new MozyPro partner:
      | name     | period |  base plan | server plan | net terms |
      | TC133012 |   1    |  100 GB    | yes         | yes       |
    And I change root role to FedID role
    And I get the partner_id
    And I get the admin id from partner details
    #======act as the newly created partner, create subplan and subrole/layer 1======
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Perisods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly   | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    #======create a new sub partner/level 1======
    When I add a new sub partner:
      | Company Name              |
      | sub_partner_133012_level1 |
    Then New partner should be created
    But I stop masquerading
    #======act as the newly created sub partner, create subplan and subrole/layer 2======
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by:
      | name                      |
      | sub_partner_133012_level1 |
    Then I view partner details by sub_partner_133012_level1
    And I act as newly created partner
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name        | Type          | Parent  |
      | subrole2    | Partner admin | subrole |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role  | Perisods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole2   | yearly   | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    #======create a new sub partner/level 1======
    When I add a new sub partner:
      | Company Name              |
      | sub_partner_133012_level2 |
    Then New partner should be created
    #======TC.133012-014, create adr policy for a layer 2 sub partner======
    #TC.133012 - cancel create ADR policy at layer2 sub partner
    Given I navigate to Data Retention section from bus admin console page
    When I click sub partner sub_partner_133012_level2 adr policy
    And I set adr policy 6 Years (quarterly) but click cancel
    Then I refresh Data Retention section
    And sub partner adr policy should be:
      | sub parnter name          | policy |
      | sub_partner_133012_level2 | None   |
    And I close opened data retention section
    #TC.133013 - create ADR policy with wrong password======
    When I click sub partner sub_partner_133012_level2 adr policy
    And I try to set adr policy to 6 Years (quarterly) but input invalid password h@llo0WOrld
    Then I refresh Data Retention section
    And sub partner adr policy should be:
      | sub parnter name          | policy |
      | sub_partner_133012_level2 | None   |
    And I close opened data retention section
    #TC.132999 - create ADR policy with correct password======
    When I click sub partner sub_partner_133012_level2 adr policy
    And I set adr policy to 6 Years (quarterly)
    Then I refresh Data Retention section
    And sub partner adr policy should be:
      | sub parnter name          | policy               |
      | sub_partner_133012_level2 | 6 Years (quarterly)  |
    And I close opened data retention section
    #======TC.133036-038, update existing adr policy for a layer 2 sub partner======
    #TC.1330136 - cancel create ADR policy at layer2 sub partner
    When I click sub partner sub_partner_133012_level2 adr policy
    And I set adr policy 7 Years (quarterly) but click cancel
    Then I refresh Data Retention section
    And sub partner adr policy should be:
      | sub parnter name          | policy               |
      | sub_partner_133012_level2 | 6 Years (quarterly)  |
    And I close opened data retention section
    #TC.133037 - update ADR policy with wrong password======
    When I click sub partner sub_partner_133012_level2 adr policy
    And I try to set adr policy to 7 Years (quarterly) but input invalid password h@llo0WOrld
    Then I refresh Data Retention section
    And sub partner adr policy should be:
      | sub parnter name          | policy               |
      | sub_partner_133012_level2 | 6 Years (quarterly)  |
    And I close opened data retention section
    #TC.133028 - update ADR policy with correct password======
    When I click sub partner sub_partner_133012_level2 adr policy
    And I set adr policy to 7 Years (quarterly)
    Then I refresh Data Retention section
    And sub partner adr policy should be:
      | sub parnter name          | policy               |
      | sub_partner_133012_level2 | 7 Years (quarterly)  |
    And I close opened data retention section
   #======TC.133033 - TC.133035, update ADR policy for sub partner======
   #TC.133035 - cancel create adr policy from parent partner======
    When I click partner adr policy
    And I set adr policy 7 Days but click cancel
    And I refresh Data Retention section
    Then partner adr policy should be None
    And sub partner adr policy should be:
      | sub parnter name          | policy               |
      | sub_partner_133012_level2 | 7 Years (quarterly)  |
    And I close opened data retention section
    #TC.133034 - create ADR policy from parent partner with incorrect password======
    When I click partner adr policy
    And I try to set adr policy to 7 Days but input invalid password h@llo0WOrld
    And I refresh Data Retention section
    Then partner adr policy should be None
    And sub partner adr policy should be:
      | sub parnter name          | policy               |
      | sub_partner_133012_level2 | 7 Years (quarterly)  |
    And I close opened data retention section
    #TC.133038 - create ADR policy from parent partner with correct password======
    When I click partner adr policy
    And I set adr policy to 7 Days
    And I refresh Data Retention section
    Then partner adr policy should be 7 Days
    And sub partner adr policy should be:
      | sub parnter name          | policy               |
      | sub_partner_133012_level2 | 7 Years (quarterly)  |
    And I close opened data retention section
    But I stop masquerading
  #======Delete the sub partner======
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by:
      | name                      |
      | sub_partner_133012_level2 |
    Then I view partner details by sub_partner_133012_level2
    And I delete partner account
    When I search partner by:
      | name                      |
      | sub_partner_133012_level1 |
    Then I view partner details by sub_partner_133012_level1
    And I delete partner account


  @TC.132990-96 @bus @data_retention @bus-2.27 @P1
  Scenario: add sub-partner2 under suspended sub-partner1
  #======7 test cases======
    #TC.132990 - add sub-partner2 under suspended sub-partner1
    #======step1: create MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC.132990-96 |   1    |  100 GB    | yes         | yes       |
    And I change root role to FedID role
    And I get the partner_id
    And I get the admin id from partner details
    And I change root role to FedID role
    And I get the partner_id
    When I act as newly created partner account
    #======step2: act as parnter, and new sub partner layer1(include role and plan)======
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Perisods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly   | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name              |
      | sub_partner_132990_level1 |
    Then New partner should be created
    #======step3: stop masquerading from partner======
    But I stop masquerading
    #======step4: act as sub partner layer 1, purchase resource======
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by:
      | name                      |
      | sub_partner_132990_level1 |
    Then I view partner details by sub_partner_132990_level1
    And I act as newly created partner
    And I purchase resources:
      | generic quota |
      | 80            |
    #======step5: create a new user with backup machine under sub partner layer 1/(default user group)======
    And I add new user(s):
      | name      | user_group           | storage_type  | storage_limit  | devices |
      | user1_lv1 | (default user group) |  Desktop      |  10            |  5      |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name      | user_name                   | machine_type |
      | user1_lv1_machine | <%=@new_users.first.email%> | Desktop      |
    And I update newly created machine encryption value to Default
    #======step6: create adr policy at sub partner layer 1 only======
    Given I navigate to Data Retention section from bus admin console page
    When I click partner adr policy
    And I set adr policy to 1 Month (daily)
    #======step7: stop masquerading from sub partner layer 1======
    But I stop masquerading
    #======step8: suspend sub partner layer 1======
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by:
      | name                      |
      | sub_partner_132990_level1 |
    Then I view partner details by sub_partner_132990_level1
    And I wait for 180 seconds
    And I suspend the partner
    #======step9: act as sub partner layer 1======
    And I act as newly created partner
    #======step10: create sub partner laywer 2======
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name     | Type          | Parent  |
      | subrole2 | Partner admin | subrole |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role  | Perisods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole2   | yearly   | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name              |
      | sub_partner_132990_level2 |
    Then New partner should be created
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by:
      | name                      |
      | sub_partner_132990_level2 |
    Then I view partner details by sub_partner_132990_level2
    #======step11: act as sub partner layer 2======
    And I act as newly created partner
    #======step12: purchase resource for sub partner layer 2=======
    And I purchase resources:
      | generic quota |
      | 50            |
    #======step13: new user group qa-test-group_lv2 under sub partner layer 2======
    And I add a new Bundled user group:
      | name              | storage_type | install_region_override | enable_stash |
      | qa-test-group_lv2 | Shared       | qa                      | yes          |
    Then Bundled user group should be created
    And I add new user(s):
      | name      | user_group         | storage_type  | storage_limit  | devices |
      | user1_lv2 | qa-test-group_lv2  |  Desktop      |  10            |  5      |
    Then 1 new user should be created
    #======step14: check no adr job created in db (adr_jobs) table for user group qa-test-group_lv2======
    Given I navigate to User Group List section from bus admin console page
    When I get user group's qa-test-group_lv2 adr job id
    Then adr job is empty
    #======step15: stop masquerading from sub partner layer 2 to sub partner layer 1======
    And I stop masquerading from subpartner
    #======step16: stop masquerading from sub partner layer 1 to root======
    And I stop masquerading
    #TC.132992 - re-active sub-partner1 - bug ======
    #======step17: act as sub partner layer 2======
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by:
      | name                      |
      | sub_partner_132990_level2 |
    Then I view partner details by sub_partner_132990_level2
    And I act as newly created partner
    #======step18: create adr policy for sub parnter laywer 2 and its user group qa-test-group_lv2======
    Given I navigate to Data Retention section from bus admin console page
    When I click partner adr policy
    And I set adr policy to 3 Months (weekly)
    Then I refresh Data Retention section
    And I close opened data retention section
    Then I click user group qa-test-group_lv2 adr policy
    And I set adr policy to 6 Months (monthly)
    Then I refresh Data Retention section
    #======step19: stop masquerading from sub partner 2======
    But I stop masquerading
    #======step20: re-active suspended sub partner layer 1======
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by:
      | name                      |
      | sub_partner_132990_level1 |
    Then I view partner details by sub_partner_132990_level1
    And I activate the partner
    And I clear partner search results
    #======step21: get sub partner layer 2 id and partner adr policy and its user group qa-test-group_lv2 adr policy in db======
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by:
      | name                      |
      | sub_partner_132990_level2 |
    And I view partner details by sub_partner_132990_level2
    And I get the partner_id
    Then ADR policy in DB for partner is Mozy3Month_weekly
    And ADR policy in DB for user group qa-test-group_lv2 is Mozy6Month_monthly
    #TC.132993 -  add backup machine for user under sub-parnter1
    #======step22: search partner type for create backup machine at back-end purpose======
    When I search partner by TC.132990-96
    And I get current partner type
 But I navigate to Search Admins section from bus admin console page
    #======step23: act as sub partner layer 1======
    When I search partner by sub_partner_132990_level1
    Then I view partner details by sub_partner_132990_level1
    And I get the partner_id
    And I act as newly created partner
    #======step24: create new user under sub partner layer 1 with a backup machine, under (default user group)======
    And I add new user(s):
      | name      | user_group           | storage_type  | storage_limit  | devices |
      | user2_lv1 | (default user group) |  Desktop      |  5             |  2      |
    Then 1 new user should be created
    Given I navigate to Search / List Users section from bus admin console page
    When I search user by:
      | user type                      |
      | sub_partner_132990_level1 Users|
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name      | user_name                   | machine_type |
      | user2_lv1_machine | <%=@new_users.first.email%> | Desktop      |
    And I update newly created machine encryption value to Default
    And I refresh User Details section
    #======step25: check new machine's detail in db======
    And device user2_lv1_machine detail info in db should be:
      | alias             | vc_policy_name   | vc_status |
      | user2_lv1_machine | Mozy1Month_daily | DONE      |
    #TC.132994 - delete a new added user sub partner1======
    #======Step26: new user group qa-test-group_lv1======
    When I add a new Bundled user group:
      | name              | storage_type | install_region_override | enable_stash |
      | qa-test-group_lv1 | Shared       | qa                      | yes          |
    Then Bundled user group should be created
    #======Step27: new user with backup machine under user group qa-test-group_lv1============
    And I add new user(s):
      | name      | user_group         | storage_type  | storage_limit  | devices |
      | user3_lv1 | qa-test-group_lv1  |  Desktop      |  10            |  5      |
    Then 1 new user should be created
    Given I navigate to Search / List Users section from bus admin console page
    When I search user by:
      | user type                      |
      | sub_partner_132990_level1 Users|
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name      | user_name                   | machine_type |
      | user3_lv1_machine | <%=@new_users.first.email%> | Desktop      |
    And I update newly created machine encryption value to Default
    And I refresh User Details section
    #======Step28: check new machine's detail before/after machine deletion======
    When device user3_lv1_machine detail info in db should be:
      | alias             | vc_policy_name   | vc_status | deleted |
      | user3_lv1_machine | Mozy1Month_daily | DONE      | f       |
    And I delete user
    Then device user3_lv1_machine detail info in db should be:
      | alias             | vc_policy_name   | vc_status | deleted |
      | user3_lv1_machine | Mozy1Month_daily | DONE      | t       |
    #======Step29: stop masquerading from sub partner layer 1======
    And I stop masquerading
    #TC.132995 - add backup machine for user under sub-partner2
    #======Step30: get root partner type for machine creation at back-end purpose======
    When I search partner by TC.132990-96
    Then I get current partner type
    And I clear partner search results
    #======Step31: act as sub partner layer 2======
    When I search partner by sub_partner_132990_level2
    Then I view partner details by sub_partner_132990_level2
    And I get the partner_id
    And I act as newly created partner
    #======Step32: new user group qa-test-group1_lv2 under sub partner layer 2=====
    When I add a new Bundled user group:
      | name               | storage_type | install_region_override | enable_stash |
      | qa-test-group1_lv2 | Shared       | qa                      | yes          |
    Then Bundled user group should be created
    #======Step33: new user user2_lv2 with backup machine under new user group qa-test-group1_lv2======
    And I add new user(s):
      | name      | user_group         | storage_type  | storage_limit  | devices |
      | user2_lv2 | qa-test-group1_lv2 |  Desktop      |  10            |  5      |
    Then 1 new user should be created
    Given I navigate to Search / List Users section from bus admin console page
    When I search user by:
      | keywords  |
      | user2_lv2 |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name      | user_name                   | machine_type |
      | user2_lv2_machine | <%=@new_users.first.email%> | Desktop      |
    And I update newly created machine encryption value to Default
    And I refresh User Details section
    #======Step34: check new machine's detail in db======
    When device user2_lv2_machine detail info in db should be:
      | alias             | vc_policy_name    | vc_status | deleted |
      | user2_lv2_machine | Mozy3Month_weekly | DONE      | f       |
    #TC.132996 -  delete a new added user under sub-partner2 and delete it
    #======Step35: delete user and check deleted machine's detail in db======
    And I delete user
    Then device user2_lv2_machine detail info in db should be:
      | alias             | vc_policy_name    | vc_status | deleted |
      | user2_lv2_machine | Mozy3Month_weekly | DONE      | t       |
    #======Step36: stop masquerading from sub partner layer 2======
    And I stop masquerading
    #======Step37: delete all partners======
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by:
      | name                      |
      | sub_partner_132990_level1 |
    Then I view partner details by sub_partner_132990_level1
    And I delete partner account
    When I search partner by:
      | name         |
      | TC.132990-96 |
    Then I view partner details by TC.132990-96
    And I delete partner account




  @TCdebugger @bus @data_retention @bus-2.27 @P1
  Scenario: add sub-partner2 under suspended sub-partner1
  #======7 test cases======
    #TC.132990 - add sub-partner2 under suspended sub-partner1
    #======step1: create MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC.132990-96 |   1    |  100 GB    | yes         | yes       |
    And I change root role to FedID role
    And I get the partner_id
    And I get the admin id from partner details
    And I change root role to FedID role
    And I get the partner_id
    When I act as newly created partner account
    #======step2: act as parnter, and new sub partner layer1(include role and plan)======
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Perisods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly   | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name              |
      | sub_partner_132990_level1 |
    Then New partner should be created
    #======step3: stop masquerading from partner======
    But I stop masquerading
    #======step4: act as sub partner layer 1, purchase resource======
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by:
      | name                      |
      | sub_partner_132990_level1 |
    Then I view partner details by sub_partner_132990_level1
    And I act as newly created partner
    And I purchase resources:
      | generic quota |
      | 80            |
