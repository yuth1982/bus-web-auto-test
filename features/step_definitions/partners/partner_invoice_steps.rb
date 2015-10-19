Then /^Invoice head should include (.+)$/ do |company_name|
  @bus_site.partner_invoice_page.partner_info.include?(company_name).should be_true
end

And /^Billing details of partner invoice should be:$/ do |billing_detail_table|
  actual = @bus_site.partner_invoice_page.billing_detail_table_rows
  expected = billing_detail_table.raw
  expected[3][0].replace(Chronic.parse(expected[3][0]).strftime('%m/%d/%Y')) unless expected[3][0].size == 0
  expected[3][1].replace(Chronic.parse(expected[3][1]).strftime('%m/%d/%Y')) unless expected[3][1].size == 0
  (actual.flatten.select { |item| item != '' }).should == expected.flatten.select { |item| item != '' }
end