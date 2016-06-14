Then /^default adr policy should be:$/ do |table|
  adr_policy = table.hashes.first

  @bus_site.admin_console_page.data_retention_section.get_adr_policy
  adr_policy['partner adr'].should == expected_lock_value unless adr_policy['partner'].nil?
  adr_policy['default user group adr'].should == expected_lock_value unless adr_policy['default user group adr'].nil?
  adr_policy['sub partner adr'].should == expected_lock_value unless adr_policy['sub partner adr'].nil?
end

Then /^partner adr policy should be (.+)/ do |policy|
  @bus_site.admin_console_page.data_retention_section.get_partner_adr_policy.should == policy
end

Then /^user group adr policy should be:$/ do |policy|
  attributes = policy.hashes.first
  attributes.each do |k,v|
    v.replace ERB.new(v).result(binding)
  end
  actual = @bus_site.admin_console_page.data_retention_section.user_group_adr_policy_table_hashes
  expected = policy.rows
  actual.should == expected
end

Then /^sub partner adr policy should be:$/ do |policy|
  attributes = policy.hashes.first
  attributes.each do |k,v|
    v.replace ERB.new(v).result(binding)
  end
  actual = @bus_site.admin_console_page.data_retention_section.sub_partner_adr_policy_table_hashes
  expected = policy.rows
  actual.should == expected
end

Then /^I should see (.+) in sub partner adr policy list$/ do |message|
  @bus_site.admin_console_page.data_retention_section.sub_partner_adr_policy_table_text.should include(message)
end

When /^I click partner adr policy$/ do
  @bus_site.admin_console_page.data_retention_section.click_partner_adr_policy
end

When /^I set adr policy to (.+)$/ do |policy|
  @bus_site.admin_console_page.data_retention_section.create_adr_policy(policy, QA_ENV['bus_password'])
end

Then /^Change ADR Policy section message should be (.+)/ do |message|
  @bus_site.admin_console_page.data_retention_section.messages.should == message
end

Then /^ADR policy in DB for partner is (.+)$/ do |adr_policy_name|
  partner_adr = DBHelper.get_partner_adr_policy_name(@partner_id)
  partner_adr.should == adr_policy_name
end

Then /^ADR policy in DB for user groups are (.+)$/ do |adr_policy_name|
  user_groups_adr = DBHelper.get_user_groups_adr_policy_name(@partner_id)
  puts user_groups_adr
  user_groups_adr.each do |adr|
    adr.should == adr_policy_name
  end
end


