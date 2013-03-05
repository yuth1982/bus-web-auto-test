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

When /^I delete role (.+)$/ do | role_name |
  sleep 5 # Without sleep, the (stop masquerade) link comes back again
  step "I navigate to List Roles section from bus admin console page"
  @bus_site.admin_console_page.list_roles_section.list_role(role_name)
  @bus_site.admin_console_page.role_details_section.delete_role(role_name)
  sleep 1
end