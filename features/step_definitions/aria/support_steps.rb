# login steps support

Transform /^aria admin$/ do |step_arg|
  Aria::Admin.new "shipu","1234test"
end

# create account steps support

Transform /^MozyPro 3-Years EN plan$/ do |step_arg|
  @aria_account = Aria::Account.new
  # master_plan, supp_plan_desk_lic, supp_plan_server_lic, supp_plan_desk_quota, supp_plan_server_quota
  @aria_account.plan_mapping = Aria::PlanMapping.new "10293195","10293261","10293263","10293265","10293267"
  @aria_account
end

Transform /^MozyPro Yearly EN plan$/ do |step_arg|
  @aria_account = Aria::Account.new
  # master_plan, supp_plan_desk_lic, supp_plan_server_lic, supp_plan_desk_quota, supp_plan_server_quota
  @aria_account.plan_mapping = Aria::PlanMapping.new "10293191","10293237","10293239","10293243","10293245"
  @aria_account
end


