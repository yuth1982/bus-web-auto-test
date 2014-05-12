When /^I navigate to (.+) section from freyja page$/ do |section_name|
  @freyja_site.freyja_page.navigate_to_menu(section_name)
end

And /^I view Actions pane from backup$/ do
  @freyja_site.freyja_page.click_backup_view_actions_pane
end

And /^I view Actions pane from synced/ do
  @freyja_site.freyja_page.click_sync_view_actions_pane
end

When /^I go to Devices$/ do
  @freyja_site.freyja_page.click_devices_tab
end

And /^I choose one device$/ do
  @freyja_site.freyja_page.choose_one_device
end

When /^I go to Synced/ do
  @freyja_site.freyja_page.click_synced_tab
end
