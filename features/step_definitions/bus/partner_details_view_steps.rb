
When /^I act as newly created partner/ do
  @bus_admin_console_page.partner_details_section.act_as_partner
end

When /^I delete the new partner account$/ do
  step "I search partner by #{@partner.company_info.name}"
  step "I view partner details by #{@partner.company_info.name}"
  @bus_admin_console_page.partner_details_section.delete_partner(Bus::DEFAULT_PWD)
end
