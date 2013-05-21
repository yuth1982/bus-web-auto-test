Then /^Number of activated keys should be (\d+)$/ do |num_keys|
  @bus_site.admin_console_page.user_details_section.activated_keys_table_rows.count.should == num_keys.to_i
end

Then /^Number of unactivated keys should be (\d+)$/ do |num_keys|
  @bus_site.admin_console_page.user_details_section.unactivated_keys_table_rows.count.should == num_keys.to_i
end