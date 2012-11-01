# Public: Search user
#
# Required column: keywords
# Optional column: filter
#
When /^I search user by:$/ do |search_key_table|
  @bus_site.admin_console_page.navigate_to_link(CONFIGS['bus']['menu']['search_list_users'])
  attributes = search_key_table.hashes.first
  keywords = attributes["keywords"] || ""
  filter = attributes["filter"] || "None"
  @bus_site.admin_console_page.search_list_users_section.search_user(keywords, filter)
end

Then /^User search results should be:$/ do |results_table|
  @bus_site.admin_console_page.search_list_users_section.search_results_table_headers.should == results_table.headers
  @bus_site.admin_console_page.search_list_users_section.search_results_table_rows.should == results_table.rows
end

When /^The users table should be:$/ do |table|
  header = @bus_site.admin_console_page.search_list_users_section.search_results_table_headers
  rows = @bus_site.admin_console_page.search_list_users_section.search_results_table_rows
  header[1..3].should == table.headers
  rows.collect { |row| row[1..3]}.should == table.rows
end

When /^The users table should be empty$/ do
  rows = @bus_site.admin_console_page.search_list_users_section.search_results_table_rows
  rows.count.should == 7 && rows[1].to_s.should == "[\"No results found.\"]"
end

When /^I view user details by (.+)$/ do |user|
  @bus_site.admin_console_page.search_list_users_section.view_user_details(user)
end


When /^I refresh the search list user group page$/ do
  @bus_site.admin_console_page.search_list_users_section.refresh
end