When /^I navigate to (.+) section from freyja page$/ do |section_name|
  @freyja_site.freyja_page.navigate_to_menu(section_name)
end

And /^I view Actions pane$/ do
  @freyja_site.freyja_page.click_view_actions_pane
end
