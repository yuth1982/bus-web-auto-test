
And /^I select event history$/ do
  @freyja_site.options_menu_page.open_event_history
end

And /^I click Change password$/ do
  @restore = Freyja::DataObj::Restore.new
  section_id = "//li[@id='panel-action-change-password']"
  @freyja_site.options_menu_page.change_password_wizard(section_id)
end

And /^I logout$/ do
  @freyja_site.options_menu_page.logout
end

