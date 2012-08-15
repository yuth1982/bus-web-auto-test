
Transform /^administrator$/ do |step_arg|
  Hash[:user_name => ENV["bus_user"] || "shipuy@mozy.com", :password => ENV["bus_pwd"] || "test1234" ]
end

Transform /^aria admin$/ do |step_arg|
  Hash[:user_name => ENV["aria_user"] || "shipu", :password => ENV["aria_pwd"] || "shipu1234"]
end

Transform /^default zimbra account$/ do |step_arg|
  Hash[:user_name => ENV["zimbra_user"] || "qa1@mozy.com", :password => ENV["zimbra_pwd"] || "QAwelcome"]
end

Transform /^mozypro test account$/ do |step_arg|
  Hash[:user_name => "qa1+frank+moreno+2012@mozy.com", :password => Bus::DEFAULT_PWD, :company_name => "Fliptune Major Airlines Company"]
end

Transform /^mozyenterprise test account$/ do |step_arg|
  Hash[:user_name => "qa1+ruth+phillips+1107@mozy.com", :password => Bus::DEFAULT_PWD, :company_name => "Tagchat Closed-End Fund - Equity Company"]
end

Transform /^the new partner email$/ do |step_arg|
  @partner.admin_info.email
end

Transform /^the new partner company name$/ do |step_arg|
  @partner.company_info.name
end

Transform /^the new partner account$/ do |step_arg|
  Hash[:user_name => @partner.admin_info.email, :password => Bus::DEFAULT_PWD, :company_name => @partner.company_info.name]
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

When /^I wait for (\d+) seconds$/ do |seconds|
  sleep seconds.to_i
end
