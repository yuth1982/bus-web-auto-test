When /^I search emails by keywords:$/ do |keywords_table|
  expected = keywords_table.hashes
  expected.each do |col|
    col.each do |k,v|
      case k
        when 'to'
          v.gsub!(/@new_user_email/, @new_users.first.email) unless @new_users.nil?
          v.gsub!(/@new_admin_email/, @partner.admin_info.email) unless @partner.nil?
        when 'date'
          v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
        when 'subject'
          # Skipped
        when 'content'
          unless @partner.nil?
            v.gsub!(/@new_admin_email/, @partner.admin_info.email)
            v.gsub!(/@company_address/, @partner.company_info.address)
            v.gsub!(/@XXXX/, @partner.credit_card.number[12..-1])
            v.gsub!(/@admin_first_name/,@partner.admin_info.first_name)
            v.gsub!(/@first_name/, @partner.credit_card.first_name)
          end
        else
          # do nothing
      end
    end
  end
  @email_search_query = keywords_table.hashes.first.map{|key, value| "#{key}:#{value}"}.join(' AND ')
  Log.info(@email_search_query)
  @found_emails = find_emails(@email_search_query)
end

Then /^I should see (\d+) email\(s\)$/ do |num_emails|
  @found_emails.size.should == num_emails.to_i
end

When /^I retrieve email content by keywords:$/ do |keywords_table|
  step %{I search emails by keywords:}, table(%{
      |#{keywords_table.headers.join('|')}|
      |#{keywords_table.rows.first.join('|')}|
    })
  raise "#{@found_emails.size} emails found, please update your search query" if @found_emails.size != 1
  @mail_content = find_email_content(@found_emails.first.id)
end

Then /^I verify email address from email content$/ do
  match = @mail_content.match(/https?:\/\/secure.mozy.[\S]+\/registration\/verify_email_address\/[\S]+/)
  url = match[0] unless match.nil?
  response = send_request(url)
  response.code.should == '200'
end