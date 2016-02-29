When /^I list versions for:$/ do |table|
  list_version_condition = table.hashes.first
  @bus_site.admin_console_page.list_versions_section.list_version(list_version_condition)
end

Then /^I can find the version info in versions list:$/ do |table|
  actual = @bus_site.admin_console_page.list_versions_section.version_list_table_hash
  expected = table.hashes
  expected.each{ |key| (actual.include?(key)).should be_true}
end

When /^I view version details for (.+)$/ do |version_number|
  @bus_site.admin_console_page.list_versions_section.view_version(version_number)
end

And /^I delete version (.+) if it exists$/ do |version_number|
  if @bus_site.admin_console_page.list_versions_section.version_listed?(version_number)
    @bus_site.admin_console_page.list_versions_section.view_version(version_number)
    @bus_site.admin_console_page.version_show_section.delete_version
    100.times do
      @bus_site.admin_console_page.list_versions_section.refresh_bus_section
      break unless @bus_site.admin_console_page.list_versions_section.version_listed?(version_number)
      sleep(5)
    end
  end
end

Then /^I should not see version (.+) in version list$/ do |version_number|
  @bus_site.admin_console_page.list_versions_section.version_listed?(version_number).should be_false
end

And /^I get (1|2) enabled (win-sync|linux) version$/ do |number, _|
  version_info = @bus_site.admin_console_page.list_versions_section.version_list_table_hash
  @version_name = version_info[0]['Name']
  @version = version_info[0]['Version']
  if number == '2'
    @version_name2 = version_info[1]['Name']
    @version2 = version_info[1]['Version']
  end
end