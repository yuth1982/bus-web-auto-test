
When /^I act as newly created partner account$/ do
  @bus_site.admin_console_page.partner_details_section.act_as_partner
end

Given /^I act as a partner (.*)$/ do |partner_name|
  @bus_site.admin_console_page.search_list_partner_section.search_partner partner_name
  page.find_link(partner_name).click
  @bus_site.admin_console_page.partner_details_section.act_as_partner
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

  actual['ID:'].length.should == expected['ID:'].length - 1
  actual['ID:'].match(/\d{6}/).nil?.should be_false
  actual['External ID:'].should == expected['External ID:']
  actual['Aria ID:'].length.should == expected['Aria ID:'].length - 1
  actual['Aria ID:'].match(/\d{7}/).nil?.should be_false
  #actual['Approved:'].should include(expected['Approved:'].gsub(/@today/,Time.now.localtime("-06:00").strftime("%m/%d/%y")))
  actual['Status:'].should == expected['Status:']
  actual['Root Admin:'].should == expected['Root Admin:'].gsub(/@admin_name/, @partner.admin_info.full_name)
  actual['Root Role:'].should == expected['Root Role:']
  actual['Parent:'].should == expected['Parent:']
  months = expected['Next Charge:'].match(/\+(\d+) month\(s\)/)
  unless months.nil?
    next_date = (Time.now.localtime("-06:00").to_datetime >> months[1].to_s.to_i).strftime("%m/%d/%y")
    actual['Next Charge:'].should == expected['Next Charge:'].gsub(months.to_s,next_date)
  end
  actual['Marketing Referrals:'].should == expected['Marketing Referrals:'].gsub(/@parent_admin_email/,@admin_username)
  actual['Subdomain:'].should == expected['Subdomain:']
  actual['Enable Mobile Access:'].should == expected['Enable Mobile Access:']
  actual['Enable Co-branding:'].should == expected['Enable Co-branding:']
  actual['Require Ingredient:'].should == expected['Require Ingredient:']
  actual['Enable Autogrow:'].should == expected['Enable Autogrow:']
end

Then /^Partner contact information should be:$/ do |contact_table|
  @bus_site.admin_console_page.partner_details_section.contact_info_hash.should == contact_table.hashes.first
end