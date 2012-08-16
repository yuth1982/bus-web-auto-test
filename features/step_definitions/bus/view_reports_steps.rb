When /^I navigate to add report view for (.+)/ do |report_type|
  @bus_admin_console_page.report_builder_section.navigate_to_add_report_section(report_type)
end

# Build a new reports
#
# Available column names
# | type | name | frequency | start date | is active | recipients | subject | email message |

When /^I build a new report:$/ do |report_table|
  step "I navigate to Report Builder section from bus admin console page"
  attributes = report_table.hashes.first
  @bus_admin_console_page.report_builder_section.navigate_to_add_report_section(attributes["type"])
  case attributes["type"]
    when "Billing Summary"
      @report = Bus::DataObj::BillingSummaryReport.new
      @report.name = attributes["name"] || "billing summary test report"
      @report.frequency = attributes["frequency"] || "Daily"
      @report.start_date = attributes["start date"] unless attributes["start date"].nil?
      @report.is_active = (attributes["is active"] || "yes").eql?("yes")
    when "Billing Detail"
      @report = Bus::DataObj::BillingDetailReport.new
      @report.name = attributes["name"] || "billing detail test report"
      @report.frequency = attributes["frequency"] || "Daily"
      @report.start_date = attributes["start date"] unless attributes["start date"].nil?
      @report.is_active = (attributes["is active"] || "yes").eql?("yes")
    else
      raise "#{attributes["type"]} report is not implemented"
  end
  @report.recipients = attributes["recipients"] unless attributes["recipients"].nil?
  @report.subject = attributes["subject"] || ""
  @report.email_message = attributes["email message"] || ""
  @bus_admin_console_page.report_builder_section.build_report(@report)
end

Then /^I should see available reports are:$/ do |link_desc_link|
  @bus_admin_console_page.report_builder_section.available_reports_tb_rows_text.should == link_desc_link.rows
end

Then /^I should see report filters are:$/ do |link_desc_link|
  @bus_admin_console_page.report_builder_section.report_filters_text.should == link_desc_link.rows.map{|row|row.first}
end

Then /^I should see quick reports are:$/ do |link_desc_table|
  link_desc_table.map_column!('description') do |value|
    value.gsub(/@today/,Time.now.localtime("-06:00").strftime("%Y-%m-%d"))
  end
  @bus_admin_console_page.quick_reports_section.link_desc_tb_rows_text.should == link_desc_table.rows
end

Then /^Billing summary report should be created$/ do
  @bus_admin_console_page.report_builder_section.message_text.should == "Created Billing Summary Report."
end

Then /^Billing detail report should be created$/ do
  @bus_admin_console_page.report_builder_section.message_text.should == "Created Billing Detail Report."
end

Then /^Report created successful message should be (.+)$/ do |message|
  @bus_admin_console_page.report_builder_section.message_text.should == message
end

When /^I delete (.+) scheduled report$/ do |report_name|
  @bus_admin_console_page.report_builder_section.delete_report(report_name)
end

Then /^I should see (.+) in scheduled reports list$/ do |message|
  @bus_admin_console_page.scheduled_reports_section.reports_tb_text.should include(message)
end

When /^I download (.+) scheduled report$/ do |report_name|
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
    value.gsub(/@name/,@partner.company_info.name).gsub(/@today/,DateTime.now.strftime("%m/%d/%y"))
  end

  report_table.map_column!('Column C') do |value|
    value.gsub(/@XXXX/, @partner.credit_card.number[12..-1])
  end

  @bus_admin_console_page.quick_reports_section.read_quick_report(report_type).should == report_table.rows
end

When /^I search report by name (.+)$/ do |report_name|
  @report_row = @bus_admin_console_page.scheduled_reports_section.find_report(report_name)
end

Then /^Scheduled report list should be:$/ do |results_table|
  results_table.map_column!('Recipients') do |value|
      value.gsub(/@email/,@partner.admin_info.email)
  end
  @bus_admin_console_page.scheduled_reports_section.reports_tb_rows_text.should == results_table.rows
     # ach{|row| row.map{ |cell| cell.gsub(/(?:[01][0-9]|2[0-4]):[0-5][0-9]/,"xx:xx")}}.should == results_table
end