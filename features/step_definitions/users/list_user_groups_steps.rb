When /^I view user group details by (.+)$/ do |user_group|
  @bus_site.admin_console_page.list_user_groups_section.view_user_group_detail user_group
end