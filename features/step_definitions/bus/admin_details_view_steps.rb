
When /^I activate new partner admin with default password$/ do
  step "I search partner by the new partner email"
  step "I view admin details by the new partner email"
  @bus_admin_console_page.admin_details_view.activate_admin_link.click
  @bus_admin_console_page.admin_details_view.update_password Bus::DEFAULT_PWD,Bus::DEFAULT_PWD
  sleep 10
end

When /^I act as the partner by (.+) on admin details panel$/ do |partner_email|
  step "I search partner by the new partner email"
  step "I view admin details by the new partner email"
  @bus_admin_console_page.admin_details_view.act_as_link.click
  # wait for left navigation menu to be loaded
  @bus_admin_console_page.stop_masquerading.displayed?
end

When /^I act as the new partner on admin details panel$/ do
  step "I act as the partner by the new partner email on admin details panel"
end

