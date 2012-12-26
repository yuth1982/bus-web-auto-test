# Public: Search user
#
# Required column: keywords
# Optional column: filter
#
When /^I search user by:$/ do |search_key_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_users'])
  attributes = search_key_table.hashes.first
  keywords = attributes["keywords"] || ""
  filter = attributes["filter"] || "None"
  @bus_site.admin_console_page.search_list_users_section.search_user(keywords, filter)
end

Then /^User search results should be|include:$/ do |results_table|
  results_table.map_column!('Created') do |value|
    Chronic.parse(value).strftime("%m/%d/%y")
  end

  actual_hash = @bus_site.admin_console_page.search_list_users_section.search_results_table_hash
  expected_hash = results_table.hashes
  expected_hash.each_index{ |index| expected_hash[index].keys.each{ |key| actual_hash[index][key].should == expected_hash[index][key]} }

end

When /^Synced users table should be:$/ do |users_table|
  header = @bus_site.admin_console_page.search_list_users_section.search_results_table_headers
  rows = @bus_site.admin_console_page.search_list_users_section.search_results_table_rows
  header[1..3].should == users_table.headers
  rows.collect { |row| row[1..3]}.should == users_table.rows
end

When /^The users table should be empty$/ do
  rows = @bus_site.admin_console_page.search_list_users_section.search_results_table_rows
  rows.count.should == 7 && rows[1].to_s.should == "[\"No results found.\"]"
end

When /^I view user details by (.+)$/ do |user|
  @bus_site.admin_console_page.search_list_users_section.view_user_details(user)
end

When /^I refresh Search List User section$/ do
  @bus_site.admin_console_page.search_list_users_section.refresh_bus_section
end