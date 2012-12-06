When /^I navigate to (.+) section from bus admin console page$/ do |link_name|
  @bus_site.admin_console_page.navigate_to_menu(link_name)
end

When /^I close Mozy Stash invitation popup window$/ do
  @bus_site.admin_console_page.close_stash_invitation_popup
end

When /^I stop masquerading$/ do
  @bus_site.admin_console_page.stop_masquerading
end

Then /^I should not see (.+) link$/ do |link|
  @bus_site.admin_console_page.has_no_link?(link).should be_true
end

Then /^Popup window message should be (.+)$/ do |message|
  @bus_site.admin_console_page.popup_window_content.gsub("\n"," ").should == message
end

Then /^I click Close button on popup window$/ do
  @bus_site.admin_console_page.close_popup_window
end

Then /^I click Continue button on popup window$/ do
  @bus_site.admin_console_page.click_continue
end

Then /^I click Cancel button on popup window$/ do
  @bus_site.admin_console_page.click_continue
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