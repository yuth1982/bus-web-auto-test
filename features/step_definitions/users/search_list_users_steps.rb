# Public: Search user
#
# Required column: keywords
# Optional column: filter
#
When /^I search user by:$/ do |search_key_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_users'])
  attributes = search_key_table.hashes.first

  attributes['keywords'] = @partner.admin_info.email if attributes['keywords'] == '@mh_user_email'
  attributes['keywords'] = @new_users[0].name if attributes['keywords'] == '@user_name'
  attributes['keywords'] = @existing_user_email if attributes['keywords'] == '@existing_user_email'
  attributes['keywords'] = @existing_admin_email if attributes['keywords'] == '@existing_admin_email'

  keywords = attributes["keywords"] || ""
  filter = attributes["filter"] || "None"
  partner_filter = attributes["user type"] || ""

  @bus_site.admin_console_page.search_list_users_section.search_user(keywords, filter, partner_filter)
end

When /^I sort user search results by (User|Name|User Group|Stash|Machines|Storage|Storage Used|Created|Backed Up)$/ do |column_name|
  @bus_site.admin_console_page.search_list_users_section.sort_users_by(column_name)
end

Then /^User search results should be:$/ do |results_table|
  actual = @bus_site.admin_console_page.search_list_users_section.search_results_hashes
  expected = results_table.hashes
  expected.each do |col|
    col.each do |k,v|
      case k
        when 'Created'
          v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
        when 'Name'
          v.gsub!(/@user_name/, @new_users.first.name.slice(0,27)) unless @new_users.nil?
        when 'User'
          v.gsub!(/@user_email/, @new_users.first.email.slice(0,27)) unless @new_users.nil?
        else
          # do nothing
      end
    end
  end
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

Then /^Itemized user search results should be:$/ do |results_table|
  actual = @bus_site.admin_console_page.search_list_itemized_users_section.search_results_hashes
  expected = results_table.hashes
  expected.each do |col|
    col.each do |k,v|
      case k
        when 'Created'
          v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
        when 'Name'
          v.gsub!(/@user_name/, @new_users.first.name.slice(0,27)) unless @new_users.nil?
        when 'User'
          v.gsub!(/@user_email/, @new_users.first.email.slice(0,27)) unless @new_users.nil?
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
    @bus_site.admin_console_page.search_list_users_section.view_user_details(user[0..26])
  else
    @bus_site.admin_console_page.search_list_users_section.view_user_details(user.gsub(/@user_email/,@new_users.first.email).slice!(0..26))
  end
  @current_user = @bus_site.admin_console_page.user_details_section.user
end

When /^I view MozyHome user details by (.+)$/ do |user|
  @bus_site.admin_console_page.search_list_users_section.view_user_details(user.gsub(/@user_name/,@partner.admin_info.email[0..26]).slice!(0..26))
end

When /^I refresh Search List User section$/ do
  @bus_site.admin_console_page.search_list_users_section.refresh_bus_section
end
When /^I export the users csv$/ do
  @bus_site.admin_console_page.search_list_users_section.export_csv
end
