When /^I act as newly created partner|sub partner account$/ do
  @bus_site.admin_console_page.partner_details_section.act_as_partner
  @bus_site.admin_console_page.has_stop_masquerading_link?
  @partner_id = @bus_site.admin_console_page.current_partner_id
end

When /^I search and delete partner account by (.+)/ do |account_name|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_partner'])
  @bus_site.admin_console_page.search_list_partner_section.search_partner(account_name)

  rows = @bus_site.admin_console_page.search_list_partner_section.search_results_table_rows
  unless rows.to_s.include?('No results found.')
    @bus_site.admin_console_page.search_list_partner_section.view_partner_detail(account_name)
    @bus_site.admin_console_page.partner_details_section.delete_partner(BUS_ENV['bus_password'])
  end
end

# When you are on partner details section, you are able to execute this steps
When /^I delete partner account$/ do
  @bus_site.admin_console_page.partner_details_section.delete_partner(BUS_ENV['bus_password'])
end

When /^I get the partner_id$/ do
  @partner_id = @bus_site.admin_console_page.partner_details_section.partner_id()
  Log.debug("partner id is #{@partner_id}")
end

When /^I get partner aria id$/ do
  @aria_id = @bus_site.admin_console_page.partner_details_section.general_info_hash['Aria ID:']
end

Then /^Partner general information should be:$/ do |details_table|
  actual = @bus_site.admin_console_page.partner_details_section.general_info_hash
  expected = details_table.hashes.first

  expected.each do |k,v|
    case k
      when 'External ID:'
        v.gsub!(/@external_id/, @new_p_external_id) unless @new_p_external_id.nil?
      when 'Root Admin:'
        v.gsub!(/@root_admin/, @partner.admin_info.full_name) unless @partner.nil?
      when 'Next Charge:'
        v.replace(Chronic.parse(v).strftime('%m/%d/%y') + ' (extend)')
      when 'Marketing Referrals:'
        v.gsub!(/@login_admin_email/,@admin_username)
      else
        # do nothing
    end
  end
  expected.keys.each{ |key| actual[key].should == expected[key] }
end

# Any of following columns can be verified:
# | Company Type: | Users: | Contact Address: | Contact City: | Contact State: | Contact ZIP/Postal Code: |
# | Contact Country: | Phone: | Industry: | # of employees: | Contact Email: | Vat Number: |
Then /^Partner contact information should be:$/ do |contact_table|
  actual = @bus_site.admin_console_page.partner_details_section.contact_info_hash
  expected = contact_table.hashes.first

  expected.keys.each do |header|
    case header
      when 'Contact Email:'
        actual[header].should == expected[header].gsub(/@new_admin_email/,@partner.admin_info.email)
      when 'Contact Address:'
        actual[header].should == expected[header].gsub(/@address/, @partner.company_info.address)
      when 'Contact City:'
        actual[header].should == expected[header].gsub(/@city/, @partner.company_info.city)
      when 'Contact State:'
        actual[header].should == expected[header].gsub(/@state/, @partner.company_info.state_abbrev)
      when 'Contact ZIP/Postal Code:'
        actual[header].should == expected[header].gsub(/@zip_code/, @partner.company_info.zip)
      when 'Contact Country:'
        actual[header].should == expected[header].gsub(/@country/, @partner.company_info.country)
      else
        actual[header].should == expected[header]
    end
  end
end

When /^I Create an API key for current partner$/ do
  @bus_site.admin_console_page.partner_details_section.create_api_key
  @api_key = @bus_site.admin_console_page.partner_details_section.api_key
end

Then /^Partner API key should be (.+)$/ do |api_key|
  api_key = '' if api_key.eql?('empty')
  @bus_site.admin_console_page.partner_details_section.api_key.should == api_key
end

When /^I add a new ip whitelist (.+)$/ do |ip|
  @bus_site.admin_console_page.partner_details_section.add_ip_whitelist(ip)
end

Then /^Partner ip whitelist should be (.+)$/ do |ip|
  @bus_site.admin_console_page.partner_details_section.ip_whitelist.should == ip
end

Then /^Partner account attributes should be:$/ do |attributes_table|
  @bus_site.admin_console_page.partner_details_section.account_attributes_rows.should == attributes_table.raw
end

Then /^Partner resources should be:$/ do |resources_table|
  @bus_site.admin_console_page.partner_details_section.generic_resources_table_headers.should == resources_table.headers
  @bus_site.admin_console_page.partner_details_section.generic_resources_table_rows.should == resources_table.rows
end

Then /^Partner license types should be:$/ do |license_types_table|
  @bus_site.admin_console_page.partner_details_section.license_types_table_headers.should == license_types_table.headers
  @bus_site.admin_console_page.partner_details_section.license_types_table_rows.should == license_types_table.rows
end

Then /^Partner stash info should be:$/ do |stash_info_table|
  @bus_site.admin_console_page.partner_details_section.stash_info_table_rows.should == stash_info_table.raw
end

Then /^Partner internal billing should be:$/ do |internal_billing_table|
  actual = @bus_site.admin_console_page.partner_details_section.internal_billing_table_rows
  expected = internal_billing_table.raw

  renewal_date = Chronic.parse(expected[2][1])
  expected[2][1] =  renewal_date.strftime("%m/%d/%y") unless renewal_date.nil?
  actual.should == expected
end

Then /^Partner sub admins should be empty$/ do
  @bus_site.admin_console_page.partner_details_section.sub_admins_text.should include("No sub-admins.")
end

Then /^Partner sub admins should be:$/ do |sub_admins_table|
  @bus_site.admin_console_page.partner_details_section.sub_admins_table_headers.should == sub_admins_table.headers
  @bus_site.admin_console_page.partner_details_section.sub_admins_table_rows.should == sub_admins_table.rows
end

Then /^Partner billing history should be:$/ do |billing_history_table|
  actual = @bus_site.admin_console_page.partner_details_section.billing_history_hashes
  expected = billing_history_table.hashes
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

When /^I enable stash for the partner with (default|\d+ GB) stash storage$/ do |quota|
  if quota == 'default'
    @bus_site.admin_console_page.partner_details_section.enable_stash(2)
  else
    @bus_site.admin_console_page.partner_details_section.enable_stash(quota)
  end
end

When /^I disable stash for the partner$/ do
  @bus_site.admin_console_page.partner_details_section.disable_stash
  @bus_site.admin_console_page.click_submit
end

When /^I add stash to all users for the partner$/ do
  @bus_site.admin_console_page.partner_details_section.add_stash_to_all_users
  @bus_site.admin_console_page.click_continue
  @bus_site.admin_console_page.partner_details_section.wait_until_bus_section_load
end

# From partner details view, click Status: Active (change) link
# Select Suspended
# Click Submit
When /^I suspend the partner$/ do
  @bus_site.admin_console_page.partner_details_section.suspend_partner
end

# From partner details view, click Status: Active (change) link
# Select Suspended
# Click Submit
When /^I activate the partner$/ do
  @bus_site.admin_console_page.partner_details_section.activate_partner
end

When /^I change partner external id to (.+)$/ do |external_id|
  @bus_site.admin_console_page.partner_details_section.change_external_id(external_id)
end

When /^I add a new partner external id$/ do
  @new_p_external_id = "#{Time.now.strftime('%m%d-%H%M-%S')}"
  @bus_site.admin_console_page.partner_details_section.change_external_id(@new_p_external_id)
end

When /^I change the subdomain to @subdomain$/ do
  @subdomain = (0...8).map{(97+Random.new.rand(26)).chr}.join
  @bus_site.admin_console_page.partner_details_section.change_subdomain
  @bus_site.partner_subdomain_page.change_subdomain @subdomain
end

Then /^The subdomain is created with name https:\/\/@subdomain.mozypro.com\/$/ do
  @bus_site.partner_subdomain_page.subdomain.should == "https:\/\/#{@subdomain}.mozypro.com\/"
  @bus_site.partner_subdomain_page.close_page
end

When /^The subdomain in BUS will be @subdomain$/ do
  @bus_site.admin_console_page.partner_details_section.refresh_bus_section
  #something here
  @bus_site.admin_console_page.partner_details_section.subdomain.should == @subdomain
end
When /^I change the partner contact information to:$/ do |info_table|
  # table is a | address          | city          | state          | zip_code                 | country          |
  new_info = info_table.hashes.first
  new_info.keys.each do |header|
    case header
      when 'Contact Email:'
        @bus_site.admin_console_page.partner_details_section.set_contact_email(new_info[header])
      when 'Contact Address:'
        @bus_site.admin_console_page.partner_details_section.set_contact_address(new_info[header])
      when 'Contact City:'
        @bus_site.admin_console_page.partner_details_section.set_contact_city(new_info[header])
      when 'Contact Country:'
        @bus_site.admin_console_page.partner_details_section.set_contact_country(new_info[header])
      when 'Contact State:'
        @bus_site.admin_console_page.partner_details_section.set_contact_state(new_info[header])
      when 'Contact ZIP/Postal Code:'
        @bus_site.admin_console_page.partner_details_section.set_contact_zip(new_info[header])
      else
        raise "Unexpected #{new_info[header]}"
    end
  end
  @bus_site.admin_console_page.partner_details_section.save_changes
end

Then /^Partner contact information is changed$/ do
  @bus_site.admin_console_page.partner_details_section.wait_until_bus_section_load
end

Then /^partner details message should be$/ do |message|
  @bus_site.admin_console_page.partner_details_section.success_messages == message
end
