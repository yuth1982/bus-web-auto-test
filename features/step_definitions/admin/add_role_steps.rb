When /^I add a new role:$/ do |table|
  # table is a | ATC695 |pending
  role_hash = table.hashes.first
  role = Bus::DataObj::Role.new(role_hash['Type'], role_hash['Name'], role_hash['Parent'])
  @bus_site.admin_console_page.add_new_role_section.add_new_role(role)
end

When /^I check capabilities for the new role:$/ do |table|
  # table is a | Partners: add |pending
  capability_table = table.raw
  @bus_site.admin_console_page.add_new_role_section.add_capabilities(capability_table[1..-1])
end

When /^I check all the capabilities for the new role$/ do
  @bus_site.admin_console_page.role_details_section.add_all_available_capabilities
end

When /^I delete role (.+)$/ do | role_name |
  sleep 5 # Without sleep, the (stop masquerade) link comes back again
  step "I navigate to List Roles section from bus admin console page"
  @bus_site.admin_console_page.list_roles_section.list_role(role_name)
  @bus_site.admin_console_page.role_details_section.delete_role(role_name)
  sleep 1
end

When /^I clean all roles with name which started with "([^"]+)"$/ do |prefix|
  @bus_site.admin_console_page.list_roles_section.wait_until_bus_section_load
  names = @bus_site.admin_console_page.list_roles_section.all_role_name_started_with(prefix).map(&:text)
  Log.debug "to clear #{names.inspect}"
  names.each do |name|
    step %{I delete role #{name}}
  end
end
