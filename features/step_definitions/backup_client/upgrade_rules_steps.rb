When /^I add a new upgrade rule:$/ do |table|
  upgrade_rule = table.hashes.first
  upgrade_rule.each do |_,v|
    v.replace ERB.new(v).result(binding)
  end
  @bus_site.admin_console_page.upgrade_rules_section.ur_iframe.add_new_rule(upgrade_rule)
  # When save rules got a 500 error, refresh section will have to click the 'Resend' popup window in firefox
  begin
    @bus_site.admin_console_page.upgrade_rules_section.refresh_bus_section
  rescue Exception => e
    Log.debug e.message
  end
end

And /^I delete rule for version (.+) if it exists$/ do |version_name|
  version_name.gsub!(/@version_name/,@version_name)
  has_rule, rules = @bus_site.admin_console_page.upgrade_rules_section.ur_iframe.rule_exists?(version_name)
  @bus_site.admin_console_page.upgrade_rules_section.ur_iframe.delete_rule(version_name, rules) if has_rule
end

Then /^there is( no)? version (.+) in Upgrade Version list$/ do |has_version, version|
  if has_version == ' no'
    @bus_site.admin_console_page.upgrade_rules_section.ur_iframe.upgrade_version_contain?(version).should be_false
  else
    @bus_site.admin_console_page.upgrade_rules_section.ur_iframe.upgrade_version_contain?(version).should be_true
  end
  @bus_site.admin_console_page.upgrade_rules_section.refresh_bus_section
end

Then /^there is( no)? rule for (.+) in Upgrade Rules$/ do |has_rule, version|
  rule_existed, rules = @bus_site.admin_console_page.upgrade_rules_section.ur_iframe.rule_exists?(version)
  if has_rule == ' no'
    rule_existed.should be_false
  else
    rule_existed.should be_true
  end
end

And /^Upgrade Rule for version (.+) should be:$/ do |version, table|
  actual = @bus_site.admin_console_page.upgrade_rules_section.ur_iframe.get_rule(version)
  expected = table.hashes.first
  Log.debug actual
  expected.keys.each{ |key| actual[key].should == expected[key] }
end

When /^I update Upgrade Rule for version (.+) as below:$/ do |version, table|
  rule = table.hashes.first
  @bus_site.admin_console_page.upgrade_rules_section.ur_iframe.edit_rule(version, rule)
  @bus_site.admin_console_page.upgrade_rules_section.refresh_bus_section
end

And /^I refresh Upgrade Rules section$/ do
  @bus_site.admin_console_page.upgrade_rules_section.refresh_bus_section
end