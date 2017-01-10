Feature: user login via subdomain
  Background:
    Given I log in bus admin console as administrator

  #Dell Root -> MozyEnt ->Root partner -> L1 Partner-> L2 Partner
  @TC.133424 @bus @user @user_login_via_subdomain @regression @smoke
  Scenario: 133424:Partner root's user can login successfully via *.mozy.com under MozyOEM
    # Partner root's subdomain is autotestsubdomaindell, user under Partner root use autotestsubdomaindell to login
    When I go to page https://autotestsubdomaindell.mozy.com/login/user
    And I log in bus admin console with user name mozyautotest+rootuserdell+subdomain@emc.com and password QAP@SSw0rd
    Then I will see the user account page

  @TC.133426 @bus @user @user_login_via_subdomain @regression
  Scenario: 133426:L1 Partner's user can login successfully via dell.mozy.com under MozyOEM
    # L1 Partner has no subdomain, user under L1 Partner use dell.mozy.com to login
    When I go to page https://dell.mozy.com/login/user
    And I log in bus admin console with user name mozyautotest+l1subuserdell+subdomain@emc.com and password QAP@SSw0rd
    Then I will see the user account page

  @TC.133428 @bus @user @user_login_via_subdomain @regression
  Scenario: 133428:L1 Partner 's user can login successfully via *.mozy.com of partner root under MozyOEM
    # L1 Partner has no subdomain, user under L1 Partner use its parent partner's autotestsubdomaindell.mozy.com to login
    When I go to page https://autotestsubdomaindell.mozy.com/login/user
    And I log in bus admin console with user name mozyautotest+l1subuserdell+subdomain@emc.com and password QAP@SSw0rd
    Then I will see the user account page

  @TC.133431 @bus @user @user_login_via_subdomain @regression
  Scenario: 133431:User login successfully via *.mozycom after set subdomain for fedid partner under MozyOEM
    # existing user: jadenadminreauth21@mtdev.mozypro.local, partner:Jaden admin reauth test partner[Do not edit]
    # allow_mozy_com_domain = 't', password:abc!@#123, subdomain: qa12oemdellpull
    # login via qa12oemdellpull.mozypro.com or qa12oemdellpull.mozy.com will result in qa12oemdellpull.mozy.com
    When I go to page https://qa12oemdellpull.mozypro.com
    And I sign in the subdomain Trust.oemdellpullqa12
    And I sign in with user name jadenadminreauth21@mtdev.mozypro.local and password abc!@#123
    Then I will see the user account page
    And I log out bus admin console
    Then ldap admin logout url is https://qa12oemdellpull.mozy.com/login/logout
    When I go to page https://qa12oemdellpull.mozy.com
    And I sign in the subdomain Trust.oemdellpullqa12
    And I sign in with user name jadenadminreauth21@mtdev.mozypro.local and password abc!@#123
    Then I will see the user account page
    And I log out bus admin console
    Then ldap admin logout url is https://qa12oemdellpull.mozy.com/login/logout

