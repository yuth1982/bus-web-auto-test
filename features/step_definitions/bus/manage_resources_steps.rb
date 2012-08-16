When /^I assign MozyPro allocated quota to (\d+) GB$/ do |new_quota|
  step "I navigate to Manage Resources section from bus admin console page"
  @bus_admin_console_page.manage_resources_section.assign_mozypro_storage(new_quota)
end

Then /^MozyPro resource quota should be changed$/ do
  @bus_admin_console_page.manage_resources_section.message_text.should == "Quota changed."
end