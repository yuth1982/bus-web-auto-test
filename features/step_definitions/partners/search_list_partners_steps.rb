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

When /^I search partner by (.+)$/ do |keywords|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_partner'])
  @bus_site.admin_console_page.search_list_partner_section.search_partner(keywords)
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
  @bus_site.admin_console_page.partner_details_section.wait_until_bus_section_load
end

# Public: View admin details by click email in search partner results
# Required: search list partner section must be visible
When /^I view admin details by (.+)$/ do |partner_email|
  @bus_site.admin_console_page.search_list_partner_section.view_partner_detail(partner_email)
end

Then /^Partner search results should be:$/ do |results_table|
  if results_table.headers.include?('Created')
    results_table.map_column!('Created') do |value|
      Chronic.parse(value).strftime("%m/%d/%y")
    end
  end
  actual = @bus_site.admin_console_page.search_list_partner_section.search_results_hashes
  expected = results_table.hashes
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

When /^I refresh Search List Partners section$/ do
  @bus_site.admin_console_page.search_list_partner_section.refresh_bus_section
end