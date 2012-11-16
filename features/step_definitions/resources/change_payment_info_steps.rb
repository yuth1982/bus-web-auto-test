Then /^Change payment information message should be (.+)$/ do |message|
  @bus_site.admin_console_page.change_payment_info_section.messages.should match(message)
end

When /^I update payment contact information to:$/ do |contact_info|
  attributes = contact_info.hashes.first
  new_contact = Bus::DataObj::CompanyInfo.new
  new_contact.name = attributes['name']
  new_contact.address = attributes['address']
  new_contact.city = attributes['city']
  new_contact.state = attributes['state']
  new_contact.state_abbrev = attributes['state abbrev']
  new_contact.country = attributes["country"]
  new_contact.zip = attributes['zip']
  new_contact.phone = attributes['phone']

  @bus_site.admin_console_page.change_payment_info_section.update_payment_contact_info(new_contact, attributes['email'])
end

When /^I update credit card information to:$/ do |credit_card_info|
  attributes = credit_card_info.hashes.first
  new_cc_info = Bus::DataObj::CreditCard.new
  new_cc_info.full_name = attributes["cc name"]
  new_cc_info.number = attributes["cc number"]
  new_cc_info.expire_month = attributes["expire month"]
  new_cc_info.expire_year = attributes["expire year"]
  new_cc_info.cvv = attributes["cvv"]

  @bus_site.admin_console_page.change_payment_info_section.update_credit_card_info(new_cc_info)
end

When /^I save payment information changes$/ do
  @bus_site.admin_console_page.change_payment_info_section.submit_contact_cc_changes
end

Then /^Payment information should be updated$/ do
  @bus_site.admin_console_page.change_payment_info_section.messages.should include("Your billing information has been successfully updated.")
end

Then /^Payment billing information should be:$/ do |billing_contact_table|
  actual = @bus_site.admin_console_page.change_payment_info_section.billing_information_hash
  expected = billing_contact_table.hashes.first
  expected.keys.each do |header|
    case header
      when 'Billing Email'
        actual[header].should == expected[header].gsub(/@new_admin_email/,@partner.admin_info.email)
      else
        actual[header].should == expected[header]
    end
  end

end