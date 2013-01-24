
Transform /^newly created partner admin email$/ do |step_arg|
  @partner.admin_info.email
end

Transform /^newly created partner company name$/ do |step_arg|
  @partner.company_info.name
end

Transform /^newly created user group name$/ do |step_arg|
  @user_group.name
end

Transform /^newly created user email$/ do |step_arg|
  @user.email
end

When /^I wait for (\d+) seconds$/ do |seconds|
  sleep seconds.to_i
end
