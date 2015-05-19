When /^I act as newly created (sub)*partner( account)?$/ do |type, account|
  if type.nil?
    @current_partner = @bus_site.admin_console_page.partner_details_section.partner
    @bus_site.admin_console_page.partner_details_section.act_as_partner
    @bus_site.admin_console_page.has_stop_masquerading_link?
  else
    @current_partner = @bus_site.admin_console_page.partner_details_section.subpartner.partner
    @bus_site.admin_console_page.partner_details_section.subpartner.act_as_partner
    @bus_site.admin_console_page.has_content?(@subpartner.company_name)
  end
  @partner_id = @bus_site.admin_console_page.current_partner_id
end

When /^I add partner settings$/ do |table|
  #    | Name                    | Value | Locked |
  #    | allow_ad_authentication | t     | yes    |
  @bus_site.admin_console_page.partner_details_section.add_settings(table.hashes)
  @bus_site.admin_console_page.partner_details_section.close_settings
end

When /^I delete partner settings$/ do |table|
  # | Name | Value |
  @bus_site.admin_console_page.partner_details_section.delete_settings(table.hashes)
  @bus_site.admin_console_page.partner_details_section.close_settings
end

When /^I search and delete partner account by (.+)/ do |account_name|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_partner'])
  @bus_site.admin_console_page.search_list_partner_section.search_partner(account_name)

  rows = @bus_site.admin_console_page.search_list_partner_section.search_results_table_rows
  unless rows.to_s.include?('No results found.')
    @bus_site.admin_console_page.search_list_partner_section.view_partner_detail(account_name)
    @bus_site.admin_console_page.partner_details_section.delete_partner(QA_ENV['bus_password'])
  else
    raise "Cannot find newly created partner #{account_name}."
  end
end

When /^I search and delete partner account if it exists by (.+)/ do |account_name|
  begin
    step %{I search and delete partner account by #{account_name}}
  rescue Exception => ex
    Log.debug ex.to_s
  end
end

# When you are on partner details section, you are able to execute this steps
When /^I delete (partner|subpartner) account$/ do |status|
  case status
    when "partner"
      @bus_site.admin_console_page.partner_details_section.delete_partner(QA_ENV['bus_password'])
    when "subpartner"
      @bus_site.admin_console_page.partner_details_section.subpartner.delete_partner(QA_ENV['bus_password'])
    else
  end
end

When /^I get the partner_id$/ do
  @partner_id = @bus_site.admin_console_page.partner_details_section.partner_id()
  Log.debug("partner id is #{@partner_id}")
end

When /^I get partner aria id$/ do
  @aria_id = @bus_site.admin_console_page.partner_details_section.general_info_hash['Aria ID:']
end

Then /^(Partner|SubPartner) general information should be:$/ do |status,details_table|
  case status
    when "Partner"
      actual = @bus_site.admin_console_page.partner_details_section.general_info_hash
    when "SubPartner"
      actual = @bus_site.admin_console_page.partner_details_section.subpartner.general_info_hash
    else
  end
  expected = details_table.hashes.first

  expected.each do |k,v|
    # Using erb instead of place holder such as @external_id
    case k
      when 'External ID:'
        v.gsub!(/@external_id/, @new_p_external_id) unless @new_p_external_id.nil?
      when 'Root Admin:'
        v.gsub!(/@root_admin/, @partner.admin_info.full_name) unless @partner.nil?
      when 'Marketing Referrals:'
        v.gsub!(/@login_admin_email/,@admin_username)
        v.gsub!(/@bus01_admin/, QA_ENV['bus01_admin'])
      else
        # do nothing
    end
    v.replace ERB.new(v).result(binding)
  end
  #(BDS Online Backup) in parent string for some env but not others
  expected.keys.each{ |key| actual[key].should include(expected[key]) }
end

And /^I enabled server in partner account details$/ do
  @bus_site.admin_console_page.partner_details_section.account_details_enable_server
end

Then /^partner account details should be:$/ do |account_details_table|
  actual = @bus_site.admin_console_page.partner_details_section.account_details_hash
  expected = account_details_table.hashes.first
  expected.keys.each{ |key| actual[key].should == expected[key] }
end

# Any of following columns can be verified:
# | Company Type: | Users: | Contact Address: | Contact City: | Contact State: | Contact ZIP/Postal Code: |
# | Contact Country: | Phone: | Industry: | # of employees: | Contact Email: | Vat Number: |
Then /^Partner contact information should be:$/ do |contact_table|
  actual = @bus_site.admin_console_page.partner_details_section.contact_info_hash
  expected = contact_table.hashes.first

  expected.each do |_,v|
    v.replace ERB.new(v).result(binding)
  end

  expected.keys.each{ |key| actual[key].should == expected[key] }
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
  @bus_site.admin_console_page.partner_details_section.wait_until_bus_section_load
  @bus_site.admin_console_page.partner_details_section.ip_whitelist.should == ip
end

Then /^Partner account attributes should be:$/ do |attributes_table|
  actual = @bus_site.admin_console_page.partner_details_section.account_attributes_hashes
  expected = attributes_table.rows_hash
  expected.keys.each{ |key| actual[key].should == expected[key] }
end

Then /^Partner resources should be:$/ do |resources_table|
  @bus_site.admin_console_page.partner_details_section.generic_resources_table_headers.should == resources_table.headers
  @bus_site.admin_console_page.partner_details_section.generic_resources_table_rows.should == resources_table.rows
end

Then /^Itemized partner resources should be:$/ do |resources_table|
  @bus_site.admin_console_page.partner_details_section.license_types_table_headers.should == resources_table.headers
  @bus_site.admin_console_page.partner_details_section.license_types_table_rows.should == resources_table.rows
end

Then /^Partner pooled storage information should be:$/ do |resources_table|
  resources_table.raw[1..-1].each do |row|
    range = row.first.match(/(Desktop|Server)/) ? 1..3 : 0..2
    row[range].each do |v|
      unless v.match(/\d+ .B/)
        v.replace(number_to_human_size(v.match(/\d+/)[0].to_i))
      end
    end
  end
  @bus_site.admin_console_page.partner_details_section.pooled_resource_table_rows.should == resources_table.raw
end

Then /^Partner license types should be:$/ do |license_types_table|
  @bus_site.admin_console_page.partner_details_section.license_types_table_headers.should == license_types_table.headers
  @bus_site.admin_console_page.partner_details_section.license_types_table_rows.should == license_types_table.rows
end

Then /^(Partner|SubPartner) stash info should be:$/ do |status,stash_info_table|
  case status
    when "Partner"
      @bus_site.admin_console_page.partner_details_section.stash_info_table_rows.should == stash_info_table.raw
    when "SubPartner"
      @bus_site.admin_console_page.partner_details_section.subpartner.stash_info_table_rows.should == stash_info_table.raw
    else
  end
end

Then /^Partner internal billing should be:$/ do |internal_billing_table|
  actual = @bus_site.admin_console_page.partner_details_section.internal_billing_table_rows
  expected = internal_billing_table.raw
  with_timezone(ARIA_ENV['timezone']) do
    expected[2][1].replace(Chronic.parse(expected[2][1]).strftime('%m/%d/%y'))
    expected[3][1].replace(Chronic.parse(expected[3][1]).strftime('%m/%d/%y'))
  end
  actual.flatten.should == expected.flatten.select { |item| item != '' }
end

Then /^New Partner internal billing should be:$/ do |internal_billing_table|
  actual = @bus_site.admin_console_page.partner_details_section.internal_billing_table_rows
  expected = internal_billing_table.raw
  expected[1][1].replace ERB.new(expected[1][1]).result(binding)
  case ERB.new(expected[0][3]).result(binding)
    when "1"
      expected[0][3].replace "Monthly"
      expected[2][1].replace "after 1 month"
      expected[3][1].replace "after 1 month"
    when "12"
      expected[0][3].replace "Yearly"
      expected[2][1].replace "after 1 year"
      expected[3][1].replace "after 1 year"
    when "24"
      expected[0][3].replace "Biennial"
      expected[2][1].replace "after 2 years"
      expected[3][1].replace "after 2 years"
  end

  with_timezone(ARIA_ENV['timezone']) do
    expected[2][1].replace(Chronic.parse(expected[2][1]).strftime('%m/%d/%y'))
    expected[3][1].replace(Chronic.parse(expected[3][1]).strftime('%m/%d/%y'))
  end

  actual.flatten.should == expected.flatten.select { |item| item != '' }

  Log.debug(expected)
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
          with_timezone(ARIA_ENV['timezone']) do
            v.replace(Chronic.parse(v).strftime("%m/%d/%y"))
            Log.debug "Aria time is #{Chronic.now}"
          end
        else
          v.replace ERB.new(v).result(binding)
      end
    end
  end
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

When /^I enable stash for the partner$/ do
  @bus_site.admin_console_page.partner_details_section.enable_stash
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
  step 'I try to add stash to all users for the partner'
  @bus_site.admin_console_page.click_yes
  @bus_site.admin_console_page.partner_details_section.wait_until_bus_section_load
end

When /^I try to add stash to all users for the partner$/ do
  @bus_site.admin_console_page.partner_details_section.add_stash_to_all_users
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

When /^I change account type to (.+)$/ do | type |
  @bus_site.admin_console_page.partner_details_section.set_account_type(type)
end

Then /^account type should be changed to (.+) successfully$/ do |type|
  @bus_site.admin_console_page.partner_details_section.account_type.should include(type)
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
      when 'VAT Number:'
        @bus_site.admin_console_page.partner_details_section.set_vat_number(new_info[header])
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

When /^I (Enable|Disable) partner details autogrow$/ do |status|
  case status
    when "Enable"
      @bus_site.admin_console_page.partner_details_section.enable_autogrow
    when "Disable"
      @bus_site.admin_console_page.partner_details_section.disable_autogrow
    else
  end
end

When /^I change pooled resource for the subpartner:$/ do |table|
  @bus_site.admin_console_page.partner_details_section.subpartner.change_pooled_resource(friendly_hash(table.hashes.first))
end

When /^I refresh the partner details section$/ do
  @bus_site.admin_console_page.partner_details_section.refresh_bus_section
end

Then /^I delete partner and verify pending delete$/ do
  step "I search and delete partner account by newly created partner company name"
  step %{I search partner by:}, table(%{
    | name          | filter         |
    | @company_name | Pending Delete |
  })
  step %{Partner search results should be:}, table(%{
    | Partner       |
    | @company_name |
  })
end

Then /^I open partner details by partner name in header$/ do
  @bus_site.admin_console_page.open_partner_details_from_header(@partner)
  @bus_site.admin_console_page.partner_details_section.expand_contact_info
end

Then /^VAT number shouldn't be changed and the error message should be:$/ do  |message|
  @bus_site.admin_console_page.partner_details_section.error_message.should eq(message)
end

And /^I change contact country and VAT number to:$/ do |country_vat_table|
  attributes = country_vat_table.hashes.first
  attributes.each do |header,attribute| #can use variable inside <%= %>
    attribute.replace ERB.new(attribute).result(binding)
    attributes[header] = nil if attribute == ''
  end
  vat = attributes['VAT Number']
  country = attributes['Country']
  @bus_site.admin_console_page.partner_details_section.click_change_country_lnk
  @bus_site.admin_console_page.partner_details_section.set_country_for_partner_admin(country)
  if(vat == "@blank_space")
    @bus_site.admin_console_page.partner_details_section.set_vat_for_partner_admin("")
  else
    @bus_site.admin_console_page.partner_details_section.set_vat_for_partner_admin(vat) unless vat.nil?
  end
  @bus_site.admin_console_page.partner_details_section.submit_change
end

Then /^I am (.+) and I change contact country to (.+)$/ do |admin_type, country_type|
  @bus_site.admin_console_page.partner_details_section.click_change_country_lnk if admin_type == "partner admin"
  country = ""
  case country_type
    when "EU country"
      country = "France"
    else
      country = "United States"
  end
  if admin_type == "partner admin"
    @bus_site.admin_console_page.partner_details_section.set_country_for_partner_admin(country)
  else
    @bus_site.admin_console_page.partner_details_section.expand_contact_info
    @bus_site.admin_console_page.partner_details_section.set_contact_country(country)
  end
end

Then /^VAT number field of Change Contact Country section should (.+)$/ do |behavior|
  case behavior
    when "appear"
      @bus_site.admin_console_page.partner_details_section.vat_of_chg_contact_country_visible?.should be_true
    else
      @bus_site.admin_console_page.partner_details_section.vat_of_chg_contact_country_visible?.should be_false
  end
end

Then /^Change contact country and VAT number (.+) succeed and the message should be:$/ do |status,message|
  case status
    when 'should'
      @bus_site.admin_console_page.partner_details_section.success_messages.should eq(message)
    else
      @bus_site.admin_console_page.partner_details_section.error_message.should eq(message)
  end
end


Then /^VAT number field of Partner Details section should (.+)$/ do |behavior|
  case behavior
    when "appear"
      @bus_site.admin_console_page.partner_details_section.vat_number_visible?.should be_true
    else
      @bus_site.admin_console_page.partner_details_section.vat_number_visible?.should be_false
  end
end

Then /^I expand contact info from partner details section$/ do
  @bus_site.admin_console_page.partner_details_section.expand_contact_info
end
