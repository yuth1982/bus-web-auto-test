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

When /^I search user by (.+)$/ do |keywords|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_users'])
  @bus_site.admin_console_page.search_list_users_section.search_user(keywords, "None")
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
  rows.count.should == 7 && rows[1].to_s.should == "[\"No results found.\"]"
end

When /^I view user details by (.+)$/ do |user|
  @bus_site.admin_console_page.search_list_users_section.view_user_details(user)
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