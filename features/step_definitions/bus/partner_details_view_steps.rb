
When /^I masquerade as the partner (.+)$/ do |partner_name|
  # In bus, partner details view will show up after admin creates a partner.
  # In Selenium, I search the newly created partner and click partner name to view partner details,
  # this steps keep simulation stable
  step "I search partner by #{partner_name}"
  step "I view partner details by #{partner_name}"
  @bus_admin_console_page.partner_details_view.act_as_link.click
end

When /^I masquerade as the new partner$/ do
  step "I masquerade as the partner #{@partner.company_name}"
end

#When /^I navigate to (.+) partner billing information through partner detail view$/ do |partner_name|
#  if partner_name == "the new"
#    partner_name = @partner.company_name
#  end
#  step "I search partner by #{partner_name}"
#  step "I view partner details by #{partner_name}"
#  @bus_admin_console_page.partner_details_view.billing_info_link.click
#  sleep 10
#end

When /^I view the top one invoice in partner details view$/ do
  @bus_admin_console_page.partner_details_view.top_one_invoice_link.click
end

Then /^The number of statements in partner details view should be (\d+)$/ do |number|
  @bus_admin_console_page.partner_details_view.billing_statements.length.to_s.should == number
end

Then /^The statements table header in partner details view should be (.+)$/ do |header|
  @bus_admin_console_page.partner_details_view.billing_statements_table_head.should == header
end

Then /^The statements in partner details view should be (.+)$/ do |invoice|
  @bus_admin_console_page.partner_details_view.billing_statements.should == invoice
end

Then /^The statements in partner details view should match a pattern$/ do
  @bus_admin_console_page.partner_details_view.billing_statements.should match(/\d{2}\/\d{2}\/\d{2} \$\d+.\d+ \$\d+.\d+ \$0.00+ \d+/)
end

Then /^License types table header should be (.+)$/ do |header|
  @bus_admin_console_page.partner_details_view.license_types_thead.should == header
end

Then /^License desktop content should be (.+)$/ do |content|
  @bus_admin_console_page.partner_details_view.license_desktop.should == content
end

Then /^License server content should be (.+)$/ do |content|
  @bus_admin_console_page.partner_details_view.license_server.should == content
end

When /^I find the aria id of the new partner in partner details view$/ do
  step "I search the new partner"
  step "I view the new partner details"
  @aria_id = @bus_admin_console_page.partner_details_view.aria_id
end

Then /^I should see partner VAT number is (.+)$/ do |vat_num|
  @bus_admin_console_page.partner_details_view.vat_number_input.attribute("value").should == vat_num
end