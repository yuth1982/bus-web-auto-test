
When /^I act as the partner by (.+) on partner details panel/ do |partner_name|
  step "I search partner by #{partner_name}"
  step "I view partner details by #{partner_name}"
  @bus_admin_console_page.partner_details_section.act_as_partner
end

When /^I delete the new partner account$/ do
  step "I search partner by #{@partner.company_info.name}"
  step "I view partner details by #{@partner.company_info.name}"
  @bus_admin_console_page.partner_details_section.delete_partner(Bus::DEFAULT_PWD)
end
