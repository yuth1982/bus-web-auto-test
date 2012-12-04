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
  @bus_site.admin_console_page.popup_window_content.should == message
end

Then /^I click Close button on popup window$/ do
  @bus_site.admin_console_page.close_popup_window
end

Then /^I click Continue button on popup window$/ do
  @bus_site.admin_console_page.continue_add_stash
end

Then /^I click Buy More button on popup window$/ do
  @bus_site.admin_console_page.buy_more_resources
end

Then /^I click Allocate button on popup window$/ do
  @bus_site.admin_console_page.allocate_resources
end
