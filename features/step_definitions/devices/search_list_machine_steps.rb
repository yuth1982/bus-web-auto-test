And /^I view machine details for (.+)$/ do |machine_name|
  @bus_site.admin_console_page.search_list_machines_section.view_machine_details(machine_name)
end

And /^I view Sync details$/ do
  @bus_site.admin_console_page.user_details_section.view_sync_details
end