# Public: Search partner
#
# Required column: name or email
# Optional column: filter, including sub-partners
#
When /^I search partner by:$/ do |search_key_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_partner'])
  attributes = search_key_table.hashes.first
  keywords = attributes["name"] || attributes["email"]
  filter = attributes["filter"] || "None"
  including_sub_partners = (attributes["including sub-partners"] || "yes").eql?("yes")
  @bus_site.admin_console_page.search_list_partner_section.search_partner(keywords, filter, including_sub_partners)
end

When /^I act as partner by:$/ do |search_key_table|
  attributes = search_key_table.hashes.first
  step %{I search partner by:}, table(%{
      |#{search_key_table.headers.join('|')}|
      |#{search_key_table.rows.first.join('|')}|
    })
  if attributes["name"].nil? == false
    page.find_link(attributes["name"]).click
    @bus_site.admin_console_page.partner_details_section.act_as_partner
  elsif attributes["email"].nil? == false
    page.find_link(attributes["email"]).click
    @bus_site.admin_console_page.admin_details_section.act_as_admin
  else
    raise "Please act as partner by name or email"
  end
  @bus_site.admin_console_page.has_stop_masquerading_link?
end

# Public: View partner details by click name in search partner results
# Required: search list partner section must be visible
When /^I view partner details by (.+)$/ do |search_key|
  @bus_site.admin_console_page.search_list_partner_section.view_partner_detail(search_key)
end

# Public: View admin details by click email in search partner results
# Required: search list partner section must be visible
When /^I view admin details by (.+)$/ do |partner_email|
  @bus_site.admin_console_page.search_list_partner_section.view_partner_detail(partner_email)
end

Then /^Partner search results should be:$/ do |results_table|
  @bus_site.admin_console_page.search_list_partner_section.search_results_table_headers.should == results_table.headers
  @bus_site.admin_console_page.search_list_partner_section.search_results_table_rows.should == results_table.rows
end