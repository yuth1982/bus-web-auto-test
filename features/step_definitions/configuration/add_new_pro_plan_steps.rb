When /^I add a new pro plan:$/ do |table|
  pro_plan = table.hashes.first
  pro_plan = Bus::DataObj::ProPlan.new(pro_plan['Business Type'], pro_plan['Name'])
  @bus_site.admin_console_page.add_new_pro_plan_section.add_new_pro_plan(pro_plan)
end

When /^add new pro plan success message should be displayed$/ do
  @bus_site.admin_console_page.add_new_pro_plan_section.anpp_messages.should match(/Pro plan was successfully created./)
end
