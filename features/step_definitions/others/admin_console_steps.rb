When /^I navigate to (.+) section from bus admin console page$/ do |link_name|
  @bus_site.admin_console_page.click_link(link_name)
end



