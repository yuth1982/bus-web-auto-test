
Given /^I navigate to add new partner view$/ do
  @bus_admin_console_page.add_new_partner_link.click
end

Given /^I navigate to add new promotion view$/ do
  @bus_admin_console_page.add_new_promo_link.click
end

Given /^I navigate to search list partner view$/ do
  @bus_admin_console_page.search_list_partner_link.click
end

Given /^I navigate to billing information view$/ do
  @bus_admin_console_page.billing_information_link.click
end

When /^I navigate to billing history view$/ do
  @bus_admin_console_page.billing_history_link.click
end

When /^I navigate to purchase resources view$/ do
  @bus_admin_console_page.purchase_resources_link.click
end

When /^I navigate to return unused resources view$/ do
  @bus_admin_console_page.return_unused_resources_link.click
end

When /^I navigate to change subscription view$/ do
  @bus_admin_console_page.billing_info_view.change_subscription_link.click
end

When /^I navigate to account details view$/ do
  @bus_admin_console_page.account_details_link.click
end

When /^I navigate to order data shuttle view$/ do
  @bus_admin_console_page.order_data_shuttle_link.click
end



