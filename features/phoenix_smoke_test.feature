Feature: Phoenix smoke test

  As a business owner
  (1) I want to create a partner through phoenix
  (2) I want to create a mozyhome user and manage home user
  So that I can organize my business in a way that works for me

  Background:



  @TC.126120 @bus @regression_test @phoenix @mozyhome
  Scenario: 126120 Create a MozyHome paid user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | admin name                | billing country | cc number        | coupon                |
      | 1      | 50 GB     | United States | Phoenix smoke test - home | United States   | 4018121111111122 | <%=QA_ENV['coupon']%> |
    And I save the partner info
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          |       |          | $5.99  |
    Then the user is successfully added.
    And the user has activated their account

  @TC.126132 @bus @regression_test @phoenix @mozyhome
  Scenario: 126132 Log into the MozyHome paid user - Precondition:@TC.126120
    When I get previous partner info
    And I login as the user on the account.
    And I verify the user account.

  @TC.126139 @bus @regression_test @phoenix @mozyhome
  Scenario: 126139 update a profile info of home user - Precondition:@TC.126120
    When I get previous partner info
    And I login as the user on the account.
    And I change my profile attributes to:
      | new_username_first        | new_username_last | new_username_full                      |
      | Phoenix smoke test - home | name changed      | Phoenix smoke test - home name changed |
    # Add change country, address, Add check point
    And I save the partner info

  @TC.126124 @bus @regression_test @phoenix @mozyhome @qa
  Scenario: 126124 Update Billing address of MozyHome user - Precondition:@TC.126120
    When I get previous partner info
    When I login as the user on the account.
    And I change my profile attributes to:
      | new_cc_num       | new_cc_type | last_four_digs |
      | 5111991111111121 | MasterCard  | 1121           |
    And I save the partner info

  @TC.126128 @bus @regression_test @phoenix @mozyhome
  Scenario: 126128 update a user name - Precondition:@TC.126120
    When I get previous partner info
    And I login as the user on the account.
    And I change email address to:
      | new email        | password |
      | @new_admin_email | test1234 |
    And I change email address successfully
    """
      Your email change request requires verification. We sent an email to @new_admin_email. Please open the email and click the verification link to confirm this change.
     """
    When I search emails by keywords:
      | subject                   | content                        |
      | Email Change Notification | <%=@partner.admin_info.email%> |
    Then I should see 1 email(s)
    And I retrieve email content by keywords:
      | to                | subject                    |
      | @new_admin_email  | Email Address Verification |
    And I get verify email address from email content for mozyhome change email address
    Then verify email address link should show success message
    And I log into phoenix with username @new_admin_email and password test1234
    And I save the partner info

  @TC.126133 @bus @regression_test @phoenix @mozyhome
  Scenario: 126133 Mozyhome user change password - Precondition:@TC.126120
    When I get previous partner info
    When I login as the user on the account.
    And I change my profile attributes to:
      | new_password |
      | Naich4yei8   |
    #And I logout of my user account
    And I login under changed password on the account.

  @TC.126137 @bus @regression_test @phoenix @mozyhome
  Scenario: 126137 view home user detail in BUS - Precondition:@TC.126120
    When I get previous partner info
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: | Name:               |
      | MozyHome (change) | @country | @user_name (change) |
    And MozyHome subscription details should be:
      | Subscription                                |
      | MozyHome 50 GB, + 0 GB, 1 machines, monthly |

  @TC.126138 @bus @regression_test @phoenix @mozyhome
  Scenario: 126138 delete home user in BUS - Precondition:@TC.126120
    When I get previous partner info
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user


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
      | base plan | period | admin name                     | coupon                |
      | 50 GB     | 1      | Phoenix smoke test - free2paid | <%=QA_ENV['coupon']%> |
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

  @TC.126121 @bus @mozypro @phoenix @regression_test @us
    Scenario: 126121 Create a MozyPro partner
      When I am at dom selection point:
      And I add a phoenix Pro partner:
        | period | base plan | company name                 | country       | billing country |  coupon                |
        | 1      | 50 GB     | Phoenix smoke test - mozypro |United States | United States   |  <%=QA_ENV['coupon']%> |
      Then the order summary looks like:
        | Description     | Price  | Quantity | Amount |
        | 50 GB - Monthly | $19.99 | 1        | $19.99 |
        | Total Charge    | $19.99 |          | $19.99 |
      And the partner is successfully added.
      And I save the partner info

  @TC.126125 @bus @mozypro @phoenix @regression_test @us
  Scenario: 126125 log in as a pro admin - Precondition:@TC.126121
    When I get previous partner info
    And I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I login as mozypro admin successfully
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name


  @TC.126129 @mozy @phoenix @regression_test
  Scenario: 126129 Verify DL links within CMS content pages
    When I clear downloads folder
    When I go to cms page
    And I download home client
    And I go to cms page
    And I download sync client
    And I go to cms page
    And I download pro client

  @phoenix_cleanup
  Scenario: Delete all the created users and partners
    When I log in bus admin console as administrator
    And I search and delete user account if it exists by Phoenix smoke test - home name changed
    And I search and delete user account if it exists by Phoenix smoke test - home
    And I search and delete user account if it exists by Phoenix smoke test - free2paid
    And I search and delete user account if it exists by Phoenix smoke test - free
    And I search and delete partner account if it exists by Phoenix smoke test - mozypro
