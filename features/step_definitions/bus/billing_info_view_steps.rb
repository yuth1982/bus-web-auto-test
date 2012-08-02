
Then /^Next Renewal text align is set to left justify$/ do
  @bus_admin_console_page.billing_info_section.next_renewal_text_align_css.should == "start"
end

Then /^Autogrow status text's should be (.+)$/ do |value|
  @bus_admin_console_page.billing_info_section.autogrow_status_text.should == value
end

Then /^Next renewal supplemental plan details should be:$/ do |plan_table|
  @bus_admin_console_page.billing_info_section.supp_plan_tb_rows_text.should == plan_table.hashes.map { |el| el.values }
end

Then /^VAT table should be:$/ do |vat_num_table|
  @bus_admin_console_page.billing_info_section.vat_tb_rows_text.should == vat_num_table.rows.map{|row| row.delete_if{|cell| cell.empty? }}
end

Then /^Next renewal info table should be:$/ do |next_renewal_table|
  next_renewal_table.map_column!('value') do |value|
    months = value.match(/\+(\d+) month\(s\)/)
    unless months.nil?
      value = (DateTime.now >> months[1].to_s.to_i).to_time.localtime("-06:00").strftime("%b %d, %Y")
    end
     value.gsub(/@XXXX/, @partner.credit_card.number[12..-1])
   end
  @bus_admin_console_page.billing_info_section.next_renewal_tb_rows_text.should == next_renewal_table.rows
end