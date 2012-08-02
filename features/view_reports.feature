Feature: View Report
  As a Mozy Administrator
  I want to view reports on the services I have purchased
  so that I can understand why I was charged what I was charged and for which partner or usergroup, update my records, or re-bill my sub-partners and usergroups.

  @TC.16255 @require_test_account
  Scenario: Mozy-16255 Verify available report links and descriptions in report builder view UI
    Given I log in bus admin console as mozyenterprise test account
    When I navigate to Report Builder view from bus admin console page
    Then I should see available reports are:
    | Report Type        | Description                                                                                                                        |
    | Billing Summary    | Gives a summary of resources and usage by partner and user group.                                                                  |
    | Billing Detail     | Provides a breakdown of resources and usage by user and device.                                                                    |
    | Machine Watchlist  | Calls out problems with backups on each device, signaling issues and potential issues that need attention.                         |
    | Machine Status     | Provides the state of the backup service by device, including the time of the most recent backup and the amount of quota consumed. |
    | Resources Added    | Lists all purchases of resources (licenses and storage) by Mozy administrators and storage added by Autogrow.                     |
    | Machine Over Quota | Provides a list of users that have exceeded a user determined threshold.                                                           |

  @TC.17846 @require_test_account
  Scenario: Mozy-17846:Verify quick report links and descriptions in quick reports view UI
    Given I log in bus admin console as mozyenterprise test account
    When I navigate to Quick Reports view from bus admin console page
    Then I should see quick reports are:
    | Report Type                    | Description                                               |
    | Users (CSV)                    | List of all users (does not include users in subpartners) |
    | Machines (CSV)                 | List of all machines                                      |
    | UserGroups (CSV)               | List of all user groups                                   |
    | Roles (CSV)                    | List of administrative roles                              |
    | Credit Card Transactions (CSV) | List of all credit card transactions                      |
    | Billing History (CSV)          | List of all invoices after 2012-07-05                     |
    | Mozy Pro Keys (CSV)            | List of all unassigned Mozy Pro keys                      |
    | Machine Details (CSV)          | List of all Machine Details                               |

  @TC.16245
  Scenario: Mozy-16245 Verify create then delete daily billing summary report
    Given I log in bus admin console as administrator
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), 100 GB Server Plan, $582.78 server plan, 2 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to Report Builder view from bus admin console page
    And I build a new Active Daily billing summary report named Billing Summary Test Report start Today
    Then Report created successful message should be Created Billing Summary Report.
    And Scheduled report list should be:
    | Name                        | Type             | Recipients | Schedule | Actions | Next Run   |
    | Billing Summary Test Report | Billing Summary  | @email     | Daily    | Run     | @next_day  |
    When I delete report by name Billing Summary Test Report
    Then I should see No results found in scheduled reports list

  @TC.17937
  Scenario: Mozy-17937 Verify create then delete weeklky billing summary report
    Given I log in bus admin console as administrator
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), 100 GB Server Plan, $582.78 server plan, 2 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to Report Builder view from bus admin console page
    And I build a new Active Weekly billing summary report named Billing Summary Test Report start Today
    Then Report created successful message should be Created Billing Summary Report.
    And Scheduled report list should be:
    | Name                        | Type             | Recipients | Schedule | Actions | Next Run   |
    | Billing Summary Test Report | Billing Summary  | @email     | Weekly   | Run     | @next_week |
    When I delete report by name Billing Summary Test Report
    Then I should see No results found in scheduled reports list

  @TC.17938
  Scenario: Mozy-17938 Verify create then delete monthly billing summary report
    Given I log in bus admin console as administrator
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), 100 GB Server Plan, $582.78 server plan, 2 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to Report Builder view from bus admin console page
    And I build a new Active Monthly billing summary report named Billing Summary Test Report start Today
    Then Report created successful message should be Created Billing Summary Report.
    And Scheduled report list should be:
    | Name                        | Type             | Recipients | Schedule | Actions | Next Run    |
    | Billing Summary Test Report | Billing Summary  | @email     | Monthly  | Run     | @next_month |
    When I delete report by name Billing Summary Test Report
    Then I should see No results found in scheduled reports list

  @TC.16250
  Scenario: Mozy-16250 Verify create and delete billing detail report
    Given I log in bus admin console as administrator
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), 100 GB Server Plan, $582.78 server plan, 2 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to Report Builder view from bus admin console page
    And I build a new Active Daily billing detail report named Billing Detail Test Report start Today
    Then Report created successful message should be Created Billing Detail Report.
    And Scheduled report list should be:
    | Name                       | Type            | Recipients  | Schedule | Actions | Next Run  |
    | Billing Detail Test Report | Billing Detail  | @email      | Daily    | Run     | @next_day |
    When I delete report by name Billing Detail Test Report
    Then I should see No results found in scheduled reports list

   #| Daily     | Machine Watchlist   | Machine Watchlist Test Report   | Created Machine Watchlist Report.   |
   #| Daily     | Machine Status      | Machine Status Test Report      | Created Machine Status Report.      |
   #| Daily     | Machine Over Quota  | Machine Over Quota Test Report  | Created Machine Over Quota Report.  |
   #| Daily     | Resources Added     | Resources Added Test Report     | Created Resources Added Report.     |

  @TC.16251
  Scenario: Mozy-16251 Verify MozyEtnerprise billing summary report csv all fields
    Given I log in bus admin console as administrator
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), 100 GB Server Plan, $582.78 server plan, 2 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to Report Builder view from bus admin console page
    And I build a new Active Daily billing summary report named Billing Summary Test Report start Today
    Then Report created successful message should be Created Billing Summary Report.
    When I download report by name Billing Summary Test Report
    Then Scheduled Billing Summary report csv file details should be:
    | Column A | Column B              | Column C     | Column D           | Column E              | Column F            | Column G               | Column H             | Column I                           | Column J                            | Column K               |
    | Partner  | User Group            | Billing Code | Total GB Purchased | Server Keys Purchased | Server GB Purchased | Desktop Keys Purchased | Desktop GB Purchased | Effective price per Server license | Effective price per Desktop license | Effective price per GB |
    | @name    | (default user group)  |              | 625                | 200                   | 600                 | 1                      | 25                   |                                    |                                     | $0.369008              |

  @TC.17939
  Scenario: Mozy-17939 Verify MozyEtnerprise billing summary report csv all fields download from email
    Given I log in bus admin console as administrator
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), 100 GB Server Plan, $582.78 server plan, 2 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to Report Builder view from bus admin console page
    And I build a new Active Monthly billing summary report named Billing Summary Test Report start Today
    Then Report created successful message should be Created Billing Summary Report.
    When I wait for 30 seconds
    And I log in zimbra as default zimbra account
    And I search email to match all keywords:
    | from                       | to     | date   | subject                      |
    | support@mozyenterprise.com | @email | @today | Billing Summary Test Report  |
    Then I should see 1 email(s) displayed in search results
    When I download report from email attachment
    Then Scheduled Billing Summary report csv file details should be:
    | Column A | Column B              | Column C     | Column D           | Column E              | Column F            | Column G               | Column H             | Column I                           | Column J                            | Column K               |
    | Partner  | User Group            | Billing Code | Total GB Purchased | Server Keys Purchased | Server GB Purchased | Desktop Keys Purchased | Desktop GB Purchased | Effective price per Server license | Effective price per Desktop license | Effective price per GB |
    | @name    | (default user group)  |              | 625                | 200                   | 600                 | 1                      | 25                   |                                    |                                     | $0.369008              |

  @TC.17847
  Scenario: Mozy-17847 Verify Reseller billing summary report csv all fields
    Given I log in bus admin console as administrator
    When I add a Reseller partner with 1 month(s) period, Silver Reseller, 100 GB base plan, has server plan, 2 add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to Report Builder view from bus admin console page
    And I build a new Active Daily billing summary report named Billing Summary Test Report start Today
    Then Report created successful message should be Created Billing Summary Report.
    When I download report by name Billing Summary Test Report
    Then Scheduled Billing Summary report csv file details should be:
    | Column A | Column B              | Column C     | Column D           | Column E              | Column F            | Column G               | Column H             | Column I                           | Column J                            | Column K               |
    | Partner  | User Group            | Billing Code | Total GB Purchased | Server Keys Purchased | Server GB Purchased | Desktop Keys Purchased | Desktop GB Purchased | Effective price per Server license | Effective price per Desktop license | Effective price per GB |
    | @name    | (default user group)  |              | 140                |                       |                     |                        |                      |                                    |                                     | $0.598571428571429     |

  @TC.17941
  Scenario: Mozy-17941 Verify Reseller billing summary report csv all fields download from email
    Given I log in bus admin console as administrator
    When I add a Reseller partner with 1 month(s) period, Silver Reseller, 100 GB base plan, has server plan, 2 add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to Report Builder view from bus admin console page
    And I build a new Active Daily billing summary report named Billing Summary Test Report start Today
    Then Report created successful message should be Created Billing Summary Report.
    When I wait for 30 seconds
    And I log in zimbra as default zimbra account
    And I search email to match all keywords:
    | from                                  | to     | date   | subject                      |
    | redacted-3364@notarealdomain.mozy.com | @email | @today | Billing Summary Test Report  |
    Then I should see 1 email(s) displayed in search results
    When I download report from email attachment
    Then Scheduled Billing Summary report csv file details should be:
    | Column A | Column B              | Column C     | Column D           | Column E              | Column F            | Column G               | Column H             | Column I                           | Column J                            | Column K               |
    | Partner  | User Group            | Billing Code | Total GB Purchased | Server Keys Purchased | Server GB Purchased | Desktop Keys Purchased | Desktop GB Purchased | Effective price per Server license | Effective price per Desktop license | Effective price per GB |
    | @name    | (default user group)  |              | 140                |                       |                     |                        |                      |                                    |                                     | $0.598571428571429     |

  @TC.16252
  Scenario: Mozy-16252 Verify MozyEtnerprise billing detail report csv all fields
    Given I log in bus admin console as administrator
    When I add a MozyEnterprise partner with 24 month(s) period, 1 user(s), 100 GB Server Plan, $1,112.58 server plan, 2 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to Report Builder view from bus admin console page
    And I build a new Active Daily billing detail report named Billing Detail Test Report start Today
    Then Report created successful message should be Created Billing Detail Report.
    When I download report by name Billing Detail Test Report
    Then Scheduled Billing Detail report csv file details should be:
    | Column A | Column B              | Column C     | Column D           | Column E                    | Column F                    | Column G               | Column H              | Column I              | Column J                               | Column K                     | Column L                     | Column M                | Column N               | Column O               | Column P                                | Column Q                           | Column R                            | Column S               |
    | Partner  | User Group            | Billing Code | Total GB Purchased | Server Quota Purchased (GB) | Server Quota Allocated (GB) | Server Quota Used (GB) | Server Keys Purchased | Server Keys Activated | Server Keys Assigned But Not Activated | Desktop Quota Purchased (GB) | Desktop Quota Allocated (GB) | Desktop Quota Used (GB) | Desktop Keys Purchased | Desktop Keys Activated | Desktop Keys Assigned But Not Activated | Effective price per Server license | Effective price per Desktop license | Effective price per GB |
    | @name    | (default user group)  |              | 625                | 600                         | 0                           | 0                      | 200                   | 0                     | 0                                      | 25                           | 0                            | 0                       | 1                      | 0                      | 0                                       |                                    |                                     | $0.352210666666667     |

  @TC.17940
  Scenario: Mozy-17940 Verify MozyEtnerprise billing detail report csv all fields download from email
    Given I log in bus admin console as administrator
    When I add a MozyEnterprise partner with 24 month(s) period, 1 user(s), 100 GB Server Plan, $1,112.58 server plan, 2 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to Report Builder view from bus admin console page
    And I build a new Active Daily billing detail report named Billing Detail Test Report start Today
    Then Report created successful message should be Created Billing Detail Report.
    When I wait for 30 seconds
    And I log in zimbra as default zimbra account
    And I search email to match all keywords:
    | from                       | to     | date   | subject                      |
    | support@mozyenterprise.com | @email | @today | Billing Detail Test Report  |
    Then I should see 1 email(s) displayed in search results
    When I download report from email attachment
    Then Scheduled Billing Detail report csv file details should be:
    | Column A | Column B              | Column C     | Column D           | Column E                    | Column F                    | Column G               | Column H              | Column I              | Column J                               | Column K                     | Column L                     | Column M                | Column N               | Column O               | Column P                                | Column Q                           | Column R                            | Column S               |
    | Partner  | User Group            | Billing Code | Total GB Purchased | Server Quota Purchased (GB) | Server Quota Allocated (GB) | Server Quota Used (GB) | Server Keys Purchased | Server Keys Activated | Server Keys Assigned But Not Activated | Desktop Quota Purchased (GB) | Desktop Quota Allocated (GB) | Desktop Quota Used (GB) | Desktop Keys Purchased | Desktop Keys Activated | Desktop Keys Assigned But Not Activated | Effective price per Server license | Effective price per Desktop license | Effective price per GB |
    | @name    | (default user group)  |              | 625                | 600                         | 0                           | 0                      | 200                   | 0                     | 0                                      | 25                           | 0                            | 0                       | 1                      | 0                      | 0                                       |                                    |                                     | $0.352210666666667     |

  @TC.17848
  Scenario: Mozy-17484 Verify Reseller billing detail report csv all fields
    Given I log in bus admin console as administrator
    When I add a Reseller partner with 1 month(s) period, Silver Reseller, 100 GB base plan, has server plan, 2 add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to Report Builder view from bus admin console page
    And I build a new Active Daily billing detail report named Billing Detail Test Report start Today
    Then Report created successful message should be Created Billing Detail Report.
    When I download report by name Billing Detail Test Report
    Then Scheduled Billing Detail report csv file details should be:
    | Column A | Column B              | Column C     | Column D           | Column E                    | Column F                    | Column G               | Column H              | Column I              | Column J                               | Column K                     | Column L                     | Column M                | Column N               | Column O               | Column P                                | Column Q                           | Column R                            | Column S               |
    | Partner  | User Group            | Billing Code | Total GB Purchased | Server Quota Purchased (GB) | Server Quota Allocated (GB) | Server Quota Used (GB) | Server Keys Purchased | Server Keys Activated | Server Keys Assigned But Not Activated | Desktop Quota Purchased (GB) | Desktop Quota Allocated (GB) | Desktop Quota Used (GB) | Desktop Keys Purchased | Desktop Keys Activated | Desktop Keys Assigned But Not Activated | Effective price per Server license | Effective price per Desktop license | Effective price per GB |
    | @name    | (default user group)  |              | 140                |                             | 0                           | 0                      |                       | 0                     | 0                                      |                              | 0                            | 0                       |                        | 0                      | 0                                       |                                    |                                     | $0.598571428571429     |

  @TC.17849 @require_test_account
  Scenario: Mozy-17849 Verify report type drop down list values in scheduled report view
    Given I log in bus admin console as mozyenterprise test account
    When I navigate to Scheduled Reports view from bus admin console page
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

  @TC.16263
  Scenario: Mozy-16263 MozyEnterprise change subscription period from Yearly to Biennially
    Given I log in bus admin console as administrator
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to Billing Information view from bus admin console page
    And I change subscription up to MozyEnterprise biennial billing period
    Then Subscription changed message should be Your account has been changed to biennial billing.
    When I download Credit Card Transactions (CSV) quick report
    Then Quick report Credit Card Transactions csv file details should be:
    | Column A | Column B | Column C | Column D  |
    | Date     | Amount   | Card #   | Card Type |
    | 7/30/12  | $95.00   | 0191     | Visa      |
    | 7/30/12  | $86.00   | 0191     | Visa      |