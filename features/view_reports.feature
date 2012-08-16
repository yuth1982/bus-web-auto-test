Feature: View Report
  As a Mozy Administrator
  I want to view reports on the services I have purchased
  so that I can understand why I was charged what I was charged and for which partner or usergroup, update my records, or re-bill my sub-partners and usergroups.

  Background:
    Given I log in bus admin console as administrator

  @TC.16255 @slow
  Scenario: 16255 Verify available report links and descriptions in report builder view UI
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    When I navigate to Report Builder section from bus admin console page
    Then I should see available reports are:
    | Report Type        | Description                                                                                                                        |
    | Billing Summary    | Gives a summary of resources and usage by partner and user group.                                                                  |
    | Billing Detail     | Provides a breakdown of resources and usage by user and device.                                                                    |
    | Machine Watchlist  | Calls out problems with backups on each device, signaling issues and potential issues that need attention.                         |
    | Machine Status     | Provides the state of the backup service by device, including the time of the most recent backup and the amount of quota consumed. |
    | Resources Added    | Lists all purchases of resources (licenses and storage) by Mozy administrators and storage added by Autogrow.                     |
    | Machine Over Quota | Provides a list of users that have exceeded a user determined threshold.                                                           |

  @TC.17846 @slow
  Scenario: 17846 Verify quick report links and descriptions in quick reports view UI
    When I add a new Reseller partner:
    | period | reseller type | reseller quota |
    | 1      | Silver        | 100            |
    Then New partner should be created
    When I act as newly created partner account
    When I navigate to Quick Reports section from bus admin console page
    Then I should see quick reports are:
    | report type                    | description                                               |
    | Users (CSV)                    | List of all users (does not include users in subpartners) |
    | Machines (CSV)                 | List of all machines                                      |
    | UserGroups (CSV)               | List of all user groups                                   |
    | Roles (CSV)                    | List of administrative roles                              |
    | Credit Card Transactions (CSV) | List of all credit card transactions                      |
    | Billing History (CSV)          | List of all invoices after @today                         |
    | Mozy Pro Keys (CSV)            | List of all unassigned Mozy Pro keys                      |
    | Machine Details (CSV)          | List of all Machine Details                               |

  @TC.16245 @slow
  Scenario: 16245 Verify create then delete daily billing summary report
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    When I build a new report:
    | type            | name                  | frequency |
    | Billing Summary | billing summary test  | Daily     |
    Then Billing summary report should be created
    Then Scheduled report list should be:
    | Name                 | Type             | Recipients | Schedule | Actions |
    | billing summary test | Billing Summary  | @email     | Daily    | Run     |
    When I delete billing summary test scheduled report
    Then I should see No results found in scheduled reports list

  @TC.17937 @slow
  Scenario: 17937 Verify create then delete weekly billing summary report
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    When I build a new report:
    | type            | name                  | frequency |
    | Billing Summary | billing summary test  | Weekly    |
    Then Billing summary report should be created
    Then Scheduled report list should be:
    | Name                 | Type             | Recipients | Schedule | Actions |
    | billing summary test | Billing Summary  | @email     | Weekly   | Run     |
    When I delete billing summary test scheduled report
    Then I should see No results found in scheduled reports list

  @TC.17938 @slow
  Scenario: 17938 Verify create then delete monthly billing summary report
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    When I build a new report:
    | type            | name                 | frequency |
    | Billing Summary | billing summary test | Monthly   |
    Then Billing summary report should be created
    Then Scheduled report list should be:
    | Name                 | Type             | Recipients | Schedule | Actions |
    | billing summary test | Billing Summary  | @email     | Monthly  | Run     |
    When I delete billing summary test scheduled report
    Then I should see No results found in scheduled reports list

  @TC.16251 @slow
  Scenario: 16251 Verify MozyEtnerprise billing summary report csv all fields
    When I add a new MozyEnterprise partner:
    | period | users | server plan                 | server add-on |
    | 12     | 1     | 100 GB Server Plan, $582.78 | 2             |
    Then New partner should be created
    When I act as newly created partner account
    When I build a new report:
    | type            | name                  |
    | Billing Summary | billing summary test  |
    Then Billing summary report should be created
    When I download billing summary test scheduled report
    Then Scheduled Billing Summary report csv file details should be:
    | Column A | Column B              | Column C     | Column D           | Column E              | Column F            | Column G               | Column H             | Column I                           | Column J                            | Column K               |
    | Partner  | User Group            | Billing Code | Total GB Purchased | Server Keys Purchased | Server GB Purchased | Desktop Keys Purchased | Desktop GB Purchased | Effective price per Server license | Effective price per Desktop license | Effective price per GB |
    | @name    | (default user group)  |              | 625                | 200                   | 600                 | 1                      | 25                   |                                    |                                     | $0.369008              |

  @TC.17847 @slow
  Scenario: 17847 Verify Reseller billing summary report csv all fields
    When I add a new Reseller partner:
    | period | reseller type | reseller quota | server plan | server add-on |
    | 1      | Silver        | 100            | yes         | 2             |
    Then New partner should be created
    When I act as newly created partner account
    When I build a new report:
    | type            | name                  |
    | Billing Summary | billing summary test  |
    Then Billing summary report should be created
    When I download billing summary test scheduled report
    Then Scheduled Billing Summary report csv file details should be:
    | Column A | Column B              | Column C     | Column D           | Column E              | Column F            | Column G               | Column H             | Column I                           | Column J                            | Column K               |
    | Partner  | User Group            | Billing Code | Total GB Purchased | Server Keys Purchased | Server GB Purchased | Desktop Keys Purchased | Desktop GB Purchased | Effective price per Server license | Effective price per Desktop license | Effective price per GB |
    | @name    | (default user group)  |              | 140                |                       |                     |                        |                      |                                    |                                     | $0.598571428571429     |

  @TC.17939 @slow
  Scenario: 17939 Verify MozyEtnerprise billing summary report csv all fields download from email
    When I add a new MozyEnterprise partner:
    | period | users | server plan                 | server add-on |
    | 12     | 1     | 100 GB Server Plan, $582.78 | 2             |
    Then New partner should be created
    When I act as newly created partner account
    When I build a new report:
    | type            | name                  |
    | Billing Summary | billing summary test  |
    Then Billing summary report should be created
    When I wait for 30 seconds
    And I log in zimbra as default zimbra account
    And I search email to match all keywords:
    | from                       | to     | date   | subject               |
    | support@mozyenterprise.com | @email | @today | billing summary test  |
    Then I should see 1 email(s) displayed in search results
    When I download report from email attachment
    Then Scheduled Billing Summary report csv file details should be:
    | Column A | Column B              | Column C     | Column D           | Column E              | Column F            | Column G               | Column H             | Column I                           | Column J                            | Column K               |
    | Partner  | User Group            | Billing Code | Total GB Purchased | Server Keys Purchased | Server GB Purchased | Desktop Keys Purchased | Desktop GB Purchased | Effective price per Server license | Effective price per Desktop license | Effective price per GB |
    | @name    | (default user group)  |              | 625                | 200                   | 600                 | 1                      | 25                   |                                    |                                     | $0.369008              |

  @TC.17941 @slow
  Scenario: 17941 Verify Reseller billing summary report csv all fields download from email
    When I add a new Reseller partner:
    | period | reseller type | reseller quota | server plan | server add-on |
    | 1      | Silver        | 100            | yes         | 2             |
    Then New partner should be created
    When I act as newly created partner account
    When I build a new report:
    | type            | name                  |
    | Billing Summary | billing summary test  |
    Then Billing summary report should be created
    When I wait for 30 seconds
    And I log in zimbra as default zimbra account
    And I search email to match all keywords:
    | from                                  | to     | date   | subject              |
    | redacted-3364@notarealdomain.mozy.com | @email | @today | billing summary test |
    Then I should see 1 email(s) displayed in search results
    When I download report from email attachment
    Then Scheduled Billing Summary report csv file details should be:
    | Column A | Column B              | Column C     | Column D           | Column E              | Column F            | Column G               | Column H             | Column I                           | Column J                            | Column K               |
    | Partner  | User Group            | Billing Code | Total GB Purchased | Server Keys Purchased | Server GB Purchased | Desktop Keys Purchased | Desktop GB Purchased | Effective price per Server license | Effective price per Desktop license | Effective price per GB |
    | @name    | (default user group)  |              | 140                |                       |                     |                        |                      |                                    |                                     | $0.598571428571429     |

  @TC.16250 @slow
  Scenario: 16250 Verify create and delete billing detail report
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    When I build a new report:
    | type            | name                |
    | Billing Detail  | billing detail test |
    Then Billing detail report should be created
    And Scheduled report list should be:
    | Name                | Type            | Recipients  | Schedule | Actions |
    | billing detail test | Billing Detail  | @email      | Daily    | Run     |
    When I delete billing detail test scheduled report
    Then I should see No results found in scheduled reports list

  @TC.16252 @slow
  Scenario: 16252 Verify MozyEtnerprise billing detail report csv all fields
    When I add a new MozyEnterprise partner:
    | period | users | server plan                    | server add-on |
    | 24     | 1     | 100 GB Server Plan, $1,112.58  | 2             |
    Then New partner should be created
    When I act as newly created partner account
    When I build a new report:
    | type            | name                |
    | Billing Detail  | billing detail test |
    Then Billing detail report should be created
    When I download billing detail test scheduled report
    Then Scheduled Billing Detail report csv file details should be:
    | Column A | Column B              | Column C     | Column D           | Column E                    | Column F                    | Column G               | Column H              | Column I              | Column J                               | Column K                     | Column L                     | Column M                | Column N               | Column O               | Column P                                | Column Q                           | Column R                            | Column S               |
    | Partner  | User Group            | Billing Code | Total GB Purchased | Server Quota Purchased (GB) | Server Quota Allocated (GB) | Server Quota Used (GB) | Server Keys Purchased | Server Keys Activated | Server Keys Assigned But Not Activated | Desktop Quota Purchased (GB) | Desktop Quota Allocated (GB) | Desktop Quota Used (GB) | Desktop Keys Purchased | Desktop Keys Activated | Desktop Keys Assigned But Not Activated | Effective price per Server license | Effective price per Desktop license | Effective price per GB |
    | @name    | (default user group)  |              | 625                | 600                         | 0                           | 0                      | 200                   | 0                     | 0                                      | 25                           | 0                            | 0                       | 1                      | 0                      | 0                                       |                                    |                                     | $0.352210666666667     |

  @TC.17848 @slow
  Scenario: 17484 Verify Reseller billing detail report csv all fields
    When I add a new Reseller partner:
    | period | reseller type | reseller quota | server plan | server add-on |
    | 1      | Silver        | 100            | yes         | 2             |
    Then New partner should be created
    When I act as newly created partner account
    When I build a new report:
    | type            | name                |
    | Billing Detail  | billing detail test |
    Then Billing detail report should be created
    When I download billing detail test scheduled report
    Then Scheduled Billing Detail report csv file details should be:
    | Column A | Column B              | Column C     | Column D           | Column E                    | Column F                    | Column G               | Column H              | Column I              | Column J                               | Column K                     | Column L                     | Column M                | Column N               | Column O               | Column P                                | Column Q                           | Column R                            | Column S               |
    | Partner  | User Group            | Billing Code | Total GB Purchased | Server Quota Purchased (GB) | Server Quota Allocated (GB) | Server Quota Used (GB) | Server Keys Purchased | Server Keys Activated | Server Keys Assigned But Not Activated | Desktop Quota Purchased (GB) | Desktop Quota Allocated (GB) | Desktop Quota Used (GB) | Desktop Keys Purchased | Desktop Keys Activated | Desktop Keys Assigned But Not Activated | Effective price per Server license | Effective price per Desktop license | Effective price per GB |
    | @name    | (default user group)  |              | 140                |                             | 0                           | 0                      |                       | 0                     | 0                                      |                              | 0                            | 0                       |                        | 0                      | 0                                       |                                    |                                     | $0.598571428571429     |

  @TC.17940 @slow
  Scenario: 17940 Verify MozyEtnerprise billing detail report csv all fields download from email
    When I add a new MozyEnterprise partner:
    | period | users | server plan                    | server add-on |
    | 24     | 1     | 100 GB Server Plan, $1,112.58  | 2             |
    Then New partner should be created
    When I act as newly created partner account
    When I build a new report:
    | type            | name                |
    | Billing Detail  | billing detail test |
    Then Billing detail report should be created
    When I wait for 30 seconds
    And I log in zimbra as default zimbra account
    And I search email to match all keywords:
    | from                       | to     | date   | subject             |
    | support@mozyenterprise.com | @email | @today | billing detail test |
    Then I should see 1 email(s) displayed in search results
    When I download report from email attachment
    Then Scheduled Billing Detail report csv file details should be:
    | Column A | Column B              | Column C     | Column D           | Column E                    | Column F                    | Column G               | Column H              | Column I              | Column J                               | Column K                     | Column L                     | Column M                | Column N               | Column O               | Column P                                | Column Q                           | Column R                            | Column S               |
    | Partner  | User Group            | Billing Code | Total GB Purchased | Server Quota Purchased (GB) | Server Quota Allocated (GB) | Server Quota Used (GB) | Server Keys Purchased | Server Keys Activated | Server Keys Assigned But Not Activated | Desktop Quota Purchased (GB) | Desktop Quota Allocated (GB) | Desktop Quota Used (GB) | Desktop Keys Purchased | Desktop Keys Activated | Desktop Keys Assigned But Not Activated | Effective price per Server license | Effective price per Desktop license | Effective price per GB |
    | @name    | (default user group)  |              | 625                | 600                         | 0                           | 0                      | 200                   | 0                     | 0                                      | 25                           | 0                            | 0                       | 1                      | 0                      | 0                                       |                                    |                                     | $0.352210666666667     |

  @TC.16263 @slow
  Scenario: 16263 Verify all credit card transactions from the creation of the partner to the current date
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription up to MozyEnterprise biennial billing period
    Then Subscription changed message should be Your account has been changed to biennial billing.
    When I download Credit Card Transactions (CSV) quick report
    Then Quick report Credit Card Transactions csv file details should be:
    | Column A | Column B | Column C | Column D  |
    | Date     | Amount   | Card #   | Card Type |
    | @today   | $86.00   | @XXXX    | Visa      |
    | @today   | $95.00   | @XXXX    | Visa      |

  @TC.17849 @slow
  Scenario: 17849 Verify report type drop down list values in scheduled report view
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    When I navigate to Scheduled Reports section from bus admin console page
    Then I should see report filters are:
    | Report Type        |
    | None               |
    | Billing Summary    |
    | Billing Detail     |
    | Machine Watchlist  |
    | Machine Status     |
    | Outdated Clients   |
    | Resources Added    |
    | Machine Over Quota |