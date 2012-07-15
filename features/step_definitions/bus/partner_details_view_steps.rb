
When /^I act as the partner by (.+) on partner details panel/ do |partner_name|
  step "I search partner by #{partner_name}"
  step "I view partner details by #{partner_name}"
  @bus_admin_console_page.partner_details_view.act_as_link.click
end

Then /^The number of statements in partner details view should be (\d+)$/ do |number|
  @bus_admin_console_page.partner_details_view.billing_history_table.length.to_s.should == number
end

When /^I find the aria id of the new partner in partner details view$/ do
  step "I search the new partner"
  step "I view the new partner details"
  @aria_id = @bus_admin_console_page.partner_details_view.aria_id
end

Then /^I should see partner VAT number is (.+)$/ do |vat_num|
  @bus_admin_console_page.partner_details_view.vat_number_input.attribute("value").should == vat_num
end

When /^I delete the partner by (.+)$/ do |partner_name|
  step "I search partner by #{partner_name}"
  step "I view partner details by #{partner_name}"
  @bus_admin_console_page.partner_details_view.delete_partner(Bus::DEFAULT_PWD)
end
