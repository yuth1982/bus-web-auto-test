# Public: Search user
#
# Required column: keywords
# Optional column: filter
#
When /^I search user by:$/ do |search_key_table|
  step "I navigate to Search / List Users section from bus admin console page"
  attributes = search_key_table.hashes.first
  keywords = attributes["keywords"] || ""
  filter = attributes["filter"] || "None"
  @bus_admin_console_page.search_list_users_section.search_user(keywords, filter)
end

Then /^User search results should be:$/ do |results_table|
  @bus_admin_console_page.search_list_users_section.search_results_table_headers.should == results_table.headers
  @bus_admin_console_page.search_list_users_section.search_results_table_rows.should == results_table.rows
end
