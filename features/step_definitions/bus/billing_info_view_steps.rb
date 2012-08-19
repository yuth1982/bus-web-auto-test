
Then /^Next Renewal text align is set to left justify$/ do
  @bus_admin_console_page.billing_info_section.next_renewal_text_align_css.should == "start"
end

Then /^Autogrow status text's should be (.+)$/ do |value|
  @bus_admin_console_page.billing_info_section.autogrow_status.should == value
end

Then /^Next renewal supplemental plan details should be:$/ do |plan_table|
  @bus_admin_console_page.billing_info_section.supp_plan_table_rows.should == plan_table.hashes.map { |el| el.values }
end

Then /^VAT table should be:$/ do |vat_num_table|
  @bus_admin_console_page.billing_info_section.vat_table_rows.should == vat_num_table.rows.map{|row| row.delete_if{|cell| cell.empty? }}
end

Then /^Next renewal info table should be:$/ do |next_renewal_table|
  next_renewal_table.map_column!('value') do |value|
    months = value.match(/\+(\d+) month\(s\)/)
    unless months.nil?
      value = (Time.now.localtime("-06:00").to_datetime >> months[1].to_s.to_i).strftime("%b %d, %Y")
    end
     value.gsub(/@XXXX/, @partner.credit_card.last_four_digits)
   end
  @bus_admin_console_page.billing_info_section.next_renewal_table_rows.should == next_renewal_table.rows
end