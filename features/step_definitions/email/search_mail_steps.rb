When /^I search emails by keywords:$/ do |keywords_table|
  @email_search_query = []
  expected = keywords_table.hashes
  expected.each do |col|
    col.each do |k,v|
      case k
        when 'to'
          v.gsub!(/@new_user_email/, @new_users.first.email) unless @new_users.nil?
          v.gsub!(/@new_admin_email/, @partner.admin_info.email) unless @partner.nil?
          v.gsub!(/@existing_admin_email/, @existing_admin_email) unless @existing_admin_email.nil?
          v.gsub!(/@existing_user_email/, @existing_user_email) unless @existing_user_email.nil?
        when 'content'
          unless @partner.nil?
            v.gsub!(/@new_admin_email/, @partner.admin_info.email)
            v.gsub!(/@company_address/, @partner.company_info.address)
            v.gsub!(/@XXXX/, @partner.credit_card.number[12..-1])
            v.gsub!(/@admin_first_name/,@partner.admin_info.first_name)
            v.gsub!(/@first_name/, @partner.credit_card.first_name)
          end
        #Legacy from Zimbra
        when  'date','after'
          #IMAP doesn't search over minutes just dates
            v = Net::IMAP.format_date(Date.today) if v == 'today'
        when 'subject'
          v.gsub!(/@license_key/, @order.license_key[0]) if v.include?("@license_key")
        else
          # do nothing
      end
      v.replace ERB.new(v).result(binding)
      # for license key, the value contains space, need to remove the space
      v.gsub!(/ /,'') unless v.match(/^\[.+\]$/).nil?
      case k.downcase
        when 'to','cc','from','subject','body';
        when 'before','since', 'on' ;
        #Legacy Zimbra corrections
        when 'date'; k = 'on'
        when 'after'; k = 'since'
        when 'content'; k = 'body'
        else
          Log.debug("'#{k}' is not a valid imap search key")
          next
        end
        @email_search_query << k.upcase
        @email_search_query << v
    end
  end
  sleep 15

  Log.info(@email_search_query)
  30.times do
    @found_emails = find_emails(@email_search_query)
    sleep 60 if @found_emails.size == 0
    break if @found_emails.size > 0
  end
end

Then /^I should see (\d+) email\(s\)$/ do |num_emails|
  @found_emails = [] if @found_emails.nil?
  @found_emails.size.should == num_emails.to_i
  #Log.debug @found_emails[0].body if @found_emails.size > 0
end

When /^I (retrieve email content|download email attachment) by keywords:$/ do |type, keywords_table|
  sleep 30
  step %{I search emails by keywords:}, table(%{
      |#{keywords_table.headers.join('|')}|
      |#{keywords_table.rows.first.join('|')}|
    })
  Log.debug("#{@found_emails.size} emails found, please update your search query") if @found_emails.size != 1
  attach =(type.include?("download")? true: nil)
  @mail_content = find_email_content(@email_search_query, attach)
  Log.debug(@mail_content)
end

Then /^I get verify email address from email content$/ do
    if @partner.base_plan.eql?("free") # free account url is different
      match = @mail_content.match(/https?:\/\/secure.mozy.[\S]+\/c\/[\S]+/)
    else # standard email url piece
      match = @mail_content.match(/https?:\/\/secure.mozy.[\S]+\/registration\/verify_email_address\/[\S]+/)
    end
  @verify_email_query = match[0] unless match.nil?
end

# for mozyhome user change email address the new email will receive Email Address Verification
And /^I get verify email address from email content for mozyhome change email address$/ do
  match = @mail_content.match(/https?:\/\/secure.mozy.[\S]+\/registration\/verify_email_address\/[\S]+/)
  (match.nil?).should == false
  @verify_email_query = match[0] unless match.nil?
end

Then /^I check the email content should include:$/ do |msg|
  @mail_content.should include (msg)
end

Then /^I check the mozy brand logo in email content is:(.+)$/ do |logo_url|
  @mail_content.should include (logo_url)
end
