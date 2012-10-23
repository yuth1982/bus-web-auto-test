
Transform /^newly created partner admin email$/ do |step_arg|
  @partner.admin_info.email
end

Transform /^newly created partner company name$/ do |step_arg|
  @partner.company_info.name
end

#Transform /^the new partner account/ do |step_arg|
#  Hash[:user_name => @partner.admin_info.email, :password => Bus::DEFAULT_PWD, :company_name => @partner.company_info.name]
#end

Transform /^the new user group$/ do |step_arg|
  @user_group.name
  #"Bonnie"
end

#Transform /^a test email$/ do |step_arg|
#  "#{CONFIGS['global']['email_prefix']}+Test+#{Time.now.strftime("%H%M")}@mozy.com".downcase
#end

When /^I wait for (\d+) seconds$/ do |seconds|
  sleep seconds.to_i
end
