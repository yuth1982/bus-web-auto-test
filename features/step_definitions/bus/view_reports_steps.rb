When /^I navigate to add report view for (.+)/ do |report_type|
  @bus_admin_console_page.report_builder_section.navigate_to_add_report_section(report_type)
end

Then /^I should see available reports are:$/ do |link_desc_link|
  @bus_admin_console_page.report_builder_section.available_reports_tb_rows_text.should == link_desc_link.rows
end

Then /^I should see report filters are:$/ do |link_desc_link|
  @bus_admin_console_page.report_builder_section.report_filters_text.should == link_desc_link.rows.map{|row|row.first}
end

Then /^I should see quick reports are:$/ do |link_desc_table|
  @bus_admin_console_page.quick_reports_section.link_desc_tb_rows_text.should == link_desc_table.rows
end

When /^I build a new (Active|Inactive) (Daily|Weekly|Monthly) billing summary report named (.+) start (.+)$/ do |is_active, frequency, report_name, start_date|
  step "I navigate to add report view for Billing Summary"
  @bus_admin_console_page.report_builder_section.build_billing_summary_report(report_name, frequency, start_date, is_active)
end

When /^I build a new (Active|Inactive) (Daily|Weekly|Monthly) billing detail report named (.+) start (.+)$/ do |is_active, frequency, report_name, start_date|
  step "I navigate to add report view for Billing Detail"
  @bus_admin_console_page.report_builder_section.build_billing_detail_report(report_name, frequency, start_date, is_active)
end

Then /^Report created successful message should be (.+)$/ do |message|
  @bus_admin_console_page.report_builder_section.message_text.should == message
end

When /^I delete report by name (.+)$/ do |report_name|
  @bus_admin_console_page.report_builder_section.delete_report(report_name)
end

Then /^I should see (.+) in scheduled reports list$/ do |message|
  @bus_admin_console_page.scheduled_reports_section.reports_tb_text.should include(message)
end

When /^I download report by name (.+)$/ do |report_name|
  step "I navigate to Scheduled Reports section from bus admin console page"
  @bus_admin_console_page.scheduled_reports_section.download_report(report_name)
end

When /^I download (.+) quick report$/ do |report_name|
  step "I navigate to Quick Reports section from bus admin console page"
  @bus_admin_console_page.quick_reports_section.download_report(report_name)
end

Then /^Scheduled (.+) report csv file details should be:$/ do |report_type, report_table|
  report_table.map_column!('Column A') do |value|
    value.gsub(/@name/,@partner.company_info.name)
  end
  @bus_admin_console_page.scheduled_reports_section.read_scheduled_report(report_type).should == report_table.rows
end

Then /^Quick report (.+) csv file details should be:$/ do |report_type, report_table|
  report_table.map_column!('Column A') do |value|
    value.gsub(/@name/,@partner.company_info.name)
  end
  @bus_admin_console_page.quick_reports_section.read_quick_report(report_type).should == report_table.rows
end

When /^I search report by name (.+)$/ do |report_name|
  @report_row = @bus_admin_console_page.scheduled_reports_section.find_report(report_name)
end

Then /^Scheduled report list should be:$/ do |results_table|
  results_table.map_column!('Next Run') do |value|
    value.gsub(/@next_day/, (DateTime.now + 1).strftime("%a %b %d, %Y")).gsub(/@next_week/, (DateTime.now + 7).strftime("%a %b %d, %Y")).gsub(/@next_month/, (DateTime.now >> 1).to_time.localtime("-06:00").strftime("%a %b %d, %Y"))
  end

  results_table.map_column!('Recipients') do |value|
      value.gsub(/@email/,@partner.admin_info.email)
  end
  @bus_admin_console_page.scheduled_reports_section.reports_tb_rows_text.should == results_table.rows
     # ach{|row| row.map{ |cell| cell.gsub(/(?:[01][0-9]|2[0-4]):[0-5][0-9]/,"xx:xx")}}.should == results_table
end