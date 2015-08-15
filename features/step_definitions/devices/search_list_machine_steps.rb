And /^I view machine details for (.+)$/ do |machine_or_user|
  @bus_site.admin_console_page.search_list_machines_section.view_machine_details(machine_or_user)
end

And /^I view Sync details$/ do
  @bus_site.admin_console_page.user_details_section.view_sync_details
end

And /^I refresh Search List Machines section$/ do
  @bus_site.admin_console_page.search_list_machines_section.refresh_bus_section
end