
When /^I activate new partner admin with default password$/ do
  step "I navigate to Search / List Partners section from bus admin console page"
  @bus_admin_console_page.search_list_partner_section.search_partner(@partner.admin_info.email)
  @bus_admin_console_page.search_list_partner_section.view_partner_detail(@partner.admin_info.email)
  @bus_admin_console_page.admin_details_section.activate_admin(Bus::DEFAULT_PWD,Bus::DEFAULT_PWD)
end

