
When /^I act as the partner by (.+) on partner details panel/ do |partner_name|
  step "I search partner by #{partner_name}"
  step "I view partner details by #{partner_name}"
  @bus_admin_console_page.partner_details_view.act_as_partner
end

When /^I delete the partner by (.+)$/ do |partner_name|
  step "I search partner by #{partner_name}"
  step "I view partner details by #{partner_name}"
  @bus_admin_console_page.partner_details_view.delete_partner(Bus::DEFAULT_PWD)
end
