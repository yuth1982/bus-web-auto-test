When /^I navigate to (.+) section from bus admin console page$/ do |link_name|
  @bus_admin_console_page.refresh_page # force to refresh page, make sure destination section is not expanded
  @bus_admin_console_page.navigate_to_link(link_name)
end



