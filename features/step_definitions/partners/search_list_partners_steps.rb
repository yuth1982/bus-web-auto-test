# Public: Search partner
#
# Required column: keywords
# Optional column: filter, including sub-partners
#
When /^I search partner by:$/ do |search_key_table|
  step "I navigate to Search / List Partners section from bus admin console page"
  attributes = search_key_table.hashes.first
  keywords = attributes["keywords"] || ""
  filter = attributes["filter"] || "None"
  including_sub_partners = (attributes["including sub-partners"] || "yes").eql?("yes")
  @bus_site.admin_console_page.search_list_partner_section.search_partner(keywords, filter, including_sub_partners)
end

When /^I view partner details by (.+)$/ do |search_key|
  @bus_site.admin_console_page.search_list_partner_section.view_partner_detail(search_key)
end

When /^I view admin details by (.+)$/ do |partner_email|
  @bus_site.admin_console_page.search_list_partner_section.view_partner_detail(partner_email)
end

Then /^Partner search results should be:$/ do |results_table|
  @bus_site.admin_console_page.search_list_partner_section.search_results_table_headers.should == results_table.headers
  @bus_site.admin_console_page.search_list_partner_section.search_results_table_rows.should == results_table.rows
end