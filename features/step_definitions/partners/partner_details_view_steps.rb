
When /^I act as newly created partner account$/ do
  @bus_site.admin_console_page.partner_details_section.act_as_partner
end

#
#
#
#
When /^I delete (.+ account)$/ do |account|
  @bus_site.admin_console_page.click_link(Bus::MENU[:search_list_partner])
  @bus_site.admin_console_page.search_list_partner_section.search_partner(account[:company_name])

  rows_text = @bus_site.admin_console_page.search_list_partner_section.search_results_table_rows
  unless rows_text.count == 7 && rows_text[1].to_s == "[\"No results found.\"]"
    @bus_site.admin_console_page.search_list_partner_section.view_partner_detail(account[:company_name])
    @bus_site.admin_console_page.partner_details_section.delete_partner(Bus::DEFAULT_PWD)
  end
end
