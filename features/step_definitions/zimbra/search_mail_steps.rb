When /^I search emails by keywords:$/ do |keywords_table|
  #zimbra search keywords avail https://mail.dechocorp.com/zimbra/help/en_US/advanced/Zimbra_User_Help.htm
  expected = keywords_table.hashes
  expected.each do |col|
    col.each do |k,v|
      case k
        when 'to'
          v.gsub!(/@new_user_email/, @new_users.first.email) unless @new_users.nil?
          v.gsub!(/@new_admin_email/, @partner.admin_info.email) unless @partner.nil?
          v.gsub!(/@existing_admin_email/, @existing_admin_email) unless @existing_admin_email.nil?
          v.gsub!(/@existing_user_email/, @existing_user_email) unless @existing_user_email.nil?
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
      v.replace ERB.new(v).result(binding)
    end
  end
  sleep 15
  @email_search_query = keywords_table.hashes.first.map {|key, value|
    if value.match(/^\[.+\]$/) # Convert to Array if it is
      eval(value).map {|v| "#{key}:#{v}" }
    else
      "#{key}:#{value}"
    end
  }.flatten.join(' AND ')
  # wait 10s for the email to come in, previous 5s is prone to fail
  Log.info(@email_search_query)
  @found_emails = find_emails(@email_search_query)
end

Then /^I should see (\d+) email\(s\)$/ do |num_emails|
  @found_emails.size.should == num_emails.to_i
end

When /^I retrieve email content by keywords:$/ do |keywords_table|
  sleep 30
  step %{I search emails by keywords:}, table(%{
      |#{keywords_table.headers.join('|')}|
      |#{keywords_table.rows.first.join('|')}|
    })
  Log.debug("#{@found_emails.size} emails found, please update your search query") if @found_emails.size != 1
  @mail_content = find_email_content(@found_emails.first.id)
  Log.debug(@mail_content)
end

Then /^I can find (\d+) elements by (xpath|css) "(.*?)" from email content$/ do |size, method, query|
  doc = Nokogiri.XML(get_html_from_email(@found_emails.first.id))
  doc.send(method, query).size.should == size.to_i
end

Then /^I get verify email address from email content$/ do
    if @partner.base_plan.eql?("free") # free account url is different
      match = @mail_content.match(/https?:\/\/secure.mozy.[\S]+\/c\/[\S]+/)
    else # standard email url piece
      match = @mail_content.match(/https?:\/\/secure.mozy.[\S]+\/registration\/verify_email_address\/[\S]+/)
    end
  @verify_email_query = match[0] unless match.nil?
  #response = send_request(url)
  #response.code.should == '200'
end
