
When /^I act as the partner by (.+) on partner details panel/ do |partner_name|
  step "I search partner by #{partner_name}"
  step "I view partner details by #{partner_name}"
  @bus_admin_console_page.partner_details_section.act_as_partner
end

When /^I delete (.+)$/ do |account|
  step "I search partner by #{account[:company_name]}"
  step "I view partner details by #{account[:company_name]}"
  @bus_admin_console_page.partner_details_section.delete_partner(Bus::DEFAULT_PWD)
end
