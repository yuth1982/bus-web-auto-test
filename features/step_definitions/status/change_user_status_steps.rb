# From partner details view, click Status: Active (change) link
# Select Suspended
# Click Submit
When /^I suspend the partner$/ do
  @bus_site.admin_console_page.partner_details_section.suspend_partner
end

# From partner details view, click Status: Active (change) link
# Select Suspended
# Click Submit
When /^I activate the partner$/ do
  @bus_site.admin_console_page.partner_details_section.activate_partner
end