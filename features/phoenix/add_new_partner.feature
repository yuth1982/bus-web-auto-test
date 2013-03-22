Feature: Add a new partner through phoenix

  As a business owner
  I want to create a partner through phoenix
  So that I can organize my business in a way that works for me

  Background:
    Given I am at dom selection point:

  @TC.13502 @smoke @month @sample
    Scenario: 13502 Add a new US monthly basic MozyPro partner
      When I add a phoenix Pro partner:
        | period | base plan | country       | server plan |
        | 1      | 100 GB    | United States | yes         |
      Then the order summary looks like:
        | Description           | Price  | Quantity | Amount |
        | 100 GB - Monthly      | $39.99 | 1        | $39.99 |
        | Server Plan - Monthly | $12.99 | 1        | $12.99 |
        | Total Charge          | $52.98 |          | $52.98 |
      And the partner is successfully added.
      And they have logged in and verified their account.
      And I log in bus admin console as administrator
      And I search partner by:
        | name          | filter |
        | @company_name | None   |
      And I view partner details by newly created partner company name
      And Partner general information should be:
        | Status:         | Root Admin:          | Root Role:                  | Parent: | Next Charge:   | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
        | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro | after 1 month  | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
      And Partner contact information should be:
        | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Contact Email:   |
        | MozyPro       | 0      | @address          | @city         | @state         | @zip_code                | @country         | @new_admin_email |
      And Partner account attributes should be:
        | Backup Licenses         | 400     |
        | Backup License Soft Cap | Enabled |
        | Server Enabled          | Enabled |
        | Cloud Storage (GB)      | 100     |
        | Stash Users:            |         |
        | Default Stash Storage:  |         |
      And Partner resources should be:
        |                     | Used      | Allocated | Limit |
        | Backup Licenses     | 0         | 20        | 400   |
        | Cloud Storage (GB)  | 0         | 100       | 100   |
        | Server Enabled      | Enabled   |           |       |
      And Partner internal billing should be:
        | Account Type:   | Credit Card   | Current Period: | Monthly             |
        | Unpaid Balance: | $0.00         | Collect On:     | N/A                 |
        | Renewal Date:   | after 1 month | Renewal Period: | Use Current Period  |

  @TC.13499 @smoke @year
    Scenario: 13499 Add a new US yearly basic MozyPro partner
      When I add a phoenix Pro partner:
        | period | base plan | country       | server plan |
        | 12     | 100 GB    | United States | yes         |
      Then the order summary looks like:
        | Description            | Price   | Quantity | Amount  |
        | 100 GB - Annual        | $439.89 | 1        | $439.89 |
        | Server Plan - Annual   | $142.89 | 1        | $142.89 |
        | Total Charge           | $582.78 |          | $582.78 |
      And the partner is successfully added.
      And they have logged in and verified their account.

  @TC.13498 @smoke @biennial
    Scenario: 13498 Add a new US biennial basic MozyPro partner
      When I add a phoenix Pro partner:
        | period | base plan | country       | server plan |
        | 24     | 100 GB    | United States | yes         |
      Then the order summary looks like:
        | Description           | Price     | Quantity | Amount    |
        | 100 GB - Biennial     | $839.79   | 1        | $839.79   |
        | Server Plan - Biennial| $272.79   | 1        | $272.79   |
        | Total Charge          | $1,112.58 |          | $1,112.58 |
      And the partner is successfully added.
      And they have logged in and verified their account.

  @TC.13497 @smoke @month @IE
    Scenario: 13497 Add a new IE monthly basic MozyPro partner
      When I add a phoenix Pro partner:
        | period | base plan | country | vat number | server plan |
        | 1      | 100 GB    | Ireland | IE9691104A | yes         |
      Then the order summary looks like:
        | Description            | Price  | Quantity | Amount |
        | 100 GB - Monthly       | €30.99 | 1        | €30.99 |
        | Server Plan - Monthly  | €9.99  | 1        | €9.99  |
        | Subscription Price     | €40.98 |          | €40.98 |
        | VAT                    | €9.43  |          | €9.43  |
        | Total Charge           | €50.41 |          | €50.41 |
      And the partner is successfully added.
      And they have logged in and verified their account.

  @TC.13515 @smoke @year @IE
    Scenario: 13515 Add a new IE yearly basic MozyPro partner
      When I add a phoenix Pro partner:
        | period | base plan | country | vat number | server plan |
        | 12     | 100 GB    | Ireland | IE9691104A | yes         |
      Then the order summary looks like:
        | Description          | Price   | Quantity | Amount  |
        | 100 GB - Annual      | €340.89 | 1        | €340.89 |
        | Server Plan - Annual | €109.89 | 1        | €109.89 |
        | Subscription Price   | €450.78 |          | €450.78 |
        | VAT                  | €103.67 |          | €103.67 |
        | Total Charge         | €554.45 |          | €554.45 |
      And the partner is successfully added.
      And they have logged in and verified their account.

  @TC.13503 @smoke @biennial @IE
    Scenario: 13503 Add a new IE biennial basic MozyPro partner
      When I add a phoenix Pro partner:
        | period | base plan | country | vat number | server plan |
        | 24     | 100 GB    | Ireland | IE9691104A | yes         |
      Then the order summary looks like:
        | Description            | Price     | Quantity | Amount    |
        | 100 GB - Biennial      | €650.79   | 1        | €650.79   |
        | Server Plan - Biennial | €209.79   | 1        | €209.79   |
        | Subscription Price     | €860.58   |          | €860.58   |
        | VAT                    | €197.93   |          | €197.93   |
        | Total Charge           | €1,058.51 |          | €1,058.51 |
      And the partner is successfully added.
      And they have logged in and verified their account.

  @TC.13504 @smoke @year @IE @novat
    Scenario: 13504 Add a new IE yearly basic MozyPro partner without a VAT number
      When I add a phoenix Pro partner:
        | period | base plan | country | vat number | server plan |
        | 12     | 100 GB    | Ireland |            | yes         |
      Then the order summary looks like:
        | Description            | Price   | Quantity | Amount  |
        | 100 GB - Annual        | €340.89 | 1        | €340.89 |
        | Server Plan - Annual   | €109.89 | 1        | €109.89 |
        | Subscription Price     | €450.78 |          | €450.78 |
        | VAT                    | €103.67 |          | €103.67 |
        | Total Charge           | €554.45 |          | €554.45 |
      And the partner is successfully added.
      And they have logged in and verified their account.

  @TC.13507 @smoke @month @UK
    Scenario: 13507 Add a new UK monthly basic MozyPro partner
      When I add a phoenix Pro partner:
        | period | base plan | country        | vat number  | server plan |
        | 1      | 100 GB    | United Kingdom | GB117223643 | yes         |
      Then the order summary looks like:
        | Description            | Price   | Quantity | Amount |
        | 100 GB - Monthly       | £26.99  | 1        | £26.99 |
        | Server Plan - Monthly  | £8.99   | 1        | £8.99  |
        | Subscription Price     | £35.98  |          | £35.98 |
        | VAT                    | Exempt  |          | Exempt |
        | Total Charge           | £35.98  |          | £35.98 |
      And the partner is successfully added.
      And they have logged in and verified their account.
      And I log in bus admin console as administrator

  @TC.13510 @smoke @year @UK
    Scenario: 13510 Add a new UK yearly basic MozyPro partner
      When I add a phoenix Pro partner:
        | period | base plan | country        | vat number  | server plan |
        | 12     | 100 GB    | United Kingdom | GB117223643 | yes         |
      Then the order summary looks like:
        | Description          | Price   | Quantity | Amount  |
        | 100 GB - Annual      | £296.89 | 1        | £296.89 |
        | Server Plan - Annual | £98.89  | 1        | £98.89  |
        | Subscription Price   | £395.78 |          | £395.78 |
        | VAT                  | Exempt  |          | Exempt  |
        | Total Charge         | £395.78 |          | £395.78 |
      And the partner is successfully added.
      And they have logged in and verified their account.

  @TC.13513 @smoke @biennial @UK
    Scenario: 13513 Add a new UK biennial basic MozyPro partner
      When I add a phoenix Pro partner:
        | period | base plan | country        | vat number  | server plan |
        | 24     | 100 GB    | United Kingdom | GB117223643 | yes         |
      Then the order summary looks like:
        | Description            | Price   | Quantity | Amount  |
        | 100 GB - Biennial      | £566.79 | 1        | £566.79 |
        | Server Plan - Biennial | £188.79 | 1        | £188.79 |
        | Subscription Price     | £755.58 |          | £755.58 |
        | VAT                    | Exempt  |          | Exempt  |
        | Total Charge           | £755.58 |          | £755.58 |
      And the partner is successfully added.
      And they have logged in and verified their account.

  @TC.13521 @smoke @year @UK @novat
    Scenario: 13521 Add a new UK yearly basic MozyPro partner without a VAT number
      When I add a phoenix Pro partner:
        | period | base plan | country        | vat number | server plan |
        | 12     | 100 GB    | United Kingdom |            | yes         |
      Then the order summary looks like:
        | Description          | Price   | Quantity | Amount  |
        | 100 GB - Annual      | £296.89 | 1        | £296.89 |
        | Server Plan - Annual | £98.89  | 1        | £98.89  |
        | Subscription Price   | £395.78 |          | £395.78 |
        | VAT                  | £91.02  |          | £91.02  |
        | Total Charge         | £486.80 |          | £486.80 |
      And the partner is successfully added.
      And they have logged in and verified their account.

  @TC.13505 @smoke @month @DE
    Scenario: 13505 Add a new DE monthly basic MozyPro partner
      When I add a phoenix Pro partner:
        | period | base plan | country | vat number  | server plan |
        | 1      | 100 GB    | Germany | DE812321109 | yes         |
      Then the order summary looks like:
        | Beschreibung           | Preis   | Menge  | Betrag  |
        | 100 GB - Monatlich     | 30,99€  | 1      | 30,99€  |
        | Serverplan - Monatlich | 9,99€   | 1      | 9,99€   |
        | Abonnementpreis        | 40,98€  |        | 40,98€  |
        | Umsatzsteuer           | Befreit |        | Befreit |
        | Gesamtbelastung        | 40,98€  |        | 40,98€  |
      And the partner is successfully added.
      And they have logged in and verified their account.

  @TC.13508 @smoke @year @DE
    Scenario: 13508 Add a new DE yearly basic MozyPro partner
      When I add a phoenix Pro partner:
        | period | base plan | country | vat number  | server plan |
        | 12     | 100 GB    | Germany | DE812321109 | yes         |
      Then the order summary looks like:
        | Beschreibung           | Preis   | Menge  | Betrag  |
        | 100 GB - jährlich      | 340,89€ | 1      | 340,89€ |
        | Serverplan - jährlich  | 109,89€ | 1      | 109,89€ |
        | Abonnementpreis        | 450,78€ |        | 450,78€ |
        | Umsatzsteuer           | Befreit |        | Befreit |
        | Gesamtbelastung        | 450,78€ |        | 450,78€ |
      And the partner is successfully added.
      And they have logged in and verified their account.

  @TC.13511 @smoke @biennial @DE
    Scenario: 13511 Add a new DE biennial basic MozyPro partner
      When I add a phoenix Pro partner:
        | period | base plan | country | vat number  | server plan |
        | 24     | 100 GB    | Germany | DE812321109 | yes         |
      Then the order summary looks like:
        | Beschreibung           | Preis   | Menge  | Betrag  |
        | 100 GB - 2-Jahre       | 650,79€ | 1      | 650,79€ |
        | Serverplan - 2-Jahre   | 209,79€ | 1      | 209,79€ |
        | Abonnementpreis        | 860,58€ |        | 860,58€ |
        | Umsatzsteuer           | Befreit |        | Befreit |
        | Gesamtbelastung        | 860,58€ |        | 860,58€ |
      And the partner is successfully added.
      And they have logged in and verified their account.

  @TC.13519 @smoke @year @DE @novat
    Scenario: 13519 Add a new DE yearly basic MozyPro partner without a VAT number
      When I add a phoenix Pro partner:
        | period | base plan | country | vat number  | server plan |
        | 12     | 100 GB    | Germany |             | yes         |
      Then the order summary looks like:
        | Beschreibung           | Preis   | Menge  | Betrag  |
        | 100 GB - jährlich      | 340,89€ | 1      | 340,89€ |
        | Serverplan - jährlich  | 109,89€ | 1      | 109,89€ |
        | Abonnementpreis        | 450,78€ |        | 450,78€ |
        | Umsatzsteuer           | 103,67€ |        | 103,67€ |
        | Gesamtbelastung        | 554,45€ |        | 554,45€ |
      And the partner is successfully added.
      And they have logged in and verified their account.

  @TC.13506 @smoke @month @FR
    Scenario: 13506 Add a new FR monthly basic MozyPro partner
      When I add a phoenix Pro partner:
        | period | base plan | country | vat number    | server plan |
        | 1      | 100 Go    | France  | FR08410091490 | yes         |
      Then the order summary looks like:
        | Description             | Prix      | Quantité  | Montant   |
        | 100 Go - Mensuel        | 30,99€    | 1         | 30,99€    |
        | Plan serveur - Mensuel  | 9,99€     | 1         | 9,99€     |
        | Prix d'abonnement       | 40,98€    |           | 40,98€    |
        | TVA                     | Exemption |           | Exemption |
        | Montant total des frais | 40,98€    |           | 40,98€    |
      And the partner is successfully added.
      And they have logged in and verified their account.

  @TC.13509 @smoke @year @FR
    Scenario: 13509 Add a new FR yearly basic MozyPro partner
      When I add a phoenix Pro partner:
        | period | base plan | country | vat number    | server plan |
        | 12      | 100 Go   | France  | FR08410091490 | yes         |
      Then the order summary looks like:
        | Description             | Prix      | Quantité  | Montant   |
        | 100 Go - Annuel         | 340,89€   | 1         | 340,89€   |
        | Plan serveur - Annuel   | 109,89€   | 1         | 109,89€   |
        | Prix d'abonnement       | 450,78€   |           | 450,78€   |
        | TVA                     | Exemption |           | Exemption |
        | Montant total des frais | 450,78€   |           | 450,78€   |
      And the partner is successfully added.
      And they have logged in and verified their account.

  @TC.13512 @smoke @biennial @FR
    Scenario: 13512 Add a new FR biennial basic MozyPro partner
      When I add a phoenix Pro partner:
        | period | base plan | country | vat number    | server plan |
        | 24      | 100 Go   | France  | FR08410091490 | yes         |
      Then the order summary looks like:
        | Description              | Prix      | Quantité  | Montant   |
        | 100 Go - Bisannuel       | 650,79€   | 1         | 650,79€   |
        | Plan serveur - Bisannuel | 209,79€   | 1         | 209,79€   |
        | Prix d'abonnement        | 860,58€   |           | 860,58€   |
        | TVA                      | Exemption |           | Exemption |
        | Montant total des frais  | 860,58€   |           | 860,58€   |
      And the partner is successfully added.
      And they have logged in and verified their account.

  @TC.13520 @smoke @year @FR @novat
    Scenario: 13520 Add a new FR yearly basic MozyPro partner without a VAT number
      When I add a phoenix Pro partner:
        | period | base plan | country | vat number    | server plan |
        | 12      | 100 Go   | France  |               | yes         |
      Then the order summary looks like:
        | Description             | Prix    | Quantité  | Montant |
        | 100 Go - Annuel         | 340,89€ | 1         | 340,89€ |
        | Plan serveur - Annuel   | 109,89€ | 1         | 109,89€ |
        | Prix d'abonnement       | 450,78€ |           | 450,78€ |
        | TVA                     | 103,67€ |           | 103,67€ |
        | Montant total des frais | 554,45€ |           | 554,45€ |
      And the partner is successfully added.
      And they have logged in and verified their account.