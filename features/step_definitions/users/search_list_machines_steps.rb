

Then /^Machine search results should be:$/ do |results_table|
  results_table.map_column!('Created') do |value|
    Chronic.parse(value).strftime("%m/%d/%y")
  end
  @bus_site.admin_console_page.search_list_machines_section.search_results_table_headers.should == results_table.headers
  @bus_site.admin_console_page.search_list_machines_section.search_results_table_rows.should == results_table.rows
end