When /^I search aria account by (.+)$/ do |search_key|
  @aria_site.admin_tools_page.navigate_to_link("Accounts")
  @aria_site.admin_tools_page.navigate_to_link("Search")
  @aria_site.admin_tools_page.switch_to_work_frame
  @aria_site.accounts_page.side_menu_section.search_account(search_key)
end