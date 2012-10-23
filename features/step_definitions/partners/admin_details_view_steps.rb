# Steps included:
#   click 'Search / List Partners' link
#   fill in newly created admin email and click search
#   click newly created  admin email to get admin detail view
#   click 'Act Admin' link
#   fill in password with default password (in bus config file)
#   fill in confirm password with default password
#   click 'Save Changes'
#
When /^I activate new partner admin with default password$/ do
  @bus_site.admin_console_page.navigate_to_link(CONFIGS['bus']['menu']['search_list_partner'])
  @bus_site.admin_console_page.search_list_partner_section.search_partner(@partner.admin_info.email)
  @bus_site.admin_console_page.search_list_partner_section.view_partner_detail(@partner.admin_info.email)
  password = CONFIGS['global']['test_pwd']
  @bus_site.admin_console_page.admin_details_section.activate_admin(password, password)
end

# Steps included:
#   click 'Search / List Partners' link
#   fill admin email and click search
#   click admin email to get admin detail view
#   click 'Act as' link
#
When /^I act as the partner by (.+) on admin details panel$/ do |admin_email|
  @bus_site.admin_console_page.navigate_to_link(CONFIGS['bus']['menu']['search_list_partner'])
  @bus_site.admin_console_page.search_list_partner_section.search_partner(admin_email)
  @bus_site.admin_console_page.search_list_partner_section.view_partner_detail(admin_email)
  @bus_site.admin_console_page.admin_details_section.act_as_admin
end