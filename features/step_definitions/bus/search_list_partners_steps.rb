
When /^I search partner by (.+)$/ do |search_key|
  @bus_admin_console_page.refresh_page
  step "I navigate to search list partner view"
  @bus_admin_console_page.search_list_partner_view.search_partner(search_key)
end

When /^I view partner details by (.+)$/ do |search_key|
  @bus_admin_console_page.search_list_partner_view.view_partner_detail(search_key)
end

When /^I view admin details by email (.+)$/ do |partner_email|
  @bus_admin_console_page.search_list_partner_view.view_partner_detail(partner_email)
end

Then /^I should see the new partner's information shows in search results$/ do
  expected_result = "#{@partner.company_name} #{DateTime.now.strftime("%m/%d/%y")} #{@partner.email.downcase} #{@partner.company_type} 0 #{@partner.total_licence_num} #{@partner.total_quota} GB"
  @bus_admin_console_page.search_list_partner_view.search_results_content.first.should == expected_result
end

Then /^Search results should be:$/ do |results|
  @bus_admin_console_page.search_list_partner_view.search_results_table.header_row_text.should == results.headers
  @bus_admin_console_page.search_list_partner_view.search_results_table.body_rows_text.should == results.rows
end