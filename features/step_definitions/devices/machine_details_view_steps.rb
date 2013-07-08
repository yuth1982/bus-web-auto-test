Then /^the data shuttle machine details should be:$/ do |ds_table|
  actual = @bus_site.admin_console_page.machine_details_section.dso_hashes
  expected = ds_table.hashes
  expected.each do |col|
    col.each do |k,v|
      case k
        when 'Order Date'
          v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
        when 'Start'
          v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
        else
          # do nothing
      end
      v.replace ERB.new(v).result(binding)
    end
  end
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end
