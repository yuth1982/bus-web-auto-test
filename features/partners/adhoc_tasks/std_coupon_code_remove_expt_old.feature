Feature: Requirement #143134 Aria coupon code remove: change period and change plan

  Background:
    Given I log in bus admin console as administrator

  @TC.143134_21 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan monthly USD
    When I add a new MozyPro partner:
      | company name                              | period | base plan | country       |
      | DONOT EDIT MozyPro 10 GB Plan monthly USD | 1      | 10 GB     | United States |
    And New partner should be created

  @TC.143134_22 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan monthly USD exception coupon
    When I add a new MozyPro partner:
      | company name                                               | period | base plan | country       | coupon      |
      | DONOT EDIT MozyPro 10 GB Plan monthly USD exception coupon | 1      | 10 GB     | United States | 10pctoffneverexpire |
    And New partner should be created

  @TC.143134_23 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan yearly Ireland exception coupon
    When I add a new MozyPro partner:
      | company name                                                  | period | base plan | server plan | create under    | country | coupon      | cc number        |
      | DONOT EDIT MozyPro 10 GB Plan yearly Ireland exception coupon | 12     | 10 GB     | yes         | MozyPro Ireland | Ireland | 10pctoffneverexpire | 4319402211111113 |
    And New partner should be created

  @TC.143134_24 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan yearly GBP exception coupon
    When I add a new MozyPro partner:
      | company name                                              | period | base plan | create under | country        | coupon                        | cc number        |
      | DONOT EDIT MozyPro 10 GB Plan yearly GBP exception coupon | 24     | 10 GB     | MozyPro UK   | United Kingdom | 100pctOffInternalTestCustomer | 4916783606275713 |
    And New partner should be created

  @TC.143134_25 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan monthly GBP exception coupon
    When I add a new MozyPro partner:
      | company name                                                | period | base plan | server plan | storage add on 50 gb | create under | country        | coupon      | cc number        |
      | DONOT EDIT MozyPro 250 GB Plan monthly GBP exception coupon | 1      | 250 GB    | yes         | 1                    | MozyPro UK   | United Kingdom | 10pctoffneverexpire | 4916783606275713 |
    And New partner should be created

  @TC.143134_26 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan yearly USD exception coupon
    When I add a new MozyPro partner:
      | company name                                               | period | base plan | country       | coupon      |
      | DONOT EDIT MozyPro 250 GB Plan yearly USD exception coupon | 12     | 250 GB    | United States | 10pctoffneverexpire |
    And New partner should be created

  @TC.143134_27 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan Biennially EUR Germany exception coupon
    When I add a new MozyPro partner:
      | company name                                                           | period | base plan | server plan | create under    | country | cc number        | coupon                        |
      | DONOT EDIT MozyPro 250 GB Plan Biennially EUR Germany exception coupon | 24     | 250 GB    | yes         | MozyPro Germany | Germany | 4188181111111112 | 100pctOffInternalTestCustomer |
    And New partner should be created

  @TC.143134_28 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan monthly GBP VAT exception coupon
    When I add a new MozyPro partner:
      | company name                                                    | period | base plan | create under   | country | vat number    | coupon      | cc number        |
      | DONOT EDIT MozyPro 500 GB Plan monthly GBP VAT exception Coupon | 1      | 500 GB    | MozyPro France | France  | FR08410091490 | 10pctoffneverexpire | 4485393141463880 |
    And New partner should be created

  @TC.143134_29 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan yearly GBP VAT exception coupon NOT execute successfully
    When I add a new MozyPro partner:
      | company name                                                   | period | base plan | server plan | create under | country        | vat number  | coupon      | cc number        |
      | DONOT EDIT MozyPro 500 GB Plan yearly GBP VAT exception Coupon | 12     | 500 GB    | yes         | MozyPro UK   | United Kingdom | GB117223643 | 10pctoffneverexpire | 4916783606275713 |
    And New partner should be created

  @TC.143134_210 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan Biennially USD exception coupon
    When I add a new MozyPro partner:
      | company name                                                   | period | base plan | country       | coupon                        |
      | DONOT EDIT MozyPro 500 GB Plan Biennially USD exception coupon | 24     | 500 GB    | United States | 100pctOffInternalTestCustomer |
    And New partner should be created

  @TC.143134_211 @add_new_partner @mozypro
  Scenario: MozyPro 1 TB Plan monthly USD exception coupon
    When I add a new MozyPro partner:
      | company name                                              | period | base plan | server plan | storage add on | country       | coupon      |
      | DONOT EDIT MozyPro 1 TB Plan monthly USD exception coupon | 1      | 1 TB      | yes         | 2              | United States | 10pctoffneverexpire |
    And New partner should be created

  @TC.143134_212 @add_new_partner @mozypro
  Scenario: MozyPro 1 TB Plan yearly Ireland exception coupon
    When I add a new MozyPro partner:
      | company name                                                 | period | base plan | create under     | country | coupon      | vat number | cc number        |
      | DONOT EDIT MozyPro 1 TB Plan yearly Ireland exception coupon | 12     | 1 TB      | MozyPro Ireland  | Ireland | 10pctoffneverexpire | IE9691104A | 4319402211111113 |
    And New partner should be created

  @TC.143134_213 @add_new_partner @mozypro
  Scenario: MozyPro 1 TB Plan Biennially GBP exception coupon
    When I add a new MozyPro partner:
      | company name                                            | period | base plan | server plan | create under | country        | coupon                        | cc number        |
      | DONOT EDIT MozyPro 1 TB Biennially GBP exception Coupon | 24     | 1 TB      | yes         | MozyPro UK   | United Kingdom | 100pctOffInternalTestCustomer | 4916783606275713 |
    And New partner should be created

  @TC.143134_214 @add_new_partner @mozypro
  Scenario: MozyPro 2 TB Plan monthly GBP exception coupon
    When I add a new MozyPro partner:
      | company name                                         | period | base plan | create under | country        | coupon       | cc number        |
      | DONOT EDIT MozyPro 2 TB monthly GBP exception Coupon | 1      | 2 TB      | MozyPro UK   | United Kingdom | 10pctoffneverexpire  | 4916783606275713 |
    And New partner should be created

  @TC.143134_215 @add_new_partner @mozypro @bus
  Scenario: MozyPro 2 TB Plan yearly USD exception coupon
    When I add a new MozyPro partner:
      | company name                                        | period | base plan | server plan | country       | coupon      |
      | DONOT EDIT MozyPro 2 TB yearly USD exception coupon | 12     | 2 TB      | yes         | United States | 10pctoffneverexpire |
    And New partner should be created

  @TC.143134_216 @add_new_partner @mozypro @bus
  Scenario: MozyPro 2 TB Plan Biennially EUR Germany exception coupon
    When I add a new MozyPro partner:
      | company name                                                    | period | base plan | create under    | country | cc number        | coupon                        |
      | DONOT EDIT MozyPro 2 TB Biennially EUR Germany exception coupon | 24     | 2 TB      | MozyPro Germany | Germany | 4188181111111112 | 100pctOffInternalTestCustomer |
    And New partner should be created

  @TC.143134_217 @add_new_partner @mozypro @bus
  Scenario: MozyPro 4 TB Plan monthly EUR France exception coupon
    When I add a new MozyPro partner:
      | company name                                                   | period | base plan | server plan | create under   | country | cc number        | coupon      |
      | DONOT EDIT MozyPro 4 TB Biennially EUR France exception coupon | 1      | 4 TB      | yes         | MozyPro France | France  | 4485393141463880 | 10pctoffneverexpire |
    And New partner should be created

  @TC.143134_218 @add_new_partner @mozypro
  Scenario: MozyPro 4 TB Plan yearly GBP exception coupon
    When I add a new MozyPro partner:
      | company name                                        | period | base plan | create under | country        | coupon       | cc number        |
      | DONOT EDIT MozyPro 4 TB yearly GBP exception Coupon | 12     | 4 TB      | MozyPro UK   | United Kingdom | 10pctoffneverexpire  | 4916783606275713 |
    And New partner should be created

  @TC.143134_219 @add_new_partner @mozypro @bus
  Scenario: MozyPro 4 TB Plan Biennially USD exception coupon
    When I add a new MozyPro partner:
      | company name                                            | period | base plan | server plan | country       | coupon                        |
      | DONOT EDIT MozyPro 4 TB Biennially USD exception coupon | 24     | 4 TB      | yes         | United States | 100pctOffInternalTestCustomer |
    And New partner should be created

  @TC.143134_220 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB yearly Ireland exception coupon change plan
    When I add a new MozyPro partner:
      | company name                                                         | period | base plan | create under    | country | coupon      | cc number        |
      | DONOT EDIT MozyPro 10 GB yearly Ireland exception coupon change plan | 12     | 10 GB     | MozyPro Ireland | Ireland | 10pctoffneverexpire | 4319402211111113 |
    And New partner should be created

  @TC.143134_221 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan Biennially EUR Germany exception coupon change plan
    When I add a new MozyPro partner:
      | company name                                                                       | period | base plan | create under    | country | cc number        | coupon                        |
      | DONOT EDIT MozyPro 250 GB Plan Biennially EUR Germany exception coupon change plan | 24     | 250 GB    | MozyPro Germany | Germany | 4188181111111112 | 100pctOffInternalTestCustomer |
    And New partner should be created

  @TC.143134_222 @add_new_partner @mozypro @bus
  Scenario: Reseller silver monthly France exception coupon
    When I add a new Reseller partner:
      | company name                                               | period | reseller type | reseller quota | create under   | country | cc number        | coupon      |
      | DONOT EDIT Reseller silver monthly France exception coupon | 1      | Silver        | 100            | MozyPro France | France  | 4485393141463880 | 10pctoffneverexpire |
    And New partner should be created

  @TC.143134_223 @add_new_partner @mozypro @bus
  Scenario: Reseller silver yearly EUR Ireland exception coupon
    When I add a new Reseller partner:
      | company name                                                   | period | reseller type | reseller quota | server plan | storage add on | create under    | vat number | coupon      | country | cc number        |
      | DONOT EDIT Reseller silver yearly EUR Ireland exception coupon | 12     | Silver        | 500            | yes         | 10             | MozyPro Ireland | IE9691104A | 10pctoffneverexpire | Ireland | 4319402211111113 |
    And New partner should be created

  @TC.143134_224 @add_new_partner @mozypro @bus
  Scenario: Reseller gold monthly GBP exception coupon execute manually as wrong sequence of gold and platinum
    When I add a new Reseller partner:
      | company name                                          | period | reseller type | reseller quota | create under | vat number  | coupon                        | country        | cc number        |
      | DONOT EDIT Reseller gold monthly GBP exception coupon | 1      | Gold          | 500            | MozyPro UK   | GB117223643 | 100pctOffInternalTestCustomer | United Kingdom | 4916783606275713 |
    And New partner should be created

  @TC.143134_225 @add_new_partner @mozypro @bus
  Scenario: Reseller gold yearly GBP exception coupon
    When I add a new Reseller partner:
      | company name                                         | period | reseller type | reseller quota | server plan | storage add on | create under | coupon      | country        | cc number        |
      | DONOT EDIT Reseller gold yearly GBP exception coupon | 12     | Gold          | 100            | yes         | 10             | MozyPro UK   | 10pctoffneverexpire | United Kingdom | 4916783606275713 |
    And New partner should be created

  @TC.143134_226 @add_new_partner @mozypro @bus
  Scenario: Reseller platinum monthly USD exception coupon execute manually as wrong sequence of gold and platinum
    When I add a new Reseller partner:
      | company name                                              | period | reseller type | reseller quota | coupon      | country       |
      | DONOT EDIT Reseller platinum monthly USD exception coupon | 1      | Platinum      | 100            | 10pctoffneverexpire | United States |
    And New partner should be created

  @TC.143134_227 @add_new_partner @mozypro @bus
  Scenario: Reseller platinum yearly USD exception coupon
    When I add a new Reseller partner:
      | company name                                             | period | reseller type | reseller quota | server plan | storage add on | coupon                        | country       |
      | DONOT EDIT Reseller platinum yearly USD exception coupon | 12     | Platinum      | 100            | yes         | 10             | 100pctOffInternalTestCustomer | United States |
    And New partner should be created

  @TC.143134_228 @add_new_partner @mozypro @bus
  Scenario: Reseller silver yearly EUR Ireland exception coupon
    When I add a new Reseller partner:
      | company name                                                               | period | reseller type | reseller quota | create under    | vat number | coupon      | country | cc number        |
      | DONOT EDIT Reseller silver yearly EUR Ireland change plan exception coupon | 12     | Silver        | 500            | MozyPro Ireland | IE9691104A | 10pctoffneverexpire | Ireland | 4319402211111113 |
    And New partner should be created

  @TC.143134_229 @add_new_partner @mozypro @bus
  Scenario: Reseller gold yearly GBP exception coupon
    When I add a new Reseller partner:
      | company name                                                     | period | reseller type | reseller quota | create under | coupon      | country        | cc number        |
      | DONOT EDIT Reseller gold yearly GBP exception coupon change plan | 12     | Gold          | 100            | MozyPro UK   | 10pctoffneverexpire | United Kingdom | 4916783606275713 |
    And New partner should be created

  @TC.143134_230 @add_new_partner @mozypro @bus
  Scenario: Reseller platinum yearly USD exception coupon
    When I add a new Reseller partner:
      | company name                                                         | period | reseller type | reseller quota | coupon                        | country       |
      | DONOT EDIT Reseller platinum yearly USD change plan exception coupon | 12     | Platinum      | 100            | 100pctOffInternalTestCustomer | United States |
    And New partner should be created

  @TC.143134_231 @add_new_partner @mozypro @bus
  Scenario: Reseller monthly USD exception coupon without inital purchase
    When I add a new Reseller partner:
      | company name                                             | period | country        | coupon      |
      | DONOT EDIT Reseller monthly USD exception coupon without | 1      | United States  | 10pctoffneverexpire |
    And New partner should be created

  @TC.143134_232 @add_new_partner @mozypro @bus
  Scenario: Reseller monthly France exception coupon without inital purchase
    When I add a new Reseller partner:
      | company name                                                | period | create under   | country | cc number        | coupon      |
      | DONOT EDIT Reseller monthly France exception coupon without | 1      | MozyPro France | France  | 4485393141463880 | 10pctoffneverexpire |
    And New partner should be created

  @TC.143134_233 @add_new_partner @mozypro @bus
  Scenario: Reseller monthly GBP  exception couponwithout inital purchase
    When I add a new Reseller partner:
      | company name                                             | period | create under | country        | coupon      |
      | DONOT EDIT Reseller monthly GBP exception coupon without | 1      | MozyPro UK   | United Kingdom | 10pctoffneverexpire |
    And New partner should be created

  @TC.143134_234 @add_new_partner @mozypro @bus
  Scenario: Reseller yearly USD exception coupon without inital purchase
    When I add a new Reseller partner:
      | company name                                            | period | country        | coupon      |
      | DONOT EDIT Reseller yearly USD exception coupon without | 12     | United States  | 10pctoffneverexpire |
    And New partner should be created

  @TC.143134_235 @add_new_partner @mozypro @bus
  Scenario: Reseller yearly France exception coupon without inital purchase
    When I add a new Reseller partner:
      | company name                                               | period | create under   | country | cc number        | coupon      |
      | DONOT EDIT Reseller yearly France exception coupon without | 12     | MozyPro France | France  | 4485393141463880 | 10pctoffneverexpire |
    And New partner should be created

  @TC.143134_236 @add_new_partner @mozypro @bus
  Scenario: Reseller yearly GBP exception coupon without inital purchase
    When I add a new Reseller partner:
      | company name                                            | period | create under | country        | coupon      |
      | DONOT EDIT Reseller yearly GBP exception coupon without | 12     | MozyPro UK   | United Kingdom | 10pctoffneverexpire |
    And New partner should be created
