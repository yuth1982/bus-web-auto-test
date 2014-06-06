When /^I navigate to (.+) section from bus admin console page$/ do |link_name|
  @bus_site.admin_console_page.navigate_to_menu(link_name)
end

When /^I close Mozy Stash invitation popup window$/ do
  @bus_site.admin_console_page.close_stash_invitation_popup
end

When /^I stop masquerading( from subpartner)*$/ do |sub|
  @bus_site.admin_console_page.stop_masquerading
  @bus_site.admin_console_page.has_no_link?('stop masquerading').should be_true if sub.nil?
end

When /^I stop masquerading as sub partner$/ do
  @bus_site.admin_console_page.stop_masquerading
end

Then /^I should not see (.+) link$/ do |link|
  @bus_site.admin_console_page.has_no_link?(link).should be_true
end

Then /^Popup window message should be (.+)$/ do |message|
  @bus_site.admin_console_page.popup_window_content.gsub("\n"," ").should == message
end

Then /^I close popup window$/ do
  @bus_site.admin_console_page.close_popup_window
end

Then /^I click Close button on popup window$/ do
  @bus_site.admin_console_page.click_close
end

Then /^I click Yes button on popup window$/ do
  @bus_site.admin_console_page.click_yes
end

Then /^I click Cancel button on popup window$/ do
  @bus_site.admin_console_page.click_cancel
end

Then /^I click Buy More button on popup window$/ do
  @bus_site.admin_console_page.buy_more_resources
end

Then /^I click Allocate button on popup window$/ do
  @bus_site.admin_console_page.allocate_resources
end

When /^I save admin console page cookies (.+) value$/ do |name|
  cookie = @bus_site.admin_console_page.cookies.select{ |cookie| cookie[:name] == name }.first
  @admin_console_page_cookie_value = cookie[:value]
  puts "admin console page #{name}: #@admin_console_page_cookie_value"
end

Then /^Two cookies value should be different$/ do
  @admin_console_page_cookie_value.should_not == @login_cookie_value
end

Then /^Admin console page cookies (.+) value should not changed/ do |name|
  cookie = @bus_site.admin_console_page.cookies.select{ |cookie| cookie[:name] == name }.first
  puts "admin console page #{name}: #{cookie[:value]}"
  @admin_console_page_cookie_value.should == cookie[:value]
end

Then /^the new partner admin should be logged in$/ do
  @bus_site.login_page.logged_in.should be_true
end

Then /^Alert message should be (.+)$/ do |message|
  @bus_site.admin_console_page.alert_text.should == message
end

When /^I close alert window$/ do
  @bus_site.admin_console_page.alert_dismiss
end

When /^I view the partner info$/ do
  @bus_site.admin_console_page.view_partner_info
end

# has_navigation returns a value if items are present, otherwise it will return empty
# in the case, am verifying that items are not present by checking for empty value
Then /^navigation items should be removed$/ do
  # this should apply regardless of the partner type
  @bus_site.admin_console_page.has_navigation?("Assign Keys").should be_false
  @bus_site.admin_console_page.has_navigation?("Transfer Resources").should be_false
  @bus_site.admin_console_page.has_navigation?("Return Unused Resources").should be_false
  @bus_site.admin_console_page.has_navigation?("Add New User Group").should be_false
  @bus_site.admin_console_page.has_navigation?("List User Groups").should be_false
end

# has_navigation returns a value if items are present, otherwise it will return empty
# in the case, am verifying that items are present by ensuring a value is present
Then /^new section & navigation items are present for (MozyPro|MozyEnterprise|Reseller|Itemized) partner$/ do |type|
  @bus_site.admin_console_page.has_content?('Quick Links').should be_true
  case type
    when CONFIGS['bus']['company_type']['mozypro']
      @bus_site.admin_console_page.has_navigation?("Resource Summary").should be_true
      @bus_site.admin_console_page.has_navigation?("Change Plan").should be_true
      @bus_site.admin_console_page.has_navigation?("Add New User").should be_true
      @bus_site.admin_console_page.has_navigation?(/^Download .* Client$/).should be_true
    when CONFIGS['bus']['company_type']['mozyenterprise']
      @bus_site.admin_console_page.has_navigation?("Resource Summary").should be_true
      @bus_site.admin_console_page.has_navigation?("User Group List").should be_true
      @bus_site.admin_console_page.has_navigation?("Add New User").should be_true
      @bus_site.admin_console_page.has_navigation?("Change Plan").should be_true
      @bus_site.admin_console_page.has_navigation?(/^Download .* Client$/).should be_true
    when CONFIGS['bus']['company_type']['reseller']
      @bus_site.admin_console_page.has_navigation?("Resource Summary").should be_true
      @bus_site.admin_console_page.has_navigation?("User Group List").should be_true
      @bus_site.admin_console_page.has_navigation?("Add New User").should be_true
      @bus_site.admin_console_page.has_navigation?("Change Plan").should be_true
      @bus_site.admin_console_page.has_navigation?(/^Download .* Client$/).should be_true
    when "Itemized"
      @bus_site.admin_console_page.has_navigation?("Resource Summary").should be_true
      @bus_site.admin_console_page.has_navigation?("User Group List").should be_true
      @bus_site.admin_console_page.has_navigation?("Add New User").should be_true
      @bus_site.admin_console_page.has_navigation?("Change Plan").should be_true
      @bus_site.admin_console_page.has_navigation?(/^Download .* Client$/).should be_true
    else
      raise "Error: Company type #{type} does not exist."
  end
end

Then /^I verify the new links for (MozyPro|MozyEnterprise|Reseller) partner$/ do |type|
  case type
    when CONFIGS['bus']['company_type']['mozypro']
      @bus_site.admin_console_page.navigate_to_menu((CONFIGS['bus']['menu']['resource_summary']), true)
      @bus_site.admin_console_page.navigate_to_menu((CONFIGS['bus']['menu']['add_new_user']), true)
      @bus_site.admin_console_page.navigate_to_menu((CONFIGS['bus']['menu']['download_client']), true)
      @bus_site.admin_console_page.navigate_to_menu((CONFIGS['bus']['menu']['change_plan']), true)
    when CONFIGS['bus']['company_type']['mozyenterprise']
      @bus_site.admin_console_page.navigate_to_menu((CONFIGS['bus']['menu']['resource_summary']), true)
      @bus_site.admin_console_page.navigate_to_menu((CONFIGS['bus']['menu']['user_group_list']), true)
      @bus_site.admin_console_page.navigate_to_menu((CONFIGS['bus']['menu']['add_new_user']), true)
      @bus_site.admin_console_page.navigate_to_menu((CONFIGS['bus']['menu']['download_client']), true)
      @bus_site.admin_console_page.navigate_to_menu((CONFIGS['bus']['menu']['change_plan']), true)
    when CONFIGS['bus']['company_type']['reseller']
      @bus_site.admin_console_page.navigate_to_menu((CONFIGS['bus']['menu']['resource_summary']), true)
      @bus_site.admin_console_page.navigate_to_menu((CONFIGS['bus']['menu']['user_group_list']), true)
      @bus_site.admin_console_page.navigate_to_menu((CONFIGS['bus']['menu']['add_new_user']), true)
      @bus_site.admin_console_page.navigate_to_menu((CONFIGS['bus']['menu']['download_client']), true)
      @bus_site.admin_console_page.navigate_to_menu((CONFIGS['bus']['menu']['change_plan']), true)
    else
      raise "Error: Company type #{type} does not exist."
  end
end

When /^I will( not)* see the (.+) link from navigation links$/ do |t, link|
  if t.nil?
    @bus_site.admin_console_page.has_navigation?(link).should be_true
  else
    @bus_site.admin_console_page.has_navigation?(link).should be_false
  end
end

Given /^I verify Skeletor by visiting url$/ do
  @bus_site.admin_console_page.visit_skeletor_url
end
