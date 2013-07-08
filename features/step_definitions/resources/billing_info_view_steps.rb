Then /^Autogrow details should be:$/ do |autogrow_table|
  actual = @bus_site.admin_console_page.billing_info_section.autogrow_hashes
  expected = autogrow_table.hashes
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

Then /^Next renewal supplemental plan details should be:$/ do |plan_table|
  actual = @bus_site.admin_console_page.billing_info_section.supp_plan_hashes
  expected = plan_table.hashes
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

Then /^VAT info should be:$/ do |vat_table|
  actual = @bus_site.admin_console_page.billing_info_section.vat_hashes
  expected = vat_table.hashes
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

Then /^Next renewal info table should be:$/ do |next_renewal_table|
  actual = @bus_site.admin_console_page.billing_info_section.next_renewal_hashes
  expected = next_renewal_table.hashes
  expected.each do |col|
    col.each do |k,v|
      case k
        when 'Date'
          v.replace(Chronic.parse(v).strftime('%b %d, %Y'))
        when 'Payment Type'
          v.gsub!(/@XXXX/,@partner.credit_card.last_four_digits) unless @partner.nil?
        else
          # do nothing
      end
    end
  end
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

When /^I (Enable|Disable) billing info autogrow$/ do |status|
  case status
    when "Enable"
      @bus_site.admin_console_page.billing_info_section.enable_autogrow
    when "Disable"
      @bus_site.admin_console_page.billing_info_section.disable_autogrow
    else
  end
end

