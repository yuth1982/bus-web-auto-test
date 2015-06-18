Feature: Phoenix smoke test

  As a business owner
  (1) I want to create a partner through phoenix
  (2) I want to create a mozyhome user and manage home user
  So that I can organize my business in a way that works for me


  @TC.126122 @bus @regression_test @phoenix @mozyhome @free @email
  Scenario: 126122 Add a new US monthly free MozyHome user
    When I am at dom selection point:
    And I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    And I save the partner info
    Then the user is successfully added.
    And the user has activated their account


  @TC.126123 @bus @regression_test @phoenix @mozyhome
  Scenario: 126123 Log into the MozyHome free user - Precondition:@TC.126122
    When I get previous partner info
    And I login as the user on the account.
    And I verify the user account.

  @TC.126127 @bus @regression_test @phoenix @mozyhome
  Scenario: 126127 Verify that home user can upgrade to a paid home user - Precondition:@TC.126122
    When I get previous partner info
    And I login as the user on the account.
    And I upgrade my free account to:
      | base plan | period | admin name                                     | coupon                |
      | 50 GB     | 1      | Internal Mozy - Phoenix smoke test - free2paid | <%=QA_ENV['coupon']%> |
    Then upgrade from free to paid will be successful

  @TC.126135 @bus @regression_test @phoenix @mozyhome @qa
  Scenario: 126135 home user can upgrade current plan - Precondition:@TC.126122,@TC.126127
    When I get previous partner info
    And I login as the user on the account.
    And I upgrade my user account to:
      | base plan | addl storage |
      | 125 GB    | 2            |

  @TC.126136 @bus @regression_test @phoenix @mozyhome @qa
  Scenario: 126136 home user can upgrade next renewal plan - Precondition:@TC.126122,@TC.126127
    When I get previous partner info
    And I login as the user on the account.
    And I change my user account to:
      | period |
      | 12     |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 2 x 20 GB = 40 GB |
      | Total Storage:      | 165 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Yearly            |
      | Term Discount:      | 1 month free      |
      | Total:              | $153.89           |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 40 GB           |
      | Computers:          | 3               |
      | Subscription:       | Yearly          |
      | Term Discount:      | 1 month free    |
      | Total:              | $153.89         |

  @TC.126126 @bus @regression_test @phoenix @mozyhome
  Scenario: 126126 client can be downloaded when home user log in phoenix - Precondition:@TC.126122
    When I get previous partner info
    And I login as the user on the account.
    Then I check download links in download backup software and download mozy sync software page
    And I clear downloads folder
    And I download home client through phoenix
    And I download sync client through phoenix

  @TC.126134 @bus @regression_test @phoenix @mozyhome
  Scenario: 126134 home user delete account by self - Precondition:@TC.126122
    When I get previous partner info
    And I login as the user on the account.
    And I delete the user account with original password
    And I login as the user on the account.
    And user log in failed, error message is:
    """
     Incorrect email or password.
    """