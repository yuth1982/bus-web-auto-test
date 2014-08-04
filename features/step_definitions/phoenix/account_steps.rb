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

When /^I navigate to Change Credit Card section in Phoenix$/ do
  @phoenix_site.account_page.navigate_to_change_credit_card
end

When /^I change credit card info to:$/ do |contact_table|
  # table is a | Name: | Street Address: | City: | State/Province: | Zip/Postal Code: | Country: |
  company_info = contact_table.hashes.first
  company_info.keys.each do |header|
    case header
      when 'Name:'
        @partner.company_info.name = company_info['Name:']
      when 'Street Address:'
        @partner.company_info.address = company_info['Street Address:']
      when 'City:'
        @partner.company_info.city = company_info['City:']
      when 'State/Province:'
        @partner.company_info.state = company_info['State/Province:']
      when 'Zip/Postal Code:'
        @partner.company_info.zip = company_info['Zip/Postal Code:']
      when 'Country:'
        @partner.company_info.country = company_info['Country:']
      else
        raise "Unexpected #{header}"
    end
  end
  # for info review
  # puts @partner.to_s
  puts @partner
  @phoenix_site.billing_fill_out.home_fill_out(@partner)
  @phoenix_site.account_page.confirm
end

Then /^The credit card is updated/ do
  @phoenix_site.account_page.credit_card_updated.start_with?(' Your card has been successfully filed.').should be_true
end
