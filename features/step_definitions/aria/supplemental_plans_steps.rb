Then /^Supplemental plans should be:$/ do |supp_plans|

end

When /^I change (.+) plan units to (\d+)$/ do |target_plan, new_units|
  @aria_site.admin_tools_page.switch_to_inner_work_frame
  @aria_site.accounts_page.account_overview_section.navigate_to_link('Supplemental Plans')
  @aria_site.accounts_page.supplemental_plans_section.view_plan_units_details(target_plan)
  @aria_site.accounts_page.change_plan_units_section.change_plan_units(new_units)
  @aria_site.accounts_page.save_plan_units_section.save_plan_units
end

Then /^Supplemental plan units should be changed$/ do
  @aria_site.admin_tools_page.switch_to_inner_work_frame
  @aria_site.accounts_page.supplemental_plans_section.messages.should include('Plan Change Saved. This change will take effect immediately.')
end