
Then /^I edit (.+) passowrd policy:$/ do |account_type,policy_table|
  attributes = policy_table.hashes.first

  attributes.each do |header,attribute| #can use variable inside <%= %>
    attribute.replace ERB.new(attribute).result(binding)
  end
  @password_policy = Bus::DataObj::PasswordPolicy.new
  case account_type
    when 'user'
      @password_policy.user_policy_type = attributes["user policy type"] unless attributes["user policy type"].nil?
      @password_policy.user_min_character_classes = attributes["min character classes"] unless attributes["min character classes"].nil?
      @password_policy.user_character_classes = attributes["character classes"].split(',') unless attributes["character classes"].nil?
      @bus_site.admin_console_page.edit_password_policy_section.edit_user_password_policy(@password_policy)
    when 'admin'
      @password_policy.admin_user_same_policy = attributes["admin user same policy"] unless attributes["admin user same policy"].nil?
      @password_policy.admin_policy_type = attributes["admin policy type"] unless attributes["admin policy type"].nil?
      @password_policy.admin_min_character_classes = attributes["min character classes"] unless attributes["min character classes"].nil?
      @password_policy.admin_character_classes = attributes["character classes"].split(',') unless attributes["character classes"].nil?
      @bus_site.admin_console_page.edit_password_policy_section.edit_admin_password_policy(@password_policy)
  end
end

Then /^I save password policy$/ do
  @bus_site.admin_console_page.edit_password_policy_section.save_policy
  @bus_site.admin_console_page.edit_password_policy_section.wait_until_bus_section_load
end

Then /^Password policy updated successfully$/ do
  @bus_site.admin_console_page.edit_password_policy_section.message == 'Password policy updated successfully'
end

#if going to clear Max age , using 'I update Max age to unlimited days'
Then /^I update Max age to (.+) days$/ do |days|
  @bus_site.admin_console_page.edit_password_policy_section.update_max_age(days)
  @bus_site.admin_console_page.edit_password_policy_section.save_policy
  @bus_site.admin_console_page.edit_password_policy_section.wait_until_bus_section_load
end
