
Then /^Billing history table should be:$/ do |billing_table|
  actual = @bus_site.admin_console_page.billing_history_section.billing_history_hashes
  expected = billing_table.hashes
  expected.each do |col|
    col.each do |k,v|
      case k
        when "Date"
          v.replace(Chronic.parse(v).strftime("%m/%d/%y"))
        else
          # do nothing
      end
    end
  end
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end
