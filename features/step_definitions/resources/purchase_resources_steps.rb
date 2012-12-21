
When /^I purchase resources:$/ do |resources_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['purchase_resources'])
  attributes = resources_table.hashes.first
  user_group = attributes["user group"]
  d_license = attributes["desktop license"]
  d_quota = attributes["desktop quota"]
  s_license = attributes["server license"]
  s_quota = attributes["server quota"]
  @bus_site.admin_console_page.purchase_resources_section.purchase(user_group, d_license, d_quota, s_license, s_quota)
end

Then /^Resources should be purchased$/ do
  @bus_site.admin_console_page.purchase_resources_section.messages.should == "Resources have been added to your account."
end