
When /^I activate parther's admin with default password$/ do
  @bus_admin_console_page.admin_details_view.activate_admin_link.click
  @bus_admin_console_page.admin_details_view.update_password DEFAULT_PWD,DEFAULT_PWD
end
