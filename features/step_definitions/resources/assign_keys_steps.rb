When /^I assign (Desktop|Server) key to user (.+) on (.+)$/ do |type, email, user_group|
  @bus_site.admin_console_page.assign_keys_section.click_user_group(user_group)
  @key = @bus_site.admin_console_page.assign_keys_section.assign_keys_to_email(type, email)
  @bus_site.admin_console_page.assign_keys_section.click_assign_button
end


