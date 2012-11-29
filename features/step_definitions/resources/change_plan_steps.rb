# MozyPro available columns:
# Optional: base plan, server plan, coupon
#
# MozyEnterprise available columns:
# Optional: users, server plan, server add-on, coupon
#
# Reseller available columns:
# Optional: reseller quota, server plan, server add-on, coupon
#
When /^I change (MozyPro|MozyEnterprise|Reseller) account plan to:$/ do |type, plan_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['change_plan'])
  attributes = plan_table.hashes.first
  coupon = attributes["coupon"] || ""
  case type
    when "MozyPro"
      base_plan = attributes["base plan"] || ""
      server_plan = attributes["server plan"] || ""
      storage_add_on = attributes["storage add-on"] || 0
      @bus_site.admin_console_page.change_plan_section.change_mozypro_plan(base_plan, server_plan, coupon, storage_add_on)
    when "MozyEnterprise"
      users = attributes["users"] || 0
      server_plan = attributes["server plan"] || "None"
      server_add_on = attributes["server add-on"] || 0
      @bus_site.admin_console_page.change_plan_section.change_mozyenterprise_plan(users, server_plan, server_add_on, coupon)
    when "Reseller"
      quota = attributes["reseller quota"] || 0
      server_plan = attributes["server plan"] || ""
      server_add_on = attributes["server add-on"] || 0
      @bus_site.admin_console_page.change_plan_section.change_reseller_plan(quota, server_plan, server_add_on, coupon)
    else
  end
end

# Success message depends on Manage Resources vs. Assigned Keys
# which is determined by the company type of the account
Then /^the (MozyPro|MozyEnterprise|Reseller) account plan should be changed$/ do |type|
  case type
    when "MozyPro"
      @bus_site.admin_console_page.change_plan_section.messages.should == "Successfully changed plan. Visit Manage Resources to distribute your new resources."
    when "MozyEnterprise"
      @bus_site.admin_console_page.change_plan_section.messages.should == "Successfully changed plan."
    when "Reseller"
      @bus_site.admin_console_page.change_plan_section.messages.should == "Successfully changed plan. Visit Manage Resources to distribute your new resources."
  end
end

Then /^Change plan charge summary should be:$/ do |charge_table|
  @bus_site.admin_console_page.change_plan_section.charge_summary_table_headers.should == charge_table.headers
  @bus_site.admin_console_page.change_plan_section.charge_summary_table_rows.should == charge_table.rows
end

Then /^MozyPro available base plans should be:$/ do |plans_table|
  @bus_site.admin_console_page.change_plan_section.mozypro_available_base_plans.should == plans_table.rows.flatten
end

#
#  | base plan | server plan | storage add on |

Then /^MozyPro new plan should be:$/ do |new_plan_table|
  attributes = new_plan_table.hashes.first
  base_plan = attributes["base plan"] || ""
  server_plan = attributes["server plan"] || ""
  add_on = attributes["storage add-on"] || ""

  @bus_site.admin_console_page.change_plan_section.mozypro_base_plan.should include base_plan unless base_plan.empty?
  @bus_site.admin_console_page.change_plan_section.mozypro_server_plan_status.should == server_plan unless server_plan.empty?
  @bus_site.admin_console_page.change_plan_section.mozypro_storage_add_on.should == add_on unless add_on.empty?

end

Then /^MozyEnterprise new plan should be:$/ do |new_plan_table|
  attributes = new_plan_table.hashes.first
  users = attributes["users"] || ""
  server_plan = attributes["server plan"] || ""
  add_on = attributes["server add-on"] || ""

  @bus_site.admin_console_page.change_plan_section.mozyenterprise_users.should == users unless users.empty?
  @bus_site.admin_console_page.change_plan_section.mozyenterprise_server_plan.should include server_plan unless server_plan
  @bus_site.admin_console_page.change_plan_section.mozyenterprise_server_add_on.should == add_on unless add_on.empty?
end

Then /^Change Plan section should be active$/ do
  @bus_site.admin_console_page.change_plan_section.has_current_plan_table?.should be_true
end
