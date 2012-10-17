
Transform /^administrator$/ do |step_arg|
  Hash[:user_name => ENV["BUS_USER"] || "shipuy@mozy.com", :password => ENV["BUS_PWD"] || "test1234" ]
end

Transform /^aria admin$/ do |step_arg|
  Hash[:user_name => ENV["ARIA_USER"] || "shipu", :password => ENV["ARIA_PWD"] || "shipu1234"]
end

Transform /^mozypro test account$/ do |step_arg|
  Hash[:user_name => "qa1+frank+moreno+2012@mozy.com", :password => Bus::DEFAULT_PWD, :company_name => "Fliptune Major Airlines Company"]
end

Transform /^mozyenterprise test account$/ do |step_arg|
  #Hash[:user_name => "qa1+ruth+phillips+1107@mozy.com", :password => Bus::DEFAULT_PWD, :company_name => "Tagchat Closed-End Fund - Equity Company"]
  Hash[:user_name => "qa1+carlos+nelson+1414@mozy.com", :password => Bus::DEFAULT_PWD, :company_name => "Tagchat Closed-End Fund - Equity Company"]
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

Transform /^the new user group$/ do |step_arg|
  @user_group.name
  #"Bonnie"
end

Transform /^a test email$/ do |step_arg|
  "#{Bus::EMAIL_PREFIX}+Test+#{Time.now.strftime("%H%M")}@mozy.com".downcase
end
When /^I wait for (\d+) seconds$/ do |seconds|
  sleep seconds.to_i
end
