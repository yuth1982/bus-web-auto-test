Feature: Add a new partner through phoenix

  As a business owner
  I want to create a partner through phoenix
  So that I can organize my business in a way that works for me

  Background:
#---------------------------------------------------------------------------------
# base coverage section:
#   represents a balanced set of coverage
#----------------------------------------test matrix------------------------------
#	partner size:	10        | 50          | 100    | 250      | 500      | 1tb
#	monthly:		ie,sv,cp  | ie          | uk     | fr,sv    | de,sv,hp | us
#	yearly:			uk,sv     | de,sv,nv,cp | us,sv  | ie,nv,hp | fr       | fr,cp
#	biannual:		us,hp     | fr,nv       | de,nv  | de       | uk,nv    | ie,sv
#----------------------------------------test legend------------------------------
#		entries by: country,server/dsk,novat,coupon,hipaa
#
#		key: sv=server, nv=novat, cp=coupon, hp=hipaa
#		coupon code = 10PERCENTOFFOUTLINE
#
#     base smoke test = us yearly, 100gb, server
#---------------------------------------------------------------------------------

  @TC.131001 @phoenix @mozypro @profile_country=us @ip_country=us @billing_country=us
  Scenario: 131001 Add a new US monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country |
      | 1      | 50 GB     | United States | United States   |
    Then the order summary looks like:
      | Description     | Price  | Quantity | Amount |
      | 50 GB - Monthly | $19.99 | 1        | $19.99 |
      | Total Charge    | $19.99 |          | $19.99 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.131002 @phoenix @mozypro @profile_country=us @ip_country=us @billing_country=us
  Scenario: 131002 Add a new US biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country |
      | 24     | 500 GB    | United States | United States   |
    Then the order summary looks like:
      | Description       | Price     | Quantity | Amount    |
      | 500 GB - Biennial | $3,989.79 | 1        | $3,989.79 |
      | Total Charge      | $3,989.79 |          | $3,989.79 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.131003 @phoenix @mozypro @profile_country=us @ip_country=fr @billing_country=us
  Scenario: 131003 Add a new US biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country |
      | 12     | 50 GB     | United States | United States   |
    Then the order summary looks like:
      | Description    | Price   | Quantity | Amount  |
      | 50 GB - Annual | $219.89 | 1        | $219.89 |
      | Total Charge   | $219.89 |          | $219.89 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.131004 @phoenix @mozypro @profile_country=us @ip_country=fr @billing_country=us
  Scenario: 131004 Add a new US biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country |
      | 12     | 500 GB    | United States | United States   |
    Then the order summary looks like:
      | Description     | Price     | Quantity | Amount    |
      | 500 GB - Annual | $2,089.89 | 1        | $2,089.89 |
      | Total Charge    | $2,089.89 |          | $2,089.89 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.131005 @phoenix @mozypro @profile_country=us @ip_country=us @billing_country=fr
  Scenario: 131005 Add a new US biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country |
      | 24     | 50 GB     | United States | France          |
    Then the order summary looks like:
      | Description      | Price   | Quantity | Amount  |
      | 50 GB - Biennial | $419.79 | 1        | $419.79 |
      | Total Charge     | $419.79 |          | $419.79 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.131006 @phoenix @mozypro @profile_country=us @ip_country=us @billing_country=fr
  Scenario: 131006 Add a new US biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | server plan |
      | 24     | 250 GB    | United States | France          | yes         |
    Then the order summary looks like:
      | Description            | Price     | Quantity | Amount    |
      | 250 GB - Biennial      | $1,994.79 | 1        | $1,994.79 |
      | Server Plan - Biennial | $335.79   | 1        | $335.79   |
      | Total Charge           | $2,330.58 |          | $2,330.58 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.131007 @phoenix @mozypro @profile_country=us @ip_country=us @billing_country=fr
  Scenario: 131007 Add a new US monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | coupon              |
      | 1      | 500 GB    | United States | France          | 10PERCENTOFFOUTLINE |
    Then the order summary looks like:
      | Description        | Price    | Quantity | Amount   |
      | 500 GB - Monthly   | $189.99  | 1        | $189.99  |
      | Subscription Price | $189.99  |          | $189.99  |
      | Discounts          | - $19.00 |          | - $19.00 |
      | Total Charge       | $170.99  |          | $170.99  |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.131008 @phoenix @mozypro @profile_country=us @ip_country=us @billing_country=fr
  Scenario: 131008 Add a new US annual basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | server plan | coupon              |
      | 12     | 500 GB    | United States | France          | yes         | 10PERCENTOFFOUTLINE |
    Then the order summary looks like:
      | Description          | Price     | Quantity | Amount    |
      | 500 GB - Annual      | $2,089.89 | 1        | $2,089.89 |
      | Server Plan - Annual | $219.89   | 1        | $219.89   |
      | Subscription Price   | $2,309.78 |          | $2,309.78 |
      | Discounts            | - $230.98 |          | - $230.98 |
      | Total Charge         | $2,078.80 |          | $2,078.80 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.131009 @phoenix @mozypro @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 131009 Add a new US monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country |
      | 1      | 100 GB    | United States | China           |
    Then the order summary looks like:
      | Description      | Price  | Quantity | Amount |
      | 100 GB - Monthly | $39.99 | 1        | $39.99 |
      | Total Charge     | $39.99 |          | $39.99 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.131010 @phoenix @mozypro @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 131010 Add a new US biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country |
      | 24     | 250 GB    | United States | China           |
    Then the order summary looks like:
      | Description            | Price     | Quantity | Amount    |
      | 250 GB - Biennial      | $1,994.79 | 1        | $1,994.79 |
      | Total Charge           | $1,994.79 |          | $1,994.79 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.131011 @phoenix @mozypro @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 131004 Add a new US annual basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country |
      | 12     | 100 GB    | United States | China           |
    Then the order summary looks like:
      | Description     | Price   | Quantity | Amount  |
      | 100 GB - Annual | $439.89 | 1        | $439.89 |
      | Total Charge    | $439.89 |          | $439.89 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.131012 @phoenix @mozypro @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 131004 Add a new US annual basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country |
      | 12     | 250 GB    | United States | China           |
    Then the order summary looks like:
      | Description     | Price     | Quantity | Amount    |
      | 250 GB - Annual | $1,044.89 | 1        | $1,044.89 |
      | Total Charge    | $1,044.89 |          | $1,044.89 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.131013 @phoenix @mozypro @profile_country=us @ip_country=cn @billing_country=fr
  Scenario: 131013 Add a new US biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country |
      | 24     | 100 GB    | United States | France          |
    Then the order summary looks like:
      | Description            | Price   | Quantity | Amount  |
      | 100 GB - Biennial      | $839.79 | 1        | $839.79 |
      | Total Charge           | $839.79 |          | $839.79 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.131014 @phoenix @mozypro @profile_country=us @ip_country=cn @billing_country=fr
  Scenario: 131014 Add a new US monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country |
      | 1      | 250 GB    | United States | France          |
    Then the order summary looks like:
      | Description      | Price  | Quantity | Amount |
      | 250 GB - Monthly | $94.99 | 1        | $94.99 |
      | Total Charge     | $94.99 |          | $94.99 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name
