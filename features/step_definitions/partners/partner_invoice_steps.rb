Then /^Invoice head should include (.+)$/ do |company_name|
  @bus_site.partner_invoice_page.partner_info.include?(company_name).should be_true
end

And /^Billing details of partner invoice should be:$/ do |billing_detail_table|
  actual = @bus_site.partner_invoice_page.billing_detail_table_rows
  expected = billing_detail_table.raw
  expected_arr = expected[3...-1]
  expected_arr.each_index { |i|
    Log.debug expected_arr
    expected_arr[i][0].replace(Chronic.parse(expected_arr[i][0]).strftime('%m/%d/%Y')) unless expected_arr[i][0].size == 0
    if expected_arr[i][1] == 'after 1 year yesterday'
      date = Chronic.parse("after 1 year")
      expected_arr[i][1] = date.month.to_s+"/"+(date.day-1).to_s+"/"+date.year.to_s
    else
      expected_arr[i][1].replace(Chronic.parse(expected_arr[i][1]).strftime('%m/%d/%Y')) unless expected_arr[i][1].size == 0
    end
  }
  expected[3...-1] = expected_arr
  (actual.flatten.select { |item| item != '' }).should == expected.flatten.select { |item| item != '' }
end
