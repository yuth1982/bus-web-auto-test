When /^I navigate to (.+) section from freyja page$/ do |section_name|
  @freyja_site.freyja_page.navigate_to_menu(section_name)
end
