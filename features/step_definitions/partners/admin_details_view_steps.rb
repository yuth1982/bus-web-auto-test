# Steps included:
#   click 'Search / List Partners' link
#   fill in newly created admin email and click search
#   click newly created  admin email to get admin detail view
#   click 'Act Admin' link
#   fill in password with default password (in bus config file)
#   fill in confirm password with default password
#   click 'Save Changes'
#
When /^I activate new partner admin with default password$/ do
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_partner'])
  @bus_site.admin_console_page.search_list_partner_section.search_partner(@partner.admin_info.email)
  @bus_site.admin_console_page.search_list_partner_section.view_partner_detail(@partner.admin_info.email)
  password = CONFIGS['global']['test_pwd']
  @bus_site.admin_console_page.admin_details_section.activate_admin(password, password)
end

When /^I view the newly created (sub)*partner admin details$/ do |sub|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_partner'])
  if sub
    @bus_site.admin_console_page.search_list_partner_section.search_partner(@subpartner.admin_email_address)
    @bus_site.admin_console_page.search_list_partner_section.view_partner_detail(@subpartner.admin_email_address)
  else
    @bus_site.admin_console_page.search_list_partner_section.search_partner(@partner.admin_info.email)
    @bus_site.admin_console_page.search_list_partner_section.view_partner_detail(@partner.admin_info.email)
  end
  @bus_site.admin_console_page.admin_details_section.wait_until_bus_section_load
end

#Then /^I should see the (.+) link$/ do |link_name|
#  @bus_site.admin_console_page.admin_details_section.links.should inlcude(link_name);
#end

Then /^I will( not)? see the activate admin link$/ do |t|
  if t.nil?
    @bus_site.admin_console_page.admin_details_section.has_activate_admin_link?.should be_true
  else
    @bus_site.admin_console_page.admin_details_section.has_activate_admin_link?.should be_false
  end
end

When /^I view the admin details of (.+)$/ do |admin|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['list_admins'])
  @bus_site.admin_console_page.list_admins_section.refresh_bus_section
  @bus_site.admin_console_page.list_admins_section.wait_until_bus_section_load
  @bus_site.admin_console_page.list_admins_section.view_admin(admin)
  @bus_site.admin_console_page.list_admins_section.wait_until_bus_section_load
end

When /^I get the admin id from partner details$/ do
  @bus_site.admin_console_page.partner_details_section.find_link(@partner.admin_info.full_name).click
  @admin_id = @bus_site.admin_console_page.admin_details_section.admin_id
  Log.debug("admin id is #{@admin_id}")
end

When /^edit admin details:$/ do |info_table|
  # table is a | email          | name          | parent admin     |
  new_info = info_table.hashes.first
  new_info.keys.each do |header|
    case header
      when 'Email:'
        new_info[header] = @existing_user_email if new_info[header] == '@existing_user_email'
        new_info[header] = @existing_admin_email if new_info[header] == '@existing_admin_email'
        @bus_site.admin_console_page.admin_details_section.set_admin_email(new_info[header])
      when 'Name:'
        @bus_site.admin_console_page.admin_details_section.set_admin_name(new_info[header])
      when 'Parent Admin:'
        @bus_site.admin_console_page.admin_details_section.set_admin_parent(new_info[header])
      else
        raise "Unexpected header for #{new_info[header]}"
    end
  end
  @bus_site.admin_console_page.admin_details_section.save_admin_info_changes
end

When /^edit sub admin personal information success message should display$/ do
  @bus_site.admin_console_page.admin_details_section.admin_info_box_message.should == "Changes saved successfully."
end

When /^edit sub admin personal information error message\(s\) should be:$/ do |message|
  @bus_site.admin_console_page.admin_details_section.admin_info_box_message.should == message.to_s
end

When /^I close the admin details section$/ do
  @bus_site.admin_console_page.admin_details_section.close_bus_section
end
