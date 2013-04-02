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
      (value.gsub(/@new_user_email/,@user.email)).length > 27 ? value.gsub(/@user_email/,@user.email).slice(0,27)+"...":value.gsub(/@user_email/,@user.email)
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

Then /^User search results should be:$/ do |results_table|
  actual = @bus_site.admin_console_page.search_list_users_section.search_results_hashes
  expected = results_table.hashes
  expected.each do |col|
    col.each do |k,v|
      case k
        when "Created"
          v.replace(Chronic.parse(v).strftime("%m/%d/%y"))
        when "Name"
          v.gsub!(/@user_name/, @user.name) unless @user.nil?
        when "User"
          v.gsub!(/@user_email/, @user.email) unless @user.nil?
        else
          # do nothing
      end
    end
  end
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

When /^The users table should be empty$/ do
  rows = @bus_site.admin_console_page.search_list_users_section.search_results_table_rows
  rows.to_s.include?('No results found.').should be_true
end

When /^I view user details by (.+)$/ do |user|
  if @user.nil?
    @bus_site.admin_console_page.search_list_users_section.view_user_details((user).slice(0,27))
  else
    @bus_site.admin_console_page.search_list_users_section.view_user_details((user.gsub(/@user_email/,@user.email)).slice(0,27))
  end
end

When /^I view MozyHome user details by (.+)$/ do |user|
  @bus_site.admin_console_page.search_list_users_section.view_user_details(user.gsub(/@user_name/,@partner.admin_info.email[0..10]))
end

When /^I refresh Search List User section$/ do
  @bus_site.admin_console_page.search_list_users_section.refresh_bus_section
end
When /^I export the users csv$/ do
  @bus_site.admin_console_page.search_list_users_section.export_csv
end