
When /^I purchase resources (\d+) server licence, (\d+)G server quota, (\d+) desktop licence, (\d+)G desktop quota$/ do |server_lic_num, server_quota, desktop_lic_num, desktop_quota|
  @bus_admin_console_page.purchase_resources_view.purchase server_lic_num,server_quota,desktop_lic_num,desktop_quota
end

When /^I view price details of my purchased resource (\d+) server licence, (\d+)G server quota, (\d+) desktop licence, (\d+)G desktop quota$/ do |server_lic_num, server_quota, desktop_lic_num, desktop_quota|
  @bus_admin_console_page.purchase_resources_view.edit_amounts server_lic_num,server_quota,desktop_lic_num,desktop_quota
end

Then /^I should see tax total price is (.+)$/ do |price|
  @bus_admin_console_page.purchase_resources_view.tax_price.should == price
end
