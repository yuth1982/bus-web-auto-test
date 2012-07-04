
When /^I activate parther's admin with default password$/ do
  @bus_admin_console_page.admin_details_view.activate_admin_link.click
  @bus_admin_console_page.admin_details_view.update_password DEFAULT_PWD,DEFAULT_PWD
end


When /^I act as the partner by email (.+) on admin details panel$/ do |partner_email|
  step "I search partner by #{partner_email}"
  step "I view admin details by email #{partner_email}"
  @bus_admin_console_page.admin_details_view.act_as_link.click
end

When /^I act as the new partner on admin details panel$/ do
  step "I act as the partner by email #{@partner.email} on admin details panel"
end

