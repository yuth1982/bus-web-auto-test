And /^I click my support$/ do
  @bus_site = BusSite.new
  @bus_site.admin_console_page.contact_section.click_my_support
end

And /^I login my support successfully$/ do
  @bus_site.mysupport_page.logged_in
end
