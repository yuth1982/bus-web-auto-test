Then /^Invoice head should include (.+)$/ do |company_name|
  @bus_site.partner_invoice_page.partner_info.include?(company_name).should be_true
end

And /^Billing details of partner invoice should be:$/ do |billing_detail_table|
  actual = @bus_site.partner_invoice_page.billing_detail_table_rows
  expected = billing_detail_table.raw
  expected[2...-3].each_index { |i|
    expected[i+2][0].replace(Chronic.parse(expected[i+2][0]).strftime('%m/%d/%Y'))
    expected[i+2][1].replace(Chronic.parse(expected[i+2][1]).strftime('%m/%d/%Y'))
  }
  expected[-2][0].replace(Chronic.parse(expected[-2][0]).strftime('%Y-%m-%d'))
  (actual.flatten.select { |item| item != '' }).should == expected.flatten.select { |item| item != '' }
end