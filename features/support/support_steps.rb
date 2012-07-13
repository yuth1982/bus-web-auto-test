
# login steps support

Transform /^administrator$/ do |step_arg|
  Bus::Admin.new "shipuy@mozy.com","Shipu Yao","test1234"
end

Transform /^aria admin$/ do |step_arg|
  Aria::Admin.new "shipu","1234test"
end

Transform /^mozypro test account$/ do |step_arg|
  Bus::Admin.new "qa1+robin+perkins@mozy.com","Shawn Cole",Bus::DEFAULT_PWD
end

Transform /^mozyenterprise test account$/ do |step_arg|
  Bus::Admin.new "qa1+teresa+spencer@mozy.com","Teresa Spencer",Bus::DEFAULT_PWD
end

Transform /^the new partner email$/ do |step_arg|
  @partner.email
end

Transform /^the new partner account$/ do |step_arg|
  Bus::Admin.new @partner.email,@partner.name,Bus::DEFAULT_PWD
end

Transform /^MozyPro monthly billing period$/ do |step_arg|
  "Switch to monthly billing"
end

Transform /^MozyPro annual billing period$/ do |step_arg|
  "Switch to annual billing (includes 1 free month!)"
end

Transform /^MozyPro biennial billing period$/ do |step_arg|
  "Switch to biennial billing (includes 3 free months!)"
end

Transform /^MozyEnterprise annual billing period$/ do |step_arg|
  "Switch to annual billing"
end

Transform /^MozyEnterprise biennial billing period$/ do |step_arg|
  "Switch to biennial billing"
end

Transform /^MozyEnterprise 3-year billing period/ do |step_arg|
  "Switch to 3-year billing"
end

Transform /^Reseller monthly billing period$/ do |step_arg|
  "Switch to monthly billing"
end

Transform /^Reseller annual billing period$/ do |step_arg|
  "Switch to annual billing (includes 1 free month!)"
end
