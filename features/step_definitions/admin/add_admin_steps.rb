When /^I add a new admin:$/ do |table|
  # table is a | ATC695 | leongh+atc695@mozy.com | ATC695 |pending
  admin_hash = table.hashes.first
  roles = (admin_hash['Roles'] || '').split(',').compact
  user_groups = (admin_hash['User Group'] || '').split(',').compact
  roles.each do | v |
    v.gsub!(/@new_role/,  @role.name)
  end
  @admin = Bus::DataObj::Admin.new(admin_hash['Name'], admin_hash['Email'], admin_hash['Parent'], user_groups, roles)
  @bus_site.admin_console_page.add_new_admin_section.add_new_admin(@admin)
end

Then /^I should see capabilities in Admin Console panel$/ do |table|
  # table is a | Search / List Partners |pending
  data = table.raw[1..-1]
  data.each do | d |
    @bus_site.admin_console_page.has_navigation?(d[0]).should_not be_nil
  end
end

When /^I search admin by:$/ do |search_key_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_admin'])
  attributes = search_key_table.hashes.first
  keywords = attributes["name"] || attributes["email"].gsub(/@new_admin/, @admin.email)
  @bus_site.admin_console_page.search_admins_section.search_admin(keywords)
end

When /^I act as admin by:$/ do |table|
  # table is a | leongh+atc695@mozy.com |pending
  step %{I search admin by:}, table(%{
    |#{table.headers.join('|')}|
    |#{table.rows.first.join('|')}|
  })

  attributes = table.hashes.first
  page.find_link(attributes["email"].gsub(/@new_admin/, @admin.email)[0..24] || attributes["name"]).click
  @bus_site.admin_console_page.admin_details_section.act_as_admin
  @bus_site.admin_console_page.has_stop_masquerading_link?
end

When /^I delete admin by:$/ do |table|
  step %{I search admin by:}, table(%{
    |#{table.headers.join('|')}|
    |#{table.rows.first.join('|')}|
    })
  attributes = table.hashes.first
  page.find_link(attributes["email"].gsub(/@new_admin/, @admin.email)[0..24] || attributes["name"]).click
  @bus_site.admin_console_page.admin_details_section.delete_admin(BUS_ENV['bus_password'])
  step "I navigate to Search Admins section from bus admin console page"
  @bus_site.admin_console_page.search_admins_section.refresh_bus_section
end

When /^I list partner details for a partner in partner list$/ do
  # get the 1st partner in the list
  partner_link = @bus_site.admin_console_page.find(:xpath, "//div[@id = 'partner-list-content']/div/table/tbody//a")
  partner_link.click
  @bus_site.admin_console_page.partner_details_section.wait_until_bus_section_load
end

When /^I (can|cannot) change partner name$/ do | c |
  case c
    when "can"
      @bus_site.admin_console_page.has_navigation?("Change Name").size.should == 1
    when "cannot"
      @bus_site.admin_console_page.has_navigation?("Change Name").should be_empty
    else
  end
end

When /^I can delete partner$/ do
  @bus_site.admin_console_page.partner_details_section.find(:xpath, "//a[text() = 'Delete Partner']").should_not be_nil
end

When /^I can change fields:$/ do |table|
  # table is a | External ID |pending
  data = table.raw[1..-1]
  general_info_hash = @bus_site.admin_console_page.partner_details_section.general_info_hash
  data.each do | d |
    general_info_hash[d[0]].should include('change')
  end
end

Then /^I can edit partner details fields:$/ do |table|
  # table is a | Phone  |pending
  # table is a | External ID |pending
  data = table.raw[1..-1]
  data.each do | d |
    case d[0]
      when "Phone:"
        @bus_site.admin_console_page.partner_details_section.find(:id, "partner_contact_phone").should_not be_nil
      when "Industry:"
        @bus_site.admin_console_page.partner_details_section.find(:id, "partner_industry").should_not be_nil
      when "# of employees:"
        @bus_site.admin_console_page.partner_details_section.find(:id, "partner_num_employees").should_not be_nil
      else
        # Need to implement the ones you want to check existance
    end
  end
end


When /^I delete partner account with password (.+)$/ do | pw |
  warning_msg = @bus_site.admin_console_page.partner_details_section.delete_partner(pw, false)
  warning_msg.should include("Incorrect password.")
end

Then /^new admin should be created$/ do
  @bus_site.admin_console_page.add_new_admin_section.messages.should == "New Admin created. Please have the Admin check his or her email to complete the process."
end
