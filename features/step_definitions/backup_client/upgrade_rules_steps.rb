When /^I add a new upgrade rule:$/ do |table|
  upgrade_rule = table.hashes.first
  @bus_site.admin_console_page.upgrade_rules_section.ur_iframe.add_new_rule(upgrade_rule)
  @bus_site.admin_console_page.upgrade_rules_section.refresh_bus_section
end


And /^I delete rule for version (.+) if it exists$/ do |version_name|
  has_rule, rules = @bus_site.admin_console_page.upgrade_rules_section.ur_iframe.rule_exists?(version_name)
  @bus_site.admin_console_page.upgrade_rules_section.ur_iframe.delete_rule(version_name, rules) if has_rule
  @bus_site.admin_console_page.upgrade_rules_section.refresh_bus_section
end