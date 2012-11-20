
When /^I act as newly created partner account$/ do
  @bus_site.admin_console_page.partner_details_section.act_as_partner
  @bus_site.admin_console_page.has_stop_masquerading_link?
end

When /^I search and delete partner account by (.+)/ do |account_name|
  @bus_site.admin_console_page.navigate_to_link(CONFIGS['bus']['menu']['search_list_partner'])
  @bus_site.admin_console_page.search_list_partner_section.search_partner(account_name)

  rows_text = @bus_site.admin_console_page.search_list_partner_section.search_results_table_rows
  unless rows_text.count == 7 && rows_text[1].to_s == "[\"No results found.\"]"
    @bus_site.admin_console_page.search_list_partner_section.view_partner_detail(account_name)
    @bus_site.admin_console_page.partner_details_section.delete_partner(BUS_ENV['bus_password'])
  end
end

# When you are on partner details section, you are able to execute this steps
When /^I delete partner account$/ do
  @bus_site.admin_console_page.partner_details_section.delete_partner(BUS_ENV['bus_password'])
end

When /^I get the partner_id$/ do
  @partner_id = @bus_site.admin_console_page.partner_details_section.get_partner_id()
  Log.debug("partner id is #{@partner_id}")
end

Then /^Partner general information should be:$/ do |details_table|
  @bus_site.admin_console_page.partner_details_section.has_delete_partner_link?
  actual = @bus_site.admin_console_page.partner_details_section.general_info_hash
  expected = details_table.hashes.first

  expected.keys.each do |header|
    case header
      when 'ID:'
        if expected[header].start_with?('@')
          actual[header].length.should == expected[header].length - 1
          actual[header].match(/\d{6}/).nil?.should be_false
        else
          actual[header].should == expected[header]
        end
      when 'Aria ID:'
        if expected[header].start_with?('@')
          actual[header].length.should == expected[header].length - 1
          actual[header].match(/\d{7}/).nil?.should be_false
        else
          actual[header].should == expected[header]
        end
      when 'Approved:'
        # In bus UI, approved date has been convert to local time.
        approved_date = Time.now
        actual[header].should include(approved_date.nil? ? expected[header] : approved_date.strftime("%m/%d/%y"))
      when 'Next Charge:'
        next_charge = Chronic.parse(expected[header])
        actual[header].should include(next_charge.nil? ? expected[header] : next_charge.strftime("%m/%d/%y"))
      when 'Root Admin:'
        actual[header].should == expected[header].gsub(/@root_admin/,@partner.admin_info.full_name)
      when 'Marketing Referrals:'
        actual[header].should == expected[header].gsub(/@login_admin_email/,@admin_username)
      else
        actual[header].should == expected[header]
    end
  end
end

# Any of following columns can be verified:
# | Company Type: | Users: | Contact Address: | Contact City: | Contact State: | Contact ZIP/Postal Code: |
# | Contact Country: | Phone: | Industry: | # of employees: | Contact Email: | Vat Number: |
Then /^Partner contact information should be:$/ do |contact_table|
  @bus_site.admin_console_page.partner_details_section.has_delete_partner_link?
  actual = @bus_site.admin_console_page.partner_details_section.contact_info_hash
  expected = contact_table.hashes.first

  expected.keys.each do |header|
    case header
      when 'Contact Email:'
        actual[header].should == expected[header].gsub(/@new_admin_email/,@partner.admin_info.email)
      else
        actual[header].should == expected[header]
    end
  end
end

Then /^Partner account attributes should be:$/ do |attributes_table|
  @bus_site.admin_console_page.partner_details_section.has_delete_partner_link?
  @bus_site.admin_console_page.partner_details_section.account_attributes_rows.should == attributes_table.raw
end

Then /^Partner resources should be:$/ do |resources_table|
  @bus_site.admin_console_page.partner_details_section.has_delete_partner_link?
  @bus_site.admin_console_page.partner_details_section.generic_resources_table_headers.should == resources_table.headers
  @bus_site.admin_console_page.partner_details_section.generic_resources_table_rows.should == resources_table.rows
end

Then /^Partner license types should be:$/ do |license_types_table|
  @bus_site.admin_console_page.partner_details_section.has_delete_partner_link?
  @bus_site.admin_console_page.partner_details_section.license_types_table_headers.should == license_types_table.headers
  @bus_site.admin_console_page.partner_details_section.license_types_table_rows.should == license_types_table.rows
end

Then /^Partner internal billing should be:$/ do |internal_billing_table|
  @bus_site.admin_console_page.partner_details_section.has_delete_partner_link?
  actual = @bus_site.admin_console_page.partner_details_section.internal_billing_table_rows
  expected = internal_billing_table.raw

  renewal_date = Chronic.parse(expected[2][1])
  expected[2][1] =  renewal_date.strftime("%m/%d/%y") unless renewal_date.nil?
  actual.should == expected
end

Then /^Partner sub admins should be empty$/ do
  @bus_site.admin_console_page.partner_details_section.has_delete_partner_link?
  @bus_site.admin_console_page.partner_details_section.sub_admins_text.should include("No sub-admins.")
end

Then /^Partner sub admins should be:$/ do |sub_admins_table|
  @bus_site.admin_console_page.partner_details_section.has_delete_partner_link?
  @bus_site.admin_console_page.partner_details_section.sub_admins_table_headers.should == sub_admins_table.headers
  @bus_site.admin_console_page.partner_details_section.sub_admins_table_rows.should == sub_admins_table.rows
end

Then /^Partner billing history should be:$/ do |billing_history_table|
  @bus_site.admin_console_page.partner_details_section.has_delete_partner_link?
  billing_history_table.map_column!('Date') do |value|
    Chronic.parse(value).strftime("%m/%d/%y")
  end
  @bus_site.admin_console_page.partner_details_section.billing_history_table_headers.should == billing_history_table.headers
  @bus_site.admin_console_page.partner_details_section.billing_history_table_rows.should == billing_history_table.rows
end

When /^I enable stash for the partner with (default|\d+ GB) stash storage$/ do |quota|
    if quota == 'default'
      @bus_site.admin_console_page.partner_details_section.enable_stash
    else
      @bus_site.admin_console_page.partner_details_section.enable_stash(quota)
    end
end