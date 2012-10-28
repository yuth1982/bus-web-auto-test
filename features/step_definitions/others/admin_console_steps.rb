When /^I navigate to (.+) section from bus admin console page$/ do |link_name|
  @bus_site.admin_console_page.navigate_to_link(link_name)
end

When /^I close Mozy Stash invitation popup window$/ do
  @bus_site.admin_console_page.close_stash_invitation_popup
end

