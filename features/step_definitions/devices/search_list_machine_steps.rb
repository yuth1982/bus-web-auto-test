And /^I view machine details for (.+)$/ do |machine_name|
  @bus_site.admin_console_page.search_list_machines_section.view_machine_details(machine_name)
end