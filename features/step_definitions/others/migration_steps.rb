Given /^I migrate (the|multiple) partner to aria$/ do |partners_to_migrate|
  case partners_to_migrate
    when 'the'
      Utility.migrate_partners(@partner_id)
    when "multiple"
      Utility.migrate_partners(@partner_id,'123458')
    else
  end
end