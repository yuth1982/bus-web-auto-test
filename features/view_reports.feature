Feature: View Report
  As a Mozy Administrator
  I want to view reports on the services I have purchased
  so that I can understand why I was charged what I was charged and for which partner or usergroup, update my records, or re-bill my sub-partners and usergroups.

  @TC.16255
  Scenario: Verify 6 available reports in report builder view (UI)
    Given I log in bus admin console as administrator
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created
    When I log in bus admin console as the new partner account
    And I navigate to report builder view
    Then I should see available reports are:
    | Report Type        | Description                                                                                                                        |
    | Billing Summary    | Gives a summary of resources and usage by partner and user group.                                                                  |
    | Billing Detail     | Provides a breakdown of resources and usage by user and device.                                                                    |
    | Machine Watchlist  | Calls out problems with backups on each device, signaling issues and potential issues that need attention.                         |
    | Machine Status     | Provides the state of the backup service by device, including the time of the most recent backup and the amount of quota consumed. |
    | Resources Added    | Lists all purchases of resources (licenses and storage) by Mozy administrators and storage added by Overdraft.                     |
    | Machine Over Quota | Provides a list of users that have exceeded a user determined threshold.                                                           |

  @TC.16245
  Scenario: Verify create then delete billing summary report
    Given I log in bus admin console as administrator
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), 100 GB Server Plan, $582.78 server plan, 2 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created
    When I log in bus admin console as the new partner account
    And I navigate to report builder view
    And I build a new Active Daily billing summary report named Billing Summary Test Report start Today
    Then Report created successful message should be Created Billing Summary Report.
    And Scheduled report list should be:
    | Name                        | Type             | Recipients          | Schedule | Actions |
    | Billing Summary Test Report | Billing Summary  | New partner's email | Daily    | Run     |
    When I delete report by name Billing Summary Test Report
    Then I should see No results found in scheduled reports list

  @TC.16250
  Scenario: Verify create and delete billing detail report
    Given I log in bus admin console as administrator
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), 100 GB Server Plan, $582.78 server plan, 2 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created
    When I log in bus admin console as the new partner account
    And I navigate to report builder view
    And I build a new Active Daily billing detail report named Billing Detail Test Report start Today
    Then Report created successful message should be Created Billing Detail Report.
    And Scheduled report list should be:
    | Name                       | Type            | Recipients          | Schedule | Actions |
    | Billing Detail Test Report | Billing Detail  | New partner's email | Daily    | Run     |
    When I delete report by name Billing Detail Test Report
    Then I should see No results found in scheduled reports list

   #| Daily     | Machine Watchlist   | Machine Watchlist Test Report   | Created Machine Watchlist Report.   |
   #| Daily     | Machine Status      | Machine Status Test Report      | Created Machine Status Report.      |
   #| Daily     | Machine Over Quota  | Machine Over Quota Test Report  | Created Machine Over Quota Report.  |
   #| Daily     | Resources Added     | Resources Added Test Report     | Created Resources Added Report.     |

  @TC.16251
  Scenario: Verify billing summary report csv all fields (MozyEtnerprise)
    Given I log in bus admin console as administrator
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), 100 GB Server Plan, $582.78 server plan, 2 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created
    When I log in bus admin console as the new partner account
    And I navigate to report builder view
    And I build a new Active Daily billing summary report named Billing Summary Test Report start Today
    Then Report created successful message should be Created Billing Summary Report.
    When I download report by name Billing Summary Test Report
    Then Billing Summary report file details should be:
    | Column B              | Column C     | Column D           | Column E              | Column F            | Column G               | Column H             | Column I                           | Column J                            | Column K               |
    | User Group            | Billing Code | Total GB Purchased | Server Keys Purchased | Server GB Purchased | Desktop Keys Purchased | Desktop GB Purchased | Effective price per Server license | Effective price per Desktop license | Effective price per GB |
    | (default user group)  |              | 625                | 200                   | 600                 | 1                      | 25                   |                                    |                                     | $0.369008              |

  #@not complete need to change report file details
  Scenario: Verify billing summary report csv all fields (Reseller)
    Given I log in bus admin console as administrator
    When I add a Reseller partner with 1 month(s) period, Silver Reseller, 100 GB plan, has server plan, 2 add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created
    When I log in bus admin console as the new partner account
    And I navigate to report builder view
    And I build a new Active Daily billing summary report named Billing Summary Test Report start Today
    Then Report created successful message should be Created Billing Summary Report.
    When I download report by name Billing Summary Test Report
    Then Billing Summary report file details should be:
    | Column B              | Column C     | Column D           | Column E              | Column F            | Column G               | Column H             | Column I                           | Column J                            | Column K               |
    | User Group            | Billing Code | Total GB Purchased | Server Keys Purchased | Server GB Purchased | Desktop Keys Purchased | Desktop GB Purchased | Effective price per Server license | Effective price per Desktop license | Effective price per GB |
    | (default user group)  |              | 625                | 200                   | 600                 | 1                      | 25                   |                                    |                                     | $0.369008              |

  @TC.16252
  Scenario: Verify billing detail report csv all fields (MozyEtnerprise)
    Given I log in bus admin console as administrator
    When I add a MozyEnterprise partner with 24 month(s) period, 1 user(s), 100 GB Server Plan, $1,112.58 server plan, 2 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created
    When I log in bus admin console as the new partner account
    And I navigate to report builder view
    And I build a new Active Daily billing detail report named Billing Detail Test Report start Today
    Then Report created successful message should be Created Billing Detail Report.
    When I download report by name Billing Detail Test Report
    Then Billing Detail report file details should be:
    | Column B              | Column C     | Column D           | Column E                    | Column F                    | Column G               | Column H              | Column I              | Column J                               | Column K                     | Column L                     | Column M                | Column N               | Column O               | Column P                                | Column Q                           | Column R                            | Column S               |
    | User Group            | Billing Code | Total GB Purchased | Server Quota Purchased (GB) | Server Quota Allocated (GB) | Server Quota Used (GB) | Server Keys Purchased | Server Keys Activated | Server Keys Assigned But Not Activated | Desktop Quota Purchased (GB) | Desktop Quota Allocated (GB) | Desktop Quota Used (GB) | Desktop Keys Purchased | Desktop Keys Activated | Desktop Keys Assigned But Not Activated | Effective price per Server license | Effective price per Desktop license | Effective price per GB |
    | (default user group)  |              | 625                | 600                         | 0                           | 0                      | 200                   | 0                     | 0                                      | 25                           | 0                            | 0                       | 1                      | 0                      | 0                                       |                                    |                                     | $0.352210666666667     |

  #@not complete need to change report file details
  Scenario: Verify billing detail report csv all fields (Reseller)
    Given I log in bus admin console as administrator
    When I add a Reseller partner with 1 month(s) period, Silver Reseller, 100 GB plan, has server plan, 2 add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created
    When I log in bus admin console as the new partner account
    And I navigate to report builder view
    And I build a new Active Daily billing detail report named Billing Detail Test Report start Today
    Then Report created successful message should be Created Billing Detail Report.
    When I download report by name Billing Detail Test Report
    Then Billing Detail report file details should be:
    | Column B              | Column C     | Column D           | Column E                    | Column F                    | Column G               | Column H              | Column I              | Column J                               | Column K                     | Column L                     | Column M                | Column N               | Column O               | Column P                                | Column Q                           | Column R                            | Column S               |
    | User Group            | Billing Code | Total GB Purchased | Server Quota Purchased (GB) | Server Quota Allocated (GB) | Server Quota Used (GB) | Server Keys Purchased | Server Keys Activated | Server Keys Assigned But Not Activated | Desktop Quota Purchased (GB) | Desktop Quota Allocated (GB) | Desktop Quota Used (GB) | Desktop Keys Purchased | Desktop Keys Activated | Desktop Keys Assigned But Not Activated | Effective price per Server license | Effective price per Desktop license | Effective price per GB |
    | (default user group)  |              | 625                | 600                         | 0                           | 0                      | 200                   | 0                     | 0                                      | 25                           | 0                            | 0                       | 1                      | 0                      | 0                                       |                                    |                                     | $0.352210666666667     |