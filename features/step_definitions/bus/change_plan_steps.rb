# MozyPro available column names:
# | base plan | server plan | coupon |
#
# MozyEnterprise available column names:
# | users | server plan | server add-on | coupon |
#
# Reseller available column names:
# | reseller quota | server plan | server add-on | coupon |

When /^I change (MozyPro|MozyEnterprise|Reseller) account plan to:$/ do |type, plan_table|
  step "I navigate to Change Plan section from bus admin console page"
  attributes = plan_table.hashes.first
  coupon = attributes["coupon"] || ""
  case type
    when "MozyPro"
      base_plan = attributes["base plan"] || ""
      server_plan = attributes["server plan"] || ""
      @bus_admin_console_page.change_plan_section.change_mozypro_plan(base_plan, server_plan, coupon)
    when "MozyEnterprise"
      users = attributes["users"] || 0
      server_plan = attributes["server plan"] || "None"
      server_add_on = attributes["server add-on"] || 0
      @bus_admin_console_page.change_plan_section.change_mozyenterprise_plan(users, server_plan, server_add_on, coupon)
    when "Reseller"
      quota = attributes["reseller quota"] || 0
      server_plan = attributes["server plan"] || ""
      server_add_on = attributes["server add-on"] || 0
      @bus_admin_console_page.change_plan_section.change_reseller_plan(quota, server_plan, server_add_on, coupon)
    else
  end
end

Then /^Account plan should be changed$/ do
  @bus_admin_console_page.change_plan_section.message_text.should == "Resources have been changed on your account."
end

Then /^Change plan charge summary should be:$/ do |charge_table|
  @bus_admin_console_page.change_plan_section.charge_summary_tb_headers_text.should == charge_table.headers
  @bus_admin_console_page.change_plan_section.charge_summary_tb_rows_text.should == charge_table.rows
end