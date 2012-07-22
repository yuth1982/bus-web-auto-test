
When /^I search partner by (.+)$/ do |search_key|
  @bus_admin_console_page.refresh_page
  step "I navigate to Search / List Partners view from bus admin console page"
  @bus_admin_console_page.search_list_partner_view.search_partner(search_key)
end

When /^I view partner details by (.+)$/ do |search_key|
  @bus_admin_console_page.search_list_partner_view.view_partner_detail(search_key)
end

When /^I view admin details by (.+)$/ do |partner_email|
  @bus_admin_console_page.search_list_partner_view.view_partner_detail(partner_email)
end

Then /^Search results should be:$/ do |results|
  @bus_admin_console_page.search_list_partner_view.search_results_table.header_row_text.should == results.headers
  @bus_admin_console_page.search_list_partner_view.search_results_table.body_rows_text.should == results.rows
end