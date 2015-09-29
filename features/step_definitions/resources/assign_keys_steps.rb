When /^I assign (Desktop|Server) key to user (.+) on (.+)$/ do |type, email, user_group|
  @bus_site.admin_console_page.assign_keys_section.click_user_group(user_group)
  @key = @bus_site.admin_console_page.assign_keys_section.assign_keys_to_email(type, email)
  @bus_site.admin_console_page.assign_keys_section.click_assign_button
end

Then /^assign keys summary information should be:$/ do |summary_info|
  actual =  @bus_site.admin_console_page.assign_keys_section.resources_general_info_hash
  expected = summary_info.hashes.first
  expected.keys.each do |header|
    actual[header].should == expected[header]
  end
end