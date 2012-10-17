

When /^I navigate to the new user group details section$/ do
  @bus_site.admin_console_page.click_link(Bus::MENU[:list_user_groups])
  @bus_site.admin_console_page.list_user_groups_section.view_user_group_detail(@user_group.name)
end

Then /^User group details should be:$/ do |details_table|
  attributes = details_table.hashes.first
  @bus_site.admin_console_page.user_group_details_section.available_keys.should ==  attributes["Available Keys"] unless attributes["Available Keys"].nil?
  @bus_site.admin_console_page.user_group_details_section.available_quota.should == attributes["Available Quota"] unless attributes["Available Quota"].nil?
  @bus_site.admin_console_page.user_group_details_section.default_quota.should == attributes["Default quota for new installs"] unless attributes["Default quota for new installs"].nil?
end
