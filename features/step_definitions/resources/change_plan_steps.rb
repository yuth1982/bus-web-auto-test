# MozyPro available columns:
# Optional: base plan, server plan, storage add-on, coupon
#
# MozyEnterprise available columns:
# Optional: users, server plan, storage add-on, coupon
#
# Reseller available columns:
# Optional: server plan, storage add-on
#
When /^I change (MozyPro|MozyEnterprise|Reseller) account plan to:$/ do |type, plan_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['change_plan'])
  attributes = plan_table.hashes.first
  base_plan = attributes["base plan"] # MozyPro
  users = attributes["users"] # MozyEnterprise
  server_plan = attributes["server plan"]
  storage_add_on = attributes["storage add-on"]
  coupon = attributes["coupon"]
  case type
    when "MozyPro"
      @bus_site.admin_console_page.change_plan_section.change_mozypro_plan(base_plan, server_plan, storage_add_on, coupon)
    when "MozyEnterprise"
      @bus_site.admin_console_page.change_plan_section.change_mozyenterprise_plan(users, server_plan, storage_add_on, coupon)
    when "Reseller"
      @bus_site.admin_console_page.change_plan_section.change_reseller_plan(server_plan, storage_add_on)
    else
      raise "#{type} Company type not exist"
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
    else
      raise "#{type} Company type not exist"
  end
end

Then /^(MozyPro|MozyEnterprise|Reseller) new plan should be:$/ do |type, new_plan_table|
  attributes = new_plan_table.hashes.first
  base_plan = attributes["base plan"]
  users = attributes["users"]
  server_plan = attributes["server plan"]
  add_on = attributes["storage add-on"]

  case type
    when 'MozyPro'
      @bus_site.admin_console_page.change_plan_section.mozypro_base_plan.should include base_plan unless base_plan.nil?
      @bus_site.admin_console_page.change_plan_section.server_plan_status.should == server_plan.capitalize unless server_plan.nil?
      @bus_site.admin_console_page.change_plan_section.storage_add_on.should == add_on unless add_on.nil?

    when 'MozyEnterprise'
      @bus_site.admin_console_page.change_plan_section.mozyenterprise_users.should == users unless users.nil?
      @bus_site.admin_console_page.change_plan_section.mozyenterprise_server_plan.should include server_plan unless server_plan.nil?
      @bus_site.admin_console_page.change_plan_section.storage_add_on.should == add_on unless add_on.nil?
    when 'Reseller'
      @bus_site.admin_console_page.change_plan_section.server_plan_status.should == server_plan.capitalize unless server_plan.nil?
      @bus_site.admin_console_page.change_plan_section.storage_add_on.should == add_on unless add_on.nil?
    else
      raise "#{type} Company type not exist"
  end
end

Then /^Change plan charge summary should be:$/ do |charge_table|
  @bus_site.admin_console_page.change_plan_section.charge_summary_table_headers.should == charge_table.headers
  @bus_site.admin_console_page.change_plan_section.charge_summary_table_rows.should == charge_table.rows
end

Then /^MozyPro available base plans should be:$/ do |plans_table|
  @bus_site.admin_console_page.change_plan_section.mozypro_available_base_plans.should == plans_table.rows.flatten
end

Then /^Change Plan section should be visible$/ do
  @bus_site.admin_console_page.change_plan_section.section_visible?.should be_true
end

When /^I refresh Change Plan section$/ do
  @bus_site.admin_console_page.change_plan_section.refresh_bus_section
end
