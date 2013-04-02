Then /^I will see the account page$/ do
  @phoenix_site.account_page.account_pages.should == 'Account Pages'
end
When /^I navigate to My Profile section in Phoenix$/ do
  @phoenix_site.account_page.navigate_to_my_file
end
When /^I change my profile to:$/ do |info_table|
  # table is a | Name: | Street Address: | City: | State/Province: | Zip/Postal Code: | Country |
  new_info = info_table.hashes.first
  new_info.keys.each do |header|
    case header
      when 'Name:'
        @phoenix_site.account_page.set_name(new_info[header])
      when 'Street Address:'
        @phoenix_site.account_page.set_address(new_info[header])
      when 'City:'
        @phoenix_site.account_page.set_city(new_info[header])
      when 'State/Province:'
        @phoenix_site.account_page.set_state(new_info[header])
      when 'Zip/Postal Code:'
        @phoenix_site.account_page.set_zip(new_info[header])
      when 'Country:'
        @phoenix_site.account_page.set_country(new_info[header])
      else
        raise "Unexpected #{header}"
    end
  end
  @phoenix_site.account_page.submit
end
Then /^The profile is saved$/ do
  @phoenix_site.account_page.profile_saved.should == 'Profile saved.'
end
When /^The profile should be:$/ do |table|
  # table is a | Name: | Street Address: | City: | State/Province: | Zip/Postal Code: | Country |
  actual = @phoenix_site.account_page.profile_hashes
  expected = table.hashes.first
  expected.keys.each do |header|
    actual[header].should == expected[header]
  end
end
When /^I close phoenix account page$/ do
  @phoenix_site.account_page.close_page
end
When /^I navigate to Upgrade section in Phoenix$/ do
  @phoenix_site.account_page.navigate_to_upgrade
end