Feature: Add a new user through phoenix

  As a private citizen
  I want to create a user account through phoenix
  So that I can organize my personal life in a way that works for me

  Background:
  # info to be added here: coverage matrix

  @TC.138001 @phoenix @mozypro @profile_country=at @ip_country=at @billing_country=at
  Scenario: 138001 Add a new AT monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 GB    | Austria | Österreich      |
    Then the billing summary looks like:
      | Beschreibung                                   | Preis  | Menge |
      | MozyHome 125 GB (Bis zu 3 Computer) - jährlich | 82,41€ | 1     |
      | Betrag:                                        | 82,41€ |       |
      | VAT Rate (20.0%):                              | 16,48€ |       |
      | Gesamtbelastung:                               | 98,89€ |       |
    Then the user is successfully added.

  @TC.138002 @phoenix @mozypro @profile_country=be @ip_country=be @billing_country=be
  Scenario: 138002 Add a new BE monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 Go    | Belgium | Belgique        |
    Then the billing summary looks like:
      | Description                                      | Prix   | Quantité |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Annuel | 81,73€ | 1        |
      | Montant:                                         | 81,73€ |          |
      | VAT Rate (21.0%):                                | 17,16€ |          |
      | Montant total des frais:                         | 98,89€ |          |
    Then the user is successfully added.

  @TC.138003 @phoenix @mozypro @profile_country=bg @ip_country=bg @billing_country=bg
  Scenario: 138003 Add a new BG monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country  | billing country |
      | 12     | 125 GB    | Bulgaria | Bulgaria        |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity |
      | MozyHome 125 GB (Up to 3 computers) - Annual | €82.41 | 1        |
      | Amount:                                      | €82.41 |          |
      | VAT Rate (20.0%):                            | €16.48 |          |
      | Total Charge:                                | €98.89 |          |
    Then the user is successfully added.

  @TC.138004 @phoenix @mozypro @profile_country=hr @ip_country=hr @billing_country=hr
  Scenario: 138004 Add a new HR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 GB    | Croatia | Croatia         |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity |
      | MozyHome 125 GB (Up to 3 computers) - Annual | €79.11 | 1        |
      | Amount:                                      | €79.11 |          |
      | VAT Rate (25.0%):                            | €19.78 |          |
      | Total Charge:                                | €98.89 |          |
    Then the user is successfully added.

  @TC.138005 @phoenix @mozypro @profile_country=cy @ip_country=cy @billing_country=cy
  Scenario: 138005 Add a new CY monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 GB    | Cyprus  | Cyprus          |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity |
      | MozyHome 125 GB (Up to 3 computers) - Annual | €83.10 | 1        |
      | Amount:                                      | €83.10 |          |
      | VAT Rate (19.0%):                            | €15.79 |          |
      | Total Charge:                                | €98.89 |          |
    Then the user is successfully added.

  @TC.138006 @phoenix @mozypro @profile_country=cz @ip_country=cz @billing_country=cz
  Scenario: 138006 Add a new DK monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country        | billing country |
      | 12     | 125 GB    | Czech Republic | Czech Republic  |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity |
      | MozyHome 125 GB (Up to 3 computers) - Annual | €81.73 | 1        |
      | Amount:                                      | €81.73 |          |
      | VAT Rate (21.0%):                            | €17.16 |          |
      | Total Charge:                                | €98.89 |          |
    Then the user is successfully added.

  @TC.138007 @phoenix @mozypro @profile_country=dk @ip_country=dk @billing_country=dk
  Scenario: 138007 Add a new DK monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 GB    | Denmark | Denmark         |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity |
      | MozyHome 125 GB (Up to 3 computers) - Annual | €79.11 | 1        |
      | Amount:                                      | €79.11 |          |
      | VAT Rate (25.0%):                            | €19.78 |          |
      | Total Charge:                                | €98.89 |          |
    Then the user is successfully added.

  @TC.138008 @phoenix @mozypro @profile_country=ee @ip_country=ee @billing_country=ee
  Scenario: 138008 Add a new EE monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 GB    | Estonia | Estonia         |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity |
      | MozyHome 125 GB (Up to 3 computers) - Annual | €82.41 | 1        |
      | Amount:                                      | €82.41 |          |
      | VAT Rate (20.0%):                            | €16.48 |          |
      | Total Charge:                                | €98.89 |          |
    Then the user is successfully added.

  @TC.138009 @phoenix @mozypro @profile_country=fi @ip_country=fi @billing_country=fi
  Scenario: 138009 Add a new FI monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 GB    | Finland | Finland         |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity |
      | MozyHome 125 GB (Up to 3 computers) - Annual | €79.75 | 1        |
      | Amount:                                      | €79.75 |          |
      | VAT Rate (24.0%):                            | €19.14 |          |
      | Total Charge:                                | €98.89 |          |
    Then the user is successfully added.

  @TC.138010 @phoenix @mozypro @profile_country=de @ip_country=de @billing_country=de
  Scenario: 138010 Add a new DE monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 GB    | Germany | Deutschland     |
    Then the billing summary looks like:
      | Beschreibung                                   | Preis  | Menge |
      | MozyHome 125 GB (Bis zu 3 Computer) - jährlich | 83,10€ | 1     |
      | Betrag:                                        | 83,10€ |       |
      | VAT Rate (19.0%):                              | 15,79€ |       |
      | Gesamtbelastung:                               | 98,89€ |       |
    Then the user is successfully added.

  @TC.138011 @phoenix @mozypro @profile_country=el @ip_country=el @billing_country=el
  Scenario: 138011 Add a new EL monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 GB    | Greece  | Greece          |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity |
      | MozyHome 125 GB (Up to 3 computers) - Annual | €80.40 | 1        |
      | Amount:                                      | €80.40 |          |
      | VAT Rate (23.0%):                            | €18.49 |          |
      | Total Charge:                                | €98.89 |          |
    Then the user is successfully added.

  @TC.138012 @phoenix @mozypro @profile_country=hu @ip_country=hu @billing_country=hu
  Scenario: 138012 Add a new HU monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 GB    | Hungary | Hungary         |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity |
      | MozyHome 125 GB (Up to 3 computers) - Annual | €78.87 | 1        |
      | Amount:                                      | €78.87 |          |
      | VAT Rate (27.0%):                            | €20.02 |          |
      | Total Charge:                                | €98.89 |          |
    Then the user is successfully added.

  @TC.138013 @phoenix @mozypro @profile_country=ie @ip_country=ie @billing_country=ie
  Scenario: 138013 Add a new IE monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 GB    | Ireland | Ireland         |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity |
      | MozyHome 125 GB (Up to 3 computers) - Annual | €80.40 | 1        |
      | Amount:                                      | €80.40 |          |
      | VAT Rate (23.0%):                            | €18.49 |          |
      | Total Charge:                                | €98.89 |          |
    Then the user is successfully added.

  @TC.138014 @phoenix @mozypro @profile_country=it @ip_country=it @billing_country=it
  Scenario: 138014 Add a new IE monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 GB    | Italy   | Italy           |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity |
      | MozyHome 125 GB (Up to 3 computers) - Annual | €81.06 | 1        |
      | Amount:                                      | €81.06 |          |
      | VAT Rate (22.0%):                            | €17.83 |          |
      | Total Charge:                                | €98.89 |          |
    Then the user is successfully added.

  @TC.138015 @phoenix @mozypro @profile_country=lv @ip_country=lv @billing_country=lv
  Scenario: 138015 Add a new LV monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 GB    | Latvia  | Latvia          |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity |
      | MozyHome 125 GB (Up to 3 computers) - Annual | €81.73 | 1        |
      | Amount:                                      | €81.73 |          |
      | VAT Rate (21.0%):                            | €17.16 |          |
      | Total Charge:                                | €98.89 |          |
    Then the user is successfully added.

  @TC.138016 @phoenix @mozypro @profile_country=lt @ip_country=lt @billing_country=lt
  Scenario: 138016 Add a new LT monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country   | billing country |
      | 12     | 125 GB    | Lithuania | Lithuania       |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity |
      | MozyHome 125 GB (Up to 3 computers) - Annual | €81.73 | 1        |
      | Amount:                                      | €81.73 |          |
      | VAT Rate (21.0%):                            | €17.16 |          |
      | Total Charge:                                | €98.89 |          |
    Then the user is successfully added.

  @TC.138017 @phoenix @mozypro @profile_country=lu @ip_country=lu @billing_country=lu
  Scenario: 138017 Add a new LU monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country    | billing country |
      | 12     | 125 Go    | Luxembourg | Luxembourg      |
    Then the billing summary looks like:
      | Description                                      | Prix   | Quantité |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Annuel | 85,99€ | 1        |
      | Montant:                                         | 85,99€ |          |
      | VAT Rate (15.0%):                                | 12,90€ |          |
      | Montant total des frais:                         | 98,89€ |          |
    Then the user is successfully added.

  @TC.138018 @phoenix @mozypro @profile_country=mt @ip_country=mt @billing_country=mt
  Scenario: 138018 Add a new MT monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 GB    | Malta   | Malta           |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity |
      | MozyHome 125 GB (Up to 3 computers) - Annual | €83.81 | 1        |
      | Amount:                                      | €83.81 |          |
      | VAT Rate (18.0%):                            | €15.08 |          |
      | Total Charge:                                | €98.89 |          |
    Then the user is successfully added.

  @TC.138019 @phoenix @mozypro @profile_country=nl @ip_country=nl @billing_country=nl
  Scenario: 138019 Add a new NL monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country     | billing country |
      | 12     | 125 GB    | Netherlands | Netherlands     |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity |
      | MozyHome 125 GB (Up to 3 computers) - Annual | €81.73 | 1        |
      | Amount:                                      | €81.73 |          |
      | VAT Rate (21.0%):                            | €17.16 |          |
      | Total Charge:                                | €98.89 |          |
    Then the user is successfully added.

  @TC.138020 @phoenix @mozypro @profile_country=pl @ip_country=pl @billing_country=pl
  Scenario: 138020 Add a new PL monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 GB    | Poland  | Poland          |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity |
      | MozyHome 125 GB (Up to 3 computers) - Annual | €80.40 | 1        |
      | Amount:                                      | €80.40 |          |
      | VAT Rate (23.0%):                            | €18.49 |          |
      | Total Charge:                                | €98.89 |          |
    Then the user is successfully added.

  @TC.138021 @phoenix @mozypro @profile_country=pt @ip_country=pt @billing_country=pt
  Scenario: 138021 Add a new PT monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country  | billing country |
      | 12     | 125 GB    | Portugal | Portugal          |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity |
      | MozyHome 125 GB (Up to 3 computers) - Annual | €80.40 | 1        |
      | Amount:                                      | €80.40 |          |
      | VAT Rate (23.0%):                            | €18.49 |          |
      | Total Charge:                                | €98.89 |          |
    Then the user is successfully added.

  @TC.138022 @phoenix @mozypro @profile_country=ro @ip_country=ro @billing_country=ro
  Scenario: 138022 Add a new RO monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 GB    | Romania | Romania         |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity |
      | MozyHome 125 GB (Up to 3 computers) - Annual | €79.75 | 1        |
      | Amount:                                      | €79.75 |          |
      | VAT Rate (24.0%):                            | €19.14 |          |
      | Total Charge:                                | €98.89 |          |
    Then the user is successfully added.

  @TC.138023 @phoenix @mozypro @profile_country=sk @ip_country=sk @billing_country=sk
  Scenario: 138023 Add a new SK monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country  | billing country |
      | 12     | 125 GB    | Slovakia | Slovakia        |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity |
      | MozyHome 125 GB (Up to 3 computers) - Annual | €82.41 | 1        |
      | Amount:                                      | €82.41 |          |
      | VAT Rate (20.0%):                            | €16.48 |          |
      | Total Charge:                                | €98.89 |          |
    Then the user is successfully added.

  @TC.138024 @phoenix @mozypro @profile_country=si @ip_country=si @billing_country=si
  Scenario: 138024 Add a new SI monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country  | billing country |
      | 12     | 125 GB    | Slovenia | Slovenia        |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity |
      | MozyHome 125 GB (Up to 3 computers) - Annual | €81.06 | 1        |
      | Amount:                                      | €81.06 |          |
      | VAT Rate (22.0%):                            | €17.83 |          |
      | Total Charge:                                | €98.89 |          |
    Then the user is successfully added.

  @TC.138025 @phoenix @mozypro @profile_country=es @ip_country=es @billing_country=es
  Scenario: 138025 Add a new ES monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 GB    | Spain   | Spain           |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity |
      | MozyHome 125 GB (Up to 3 computers) - Annual | €81.73 | 1        |
      | Amount:                                      | €81.73 |          |
      | VAT Rate (21.0%):                            | €17.16 |          |
      | Total Charge:                                | €98.89 |          |
    Then the user is successfully added.

  @TC.138026 @phoenix @mozypro @profile_country=se @ip_country=se @billing_country=se
  Scenario: 138026 Add a new SE monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 GB    | Sweden  | Sweden          |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity |
      | MozyHome 125 GB (Up to 3 computers) - Annual | €79.11 | 1        |
      | Amount:                                      | €79.11 |          |
      | VAT Rate (25.0%):                            | €19.78 |          |
      | Total Charge:                                | €98.89 |          |
    Then the user is successfully added.

  @TC.138027 @phoenix @mozypro @profile_country=UK @ip_country=UK @billing_country=UK
  Scenario: 138027 Add a new UK monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country        | billing country |
      | 12     | 125 GB    | United Kingdom | United Kingdom  |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity |
      | MozyHome 125 GB (Up to 3 computers) - Annual | £82.41 | 1        |
      | Amount:                                      | £82.41 |          |
      | VAT Rate (20.0%):                            | £16.48 |          |
      | Total Charge:                                | £98.89 |          |
    Then the user is successfully added.
