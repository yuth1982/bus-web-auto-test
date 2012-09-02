# Public: Search user
#
# Required column: keywords
# Optional column: filter
#
When /^I search user by:$/ do |search_key_table|
  @bus_site.admin_console_page.click_link(Bus::MENU[:search_list_users])
  attributes = search_key_table.hashes.first
  keywords = attributes["keywords"] || ""
  filter = attributes["filter"] || "None"
  @bus_site.admin_console_page.search_list_users_section.search_user(keywords, filter)
end

Then /^User search results should be:$/ do |results_table|
  @bus_site.admin_console_page.search_list_users_section.search_results_table_headers.should == results_table.headers
  @bus_site.admin_console_page.search_list_users_section.search_results_table_rows.should == results_table.rows
end
