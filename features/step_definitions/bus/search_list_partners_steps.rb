
When /^I search partner by (.+)$/ do |search_key|
  @bus_admin_console_page.refresh_page
  step "I navigate to Search / List Partners view from bus admin console page"
  @bus_admin_console_page.search_list_partner_section.search_partner(search_key)
end

When /^I view partner details by (.+)$/ do |search_key|
  @bus_admin_console_page.search_list_partner_section.view_partner_detail(search_key)
end

When /^I view admin details by (.+)$/ do |partner_email|
  @bus_admin_console_page.search_list_partner_section.view_partner_detail(partner_email)
end

Then /^Search results should be:$/ do |results|
  @bus_admin_console_page.search_list_partner_section.search_results_tb_headers_text.should == results.headers
  @bus_admin_console_page.search_list_partner_section.search_results_tb_rows_text.should == results.rows
end