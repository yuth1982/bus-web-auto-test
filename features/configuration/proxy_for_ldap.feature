Feature: Proxy for LDAP queries

  As the Operations/Security team
  We want outbound LDAP requests to go through a dynamically-updated proxy server
  So that we don't have to punch holes in our firewall for every FedId customer

  Background:
    Given I log in bus admin console as administrator

  @FID11.1006 @TC.19194
  Scenario: [Test connection][UI][N]Test failed with 400 when I input invalid data
    When I act as partner by:
      | email                          |
      | congshanl+fedid+proxy@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | 10.135.15            | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| wrong password|
    And I save the changes
    Then The save error message should be:
      | Save failed  |
      | Invalid data.|

  @FID11.1006 @TC.19196
  Scenario: [Test connection][UI][N]Test failed with 200 when I input valid data but meet with other failure
    When I act as partner by:
      | email                          |
      | congshanl+fedid+proxy@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | 10.135.16.154        | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| wrong password|
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test failed. Error: Could not connect to the AD server. Reason: BIND failed. Please verify you entered the correct BIND settings.

  @FID11.1006 @TC.19203
  Scenario: [Update whitelists][P]The whitelist(sockd.conf) add 1 item after adding 1 new IP/port in the UI
    When I act as partner by:
      | email                          |
      | congshanl+fedid+proxy@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      |                      | No SSL   |          |      | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into old_whitelist
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | @host_address        | No SSL   |          | @port  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    And I get the full whitelist into new_whitelist
    Then 1 Server Host and Port are added to the whitelist according to old_whitelist and new_whitelist
    And The new Server Host and Port should be the same as input according to old_whitelist and new_whitelist
    When I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | ad01.qa5.mozyops.com | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed

  @FID11.1006 @TC.19204
  Scenario: [Update whitelists][P]The whitelist delete 1 item after deleting 1 new IP/port
    When I act as partner by:
      | email                          |
      | congshanl+fedid+proxy@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | @host_address        | No SSL   |          | @port  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into old_whitelist
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      |                      | No SSL   |          |      | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into new_whitelist
    Then 1 Server Host and Port are deleted to the whitelist according to old_whitelist and new_whitelist
    When I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | ad01.qa5.mozyops.com | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed

  @FID11.1006 @TC.19205
  Scenario: [Update whitelists][P]The whitelist is updated after updating 1 new IP/port
    When I act as partner by:
      | email                          |
      | congshanl+fedid+proxy@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | @host_address        | No SSL   |          | @port  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I get the full whitelist into old_whitelist
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | @host_address        | No SSL   |          | @port  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into new_whitelist
    Then 1 Server Host and Port are updated to the whitelist according to old_whitelist and new_whitelist
    And The new Server Host and Port should be the same as input according to old_whitelist and new_whitelist
    When I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | ad01.qa5.mozyops.com | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed

  @FID11.1006 @TC.19206
  Scenario: [Update whitelists][N]The whitelist should stay intact if I save the changes multi times
    When I act as partner by:
      | email                          |
      | congshanl+fedid+proxy@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    When I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | ad01.qa5.mozyops.com | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I get the full whitelist into old_whitelist
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I get the full whitelist into new_whitelist
    Then 0 Server Host and Port are updated to the whitelist according to old_whitelist and new_whitelist
    When I Test Connection for AD
    Then test connection message should be Test passed

  @FID11.1006 @TC.19207
  Scenario: [Update whitelists][P]The whitelist add 2 items after adding different new IP/port in two partners
    When I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+1@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      |                      | No SSL   |          |      | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into old_whitelist
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | @host_address        | No SSL   |          | @port  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I stop masquerading
    And I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+2@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      |                      | No SSL   |          |      | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | @host_address        | No SSL   |          | @port  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into new_whitelist
    Then 2 Server Host and Port are added to the whitelist according to old_whitelist and new_whitelist
    When I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | ad01.qa5.mozyops.com | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed

  @FID11.1006 @TC.19208
  Scenario: [Update whitelists][P]The whitelist add 1 item after adding the same IP/port in two partners
    When I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+1@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      |                      | No SSL   |          |      | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into old_whitelist
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 1.1.1.1              | No SSL   |          | 111    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I stop masquerading
    And I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+2@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      |                      | No SSL   |          |      | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 1.1.1.1              | No SSL   |          | 111    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into new_whitelist
    Then 1 Server Host and Port are added to the whitelist according to old_whitelist and new_whitelist
    When I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | ad01.qa5.mozyops.com | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed

  @FID11.1006 @TC.19209
  Scenario: [Update whitelists][P]The whitelist stay intact after deleting 1 IP/port in two partners of same config
    When I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+1@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 1.1.1.1              | No SSL   |          | 111    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I stop masquerading
    And I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+2@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 1.1.1.1              | No SSL   |          | 111    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into old_whitelist
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      |                      | No SSL   |          |      | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into new_whitelist
    Then 0 Server Host and Port are deleted to the whitelist according to old_whitelist and new_whitelist
    When I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | ad01.qa5.mozyops.com | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed

  @FID11.1006 @TC.19210
  Scenario: [Update whitelists][N]The item is deleted in whitelist after deleting all the IP/port in 2 partners
    When I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+1@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 1.1.1.1              | No SSL   |          | 111    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I stop masquerading
    And I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+2@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 1.1.1.1              | No SSL   |          | 111    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into old_whitelist
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      |                      | No SSL   |          |      | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I stop masquerading
    And I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+1@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      |                      | No SSL   |          |      | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into new_whitelist
    Then 1 Server Host and Port are deleted to the whitelist according to old_whitelist and new_whitelist
    When I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | ad01.qa5.mozyops.com | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed

  @FID11.1006 @TC.19211
  Scenario: [Update whitelists][P]1 item is deleted in the whitelist after updating 1 IP/port to the same as that in another partner
    When I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+1@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 1.1.1.1              | No SSL   |          | 111    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I stop masquerading
    And I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+2@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 2.2.2.2              | No SSL   |          | 222    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into old_whitelist
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 1.1.1.1              | No SSL   |          | 111    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into new_whitelist
    Then 1 Server Host and Port are deleted to the whitelist according to old_whitelist and new_whitelist
    When I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | ad01.qa5.mozyops.com | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed

  @FID11.1006 @TC.19212
  Scenario: [Update whitelists][P]1 item is added in the whitelist after updating 1 IP/port in one partner when two partners has the same configure
    When I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+1@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 1.1.1.1              | No SSL   |          | 111    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I stop masquerading
    And I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+2@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 1.1.1.1              | No SSL   |          | 111    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into old_whitelist
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 2.2.2.2              | No SSL   |          | 222    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into new_whitelist
    Then 1 Server Host and Port are added to the whitelist according to old_whitelist and new_whitelist
    When I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | ad01.qa5.mozyops.com | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed

  @FID11.1006 @TC.19213
  Scenario: [Update whitelists][N]The whitelist stay intact if an invalid new IP/port added to it
    When I act as partner by:
      | email                          |
      | congshanl+fedid+proxy@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      |                      | No SSL   |          |      | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into old_whitelist
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 1.1.1                | No SSL   |          | 65536  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then The save error message should be:
      | Save failed  |
      | Invalid data.|
    And I get the full whitelist into new_whitelist
    Then 0 Server Host and Port are added to the whitelist according to old_whitelist and new_whitelist
    When I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | ad01.qa5.mozyops.com | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed