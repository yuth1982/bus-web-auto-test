When /^I search partners in (pending-delete not available to purge|pending-delete available to purge|who have been purged) by:$/ do |match,search_key_table|
  attributes = search_key_table.hashes.first
  keywords = (attributes['name'] || attributes['email'])
  keywords = keywords.gsub(/@company_name/,@partner.company_info.name).gsub(/@admin_email/,@partner.admin_info.email) unless @partner.nil?
  full_search = (attributes['full search'] || 'no').eql?('yes')
  @bus_site.admin_console_page.manage_pending_deletes_section.search_partners(match, keywords, full_search)
end

Then /^Partners in (pending-delete not available to purge|pending-delete available to purge|who have been purged) search results should be:$/ do |type, results_table|
  actual = @bus_site.admin_console_page.manage_pending_deletes_section.search_results_hashes(type)
  expected = results_table.hashes
  expected.each do |col|
    col.each do |k,v|
      case k
        when 'ID'
          v.gsub!(/@partner_id/, @partner_id) unless @partner_id.nil?
        when 'Aria ID'
          v.gsub!(/@aria_id/, @aria_id) unless @aria_id.nil?
        when 'Partner'
          v.gsub!(/@company_name/, @partner.company_info.name) unless @partner.nil?
        when 'Created'
          v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
        when 'Request Date'
          v.replace(Chronic.parse(v).strftime('%a %b %d %Y'))
        when 'Date Purged'
          v.replace(Chronic.parse(v).strftime('%a %b %d %Y'))
        when "Root Admin"
          v.gsub!(/@admin_email/, @partner.admin_info.email) unless @partner.nil?
        else
          # do nothing
      end
    end
  end
  expected.each_index{ |index|
    expected[index].keys.each{ |key|
      if key.eql?('Request Date')|| key.eql?('Date Purged')
        actual[index][key].replace(Chronic.parse(actual[index][key]).strftime('%a %b %d %Y'))
      end
      actual[index][key].should == expected[index][key]
      }
    }
end

Then /^I change to (\d+) days to purge account after delete/ do |days|
  @bus_site.admin_console_page.manage_pending_deletes_section.change_pending_deletes_setting(days)
  @bus_site.admin_console_page.manage_pending_deletes_section.wait_until_bus_section_load
end

Then /^I verify days to purge account after delete should be (\d+)/ do |days|
  actual = @bus_site.admin_console_page.manage_pending_deletes_section.get_pending_deletes_setting
  actual.should == days
end

Then /^I purge partner by (.+)/ do |company_name|
  @bus_site.admin_console_page.manage_pending_deletes_section.purge_partner(QA_ENV['bus_password'], company_name)
end

