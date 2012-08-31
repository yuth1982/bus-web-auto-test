
When /^I act as newly created partner/ do
  @bus_site.admin_console_page.partner_details_section.act_as_partner
end

When /^I delete the new partner account$/ do
  @bus_site.admin_console_page.navigate_to_link("Search / List Partners")
  @bus_site.admin_console_page.search_list_partner_section.search_partner(@partner.company_info.name)

  rows_text = @bus_site.admin_console_page.search_list_partner_section.search_results_table_rows
  unless rows_text.count == 7 && rows_text[1].to_s == "[\"No results found.\"]"
    @bus_site.admin_console_page.search_list_partner_section.view_partner_detail(@partner.company_info.name)
    @bus_site.admin_console_page.partner_details_section.delete_partner(Bus::DEFAULT_PWD)
  end
end
