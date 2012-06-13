
When /^I return resources (\d+),(\d+),(\d+),(\d+)$/ do |server_lic_num, server_quota, desktop_lic_num, desktop_quota|
  step "I navigate to return unused resources view"
  @bus_admin_console_page.return_resources_view.return server_lic_num,server_quota,desktop_lic_num,desktop_quota
end
