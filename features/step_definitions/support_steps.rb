
Transform /^newly created partner admin email$/ do |step_arg|
  @partner.admin_info.email
end

Transform /^newly created MozyHome username$/ do |step_arg|
  @partner.admin_info.email
end

Transform /^newly created partner company name$/ do |step_arg|
  @partner.company_info.name
end

Transform /^newly created (Bundled|Itemized) user group name$/ do |type|
  case type
    when 'Bundled'
      @new_bundled_ug.name
    when 'Itemized'
      @new_itemized_ug.name
    else
     #Skipped
  end
end

Transform /^newly created user email$/ do |step_arg|
  @new_users.first.email
end

Transform /^newly created partner aria id$/ do |step_arg|
  @aria_id
end

Transform /^newly created partner external id$/ do |step_arg|
  @new_p_external_id
end

When /^I wait for (\d+) seconds$/ do |seconds|
  sleep seconds.to_i
end

Transform /^newly created config name$/ do |step_arg|
  @client_config.name
end

Transform /^default password$/ do |step_arg|
  CONFIGS['global']['test_pwd']
end

Transform /^existing admin email$/ do |step_arg|
  @existing_admin_email
end

Transform /^existing user email$/ do |step_arg|
  @existing_user_email
end

Transform /^automation admin email$/ do |step_arg|
  BUS_ENV['bus_username']
end

Transform /^the newly created machine$/ do |step_arg|
  @machine_id
end