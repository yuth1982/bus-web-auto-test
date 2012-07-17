When /^I navigate to add (.+) report view$/ do |report_type|
  @bus_admin_console_page.report_builder_view.get_add_report_view(report_type)
end

Then /^I should see available reports are:$/ do |reports_description|
  @bus_admin_console_page.report_builder_view.available_reports_table.body_rows_text.should == reports_description.rows
end

When /^I build a new (Active|Inactive) (Daily|Weekly|Monthly) billing summary report named (.+) start (.+)$/ do |is_active, frequency, report_name, start_date|
  step "I navigate to add Billing Summary report view"
  @bus_admin_console_page.report_builder_view.build_billing_summary_report(report_name, frequency, start_date, is_active)
end

When /^I build a new (Active|Inactive) (Daily|Weekly|Monthly) billing detail report named (.+) start (.+)$/ do |is_active, frequency, report_name, start_date|
  step "I navigate to add Billing Detail report view"
  @bus_admin_console_page.report_builder_view.build_billing_detail_report(report_name, frequency, start_date, is_active)
end

Then /^Report created successful message should be (.+)$/ do |message|
  @bus_admin_console_page.report_builder_view.report_created_txt.text.should == message
end

When /^I delete report by name (.+)$/ do |report_name|
  @bus_admin_console_page.report_builder_view.delete_report(report_name)
end

Then /^I should see (.+) in scheduled reports list$/ do |message|
  @bus_admin_console_page.scheduled_reports_view.reports_table.text.should include(message)
end

When /^I download report by name (.+)$/ do |report_name|
  step "I navigate to scheduled report view"
  @bus_admin_console_page.scheduled_reports_view.download_report(report_name)
end

Then /^(.+) report file details should be:$/ do |report_type, report_content|
  @bus_admin_console_page.scheduled_reports_view.read_csv_report(report_type).should == report_content.rows
end

When /^I search report by name (.+)$/ do |report_name|
  @report_row = @bus_admin_console_page.scheduled_reports_view.find_report(report_name)
end

Then /^Scheduled report list should be:$/ do |results|
  @bus_admin_console_page.scheduled_reports_view.reports_table.body_rows_text.map{|row| row[0..4]}.should == results.rows.map{ |row| row.map{ |x| x.gsub("New partner's email",@partner.admin_info.email)}}
end