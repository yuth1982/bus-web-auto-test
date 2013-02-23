# Public: Search user
#
# Required column: keywords
# Optional column: filter
#
When /^I search user by:$/ do |search_key_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_users'])
  attributes = search_key_table.hashes.first
  if @user.nil?
    keywords = attributes["keywords"] || ""
  else
    keywords = attributes["keywords"].gsub(/@user_name/,@user.name) || ""
  end
  filter = attributes["filter"] || "None"
  partner_filter = attributes["user type"] || ""
  @bus_site.admin_console_page.search_list_users_section.search_user(keywords, filter, partner_filter)
end

Then /^user search results should be:$/ do |results_table|

  results_table.map_column!('Created') do |value|
    Chronic.parse(value).strftime("%m/%d/%y")
  end

  results_table.map_column!('User') do |value|
    if @user.nil? 
      value.slice(0,27)+"..." unless value.length <= 28
    else
      (value.gsub(/@user_email/,@user.email)).length > 27 ? value.gsub(/@user_email/,@user.email).slice(0,27)+"...":value.gsub(/@user_email/,@user.email)
    end
  end

  results_table.map_column!('Name') do |value|
    if @user.nil?
      value.slice(0,27)+"..." unless value.length <= 28
    else
      value.gsub(/@user_name/,@user.name)
    end
  end

  @bus_site.admin_console_page.search_list_users_section.search_results_table_headers.should == results_table.headers
  @bus_site.admin_console_page.search_list_users_section.search_results_table_rows.should == results_table.rows
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
  if @user.nil?
    @bus_site.admin_console_page.search_list_users_section.view_user_details((user).slice(0,27))
  else
    @bus_site.admin_console_page.search_list_users_section.view_user_details((user.gsub(/@user_email/,@user.email)).slice(0,27))
  end
end

When /^I refresh Search List User section$/ do
  @bus_site.admin_console_page.search_list_users_section.refresh_bus_section
end