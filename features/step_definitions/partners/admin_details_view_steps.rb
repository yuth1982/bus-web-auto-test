
When /^I activate new partner admin with default password$/ do
  step "I navigate to Search / List Partners section from bus admin console page"
  @bus_site.admin_console_page.search_list_partner_section.search_partner(@partner.admin_info.email)
  @bus_site.admin_console_page.search_list_partner_section.view_partner_detail(@partner.admin_info.email)
  @bus_site.admin_console_page.admin_details_section.activate_admin(Bus::DEFAULT_PWD,Bus::DEFAULT_PWD)
end

When /^I act as the partner by (.+) on admin details panel$/ do |partner_email|
  step "I navigate to Search / List Partners section from bus admin console page"
  @bus_site.admin_console_page.search_list_partner_section.search_partner(partner_email)
  @bus_site.admin_console_page.search_list_partner_section.view_partner_detail(partner_email)
  @bus_site.admin_console_page.admin_details_section.act_as_admin
end