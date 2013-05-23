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