When /^I navigate to add report view for (.+)/ do |report_type|
  @bus_site.admin_console_page.report_builder_section.navigate_to_add_report_section(report_type)
end

# Build a new reports
#
# Available columns: type, name, frequency, start date, is active, recipients, subject, email message
#
When /^I build a new report:$/ do |report_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['report_builder'])
  attributes = report_table.hashes.first
  @bus_site.admin_console_page.report_builder_section.navigate_to_add_report_section(attributes["type"])
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
  @bus_site.admin_console_page.add_report_section.build_report(@report)
end

Then /^I should see available reports are:$/ do |link_desc_link|
  @bus_site.admin_console_page.report_builder_section.available_reports_table_rows.should == link_desc_link.rows
end

Then /^I should see report filters are:$/ do |link_desc_link|
  @bus_site.admin_console_page.scheduled_reports_section.report_filters.should == link_desc_link.rows.map{|row|row.first}
end

Then /^I should see quick reports are:$/ do |link_desc_table|
  link_desc_table.map_column!('description') do |value|
    value.gsub(/@today/,Time.now.localtime("-06:00").strftime("%Y-%m-%d"))
  end
  @bus_site.admin_console_page.quick_reports_section.link_desc_table_rows.should == link_desc_table.rows
end

Then /^Billing summary report should be created$/ do
  @bus_site.admin_console_page.add_report_section.messages.should == "Created Billing Summary Report."
end

Then /^Billing detail report should be created$/ do
  @bus_site.admin_console_page.add_report_section.messages.should == "Created Billing Detail Report."
end

Then /^Report created successful message should be (.+)$/ do |message|
  @bus_site.admin_console_page.add_report_section.messages.should == message
end

When /^I delete (.+) scheduled report$/ do |report_name|
  @bus_site.admin_console_page.add_report_section.delete_report(report_name)
end

Then /^I should see (.+) in scheduled reports list$/ do |message|
  @bus_site.admin_console_page.scheduled_reports_section.reports_table_text.should include(message)
end

When /^I download (.+) scheduled report$/ do |report_name|
  @bus_site.admin_console_page.scheduled_reports_section.download_report(report_name)
end

When /^I download (.+) quick report$/ do |report_name|
  @bus_site.admin_console_page.click_link(CONFIGS['bus']['menu']['quick_reports'])
  @bus_site.admin_console_page.quick_reports_section.download_report(report_name)
end

Then /^Scheduled (.+) report csv file details should be:$/ do |report_type, report_table|
  report_table.map_column!('Column A') do |value|
    value.gsub(/@name/,@partner.company_info.name)
  end
  unless RUBY_PLATFORM.include?('linux') then
    report_table.rows.each do |row|
      row.map {|col| col.force_encoding('IBM437');}
    end
  end
  @bus_site.admin_console_page.scheduled_reports_section.read_scheduled_report(report_type).should eql report_table.rows
end

Then /^Quick report (.+) csv file details should be:$/ do |report_type, report_table|
  report_table.map_column!('Column A') do |value|
    value.gsub(/@name/,@partner.company_info.name).gsub(/@today/,DateTime.now.strftime("%m/%d/%y"))
  end

  report_table.map_column!('Column C') do |value|
    value.gsub(/@XXXX/, @partner.credit_card.number[12..-1])
  end
  actual = @bus_site.admin_console_page.quick_reports_section.read_quick_report(report_type)
  actual.size.should == report_table.rows.size
  actual.each { |row| report_table.rows.should include row }
end

# a report will return multiple lines of records, just need to check one record of specified columns
And /^I get record for column (.+) with value (.+) from Quick report (.+) csv file should be$/ do |_, value, report, table|
  expected = table.hashes[0]
  actual = @bus_site.admin_console_page.quick_reports_section.read_quick_report(report)
  record_index = 0
  # find the record index which we need to check among all records
  actual.each_with_index { | v,index |
    if v.include?(value)
      record_index = index
      break
    end
  }
  actual_record = {}
  # combine the report head and the actual record to a hash
  actual[0].each_with_index { |key, index| actual_record[key] = actual[record_index][index]}
  expected.keys.each{|key| actual_record[key].should == expected[key] }
end

When /^I search report by name (.+)$/ do |report_name|
  @report_row = @bus_site.admin_console_page.scheduled_reports_section.find_report(report_name)
end

Then /^Scheduled report list should be:$/ do |results_table|
  @bus_site.admin_console_page.scheduled_reports_section.wait_until_bus_section_load
  actual = @bus_site.admin_console_page.scheduled_reports_section.reports_table_hashes.first
  expected = results_table.hashes.first

  expected.each do |_, v|
    v.replace ERB.new(v).result(binding)
  end

  expected.keys.each{ |key| actual[key].should == expected[key]}
end
