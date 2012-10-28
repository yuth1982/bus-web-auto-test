
When /^I act as newly created partner account$/ do
  @bus_site.admin_console_page.partner_details_section.act_as_partner
  @bus_site.admin_console_page.has_stop_masquerading_link?
end

Given /^I act as a partner (.*)$/ do |partner_name|
  @bus_site.admin_console_page.search_list_partner_section.search_partner partner_name
  page.find_link(partner_name).click
  @bus_site.admin_console_page.partner_details_section.act_as_partner
  @bus_site.admin_console_page.has_stop_masquerading_link?
end

When /^I search and delete (.+) account/ do |account_name|
  @bus_site.admin_console_page.navigate_to_link(CONFIGS['bus']['menu']['search_list_partner'])
  @bus_site.admin_console_page.search_list_partner_section.search_partner(account_name)

  rows_text = @bus_site.admin_console_page.search_list_partner_section.search_results_table_rows
  unless rows_text.count == 7 && rows_text[1].to_s == "[\"No results found.\"]"
    @bus_site.admin_console_page.search_list_partner_section.view_partner_detail(account_name)
    @bus_site.admin_console_page.partner_details_section.delete_partner(CONFIGS['global']['test_pwd'])
  end
end

# When you are on partner details section, you are able to execute this steps
When /^I delete partner account$/ do
  @bus_site.admin_console_page.partner_details_section.delete_partner(CONFIGS['global']['test_pwd'])
end

When /^I get the partner_id$/ do
  @partner_id = @bus_site.admin_console_page.partner_details_section.get_partner_id()
  Log.debug("partner id is #{@partner_id}")
end

Then /^Partner general information should be:$/ do |details_table|
  actual = @bus_site.admin_console_page.partner_details_section.general_info_hash
  expected = details_table.hashes.first

  expected.keys.each do |header|
    case header
      when 'ID:'
        if expected[header].start_with?('@')
          actual[header].length.should == expected[header].length - 1
          actual[header].match(/\d{6}/).nil?.should be_false
        else
          expected[header].should == actual[header]
        end
      when 'Aria ID:'
        if expected[header].start_with?('@')
          actual[header].length.should == expected[header].length - 1
          actual[header].match(/\d{7}/).nil?.should be_false
        else
          expected[header].should == actual[header]
        end
      when 'Approved:'
        actual[header].should include(@partner.nil? ? expected[header] : Time.now.localtime("-06:00").strftime("%m/%d/%y"))
      when 'Next Charge:'
        months = expected[header].match(/\+(\d+) month\(s\)/)
        if months.nil?
          actual[header].should == expected[header]
        else
          next_date = (Time.now.localtime("-06:00").to_datetime >> months[1].to_s.to_i).strftime("%m/%d/%y")
          actual[header].should include(next_date)
        end
      when 'Marketing Referrals:'
        actual[header].should include(@admin_username)
      else
        expected[header].should == actual[header]
    end
  end
end

# Any of following columns can be verified:
# | Company Type: | Users: | Contact Address: | Contact City: | Contact State: | Contact ZIP/Postal Code: |
# | Contact Country: | Phone: | Industry: | # of employees: | Contact Email: | Vat Number: |
Then /^Partner contact information should be:$/ do |contact_table|
  actual = @bus_site.admin_console_page.partner_details_section.contact_info_hash
  expected = contact_table.hashes.first
  expected.keys.each{ |key| expected[key].should == actual[key]}
end