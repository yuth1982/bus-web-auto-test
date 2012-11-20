#
# Available columns:
# | ID:     | External ID: | Billing code: | Status:        | Available Keys: | Available Quota: | Default quota for new installs:           | Default user group: |
# | 1234567 | (change)     | (change)      | Active(change) | 0               | 0 GB             | 2 GB (Desktop) and 2 GB (Server) (change) |
#
Then /^User group details should be:$/ do |details_table|
  actual = @bus_site.admin_console_page.user_group_details_section.group_details_hash
  expected = details_table.hashes.first
  expected.keys.each do |header|
    case header
      when 'ID:'
        if expected[header].start_with?('@')
          actual[header].length.should == expected[header].length - 1
          actual[header].match(/\d{6}/).nil?.should be_false
        else
          actual[header].should == expected[header]
        end
      else
        actual[header].should == expected[header]
    end
  end
end

Then /^I should not see (.+) text on user group details section$/ do |text|
  @bus_site.admin_console_page.user_group_details_section.has_change_name_link?
  @bus_site.admin_console_page.user_group_details_section.has_no_content?(text).should be_true
end

When /^I enable stash for the user group with (default|\d+ GB) stash storage$/ do |quota|
  if quota == 'default'
    @bus_site.admin_console_page.user_group_details_section.enable_stash
  else
    @bus_site.admin_console_page.user_group_details_section.enable_stash(quota)
  end
end

When /^I disable stash for the user group$/ do
  @bus_site.admin_console_page.user_group_details_section.disable_stash
end

When /^I cancel disable stash for the user group$/ do
  @bus_site.admin_console_page.user_group_details_section.disable_stash(false)
end
