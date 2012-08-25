When /^I search email to match all keywords:$/ do |keywords|
  query = keywords.hashes.first.map{|key, value| "#{key}:#{value}"}.join(" AND ")
  query = query.gsub(/@today/,Time.now.localtime("-06:00").strftime("%m/%d/%Y"))
  query = query.gsub(/@first_name/, @partner.credit_card.first_name)
  query = query.gsub(/@XXXX/, @partner.credit_card.number[12..-1])
  query = query.gsub(/@email/,@partner.admin_info.email)
  query = query.gsub(/@address/,@partner.company_info.address)
  query = query.gsub(/@admin_first_name/,@partner.admin_info.first_name)
  puts "query: #{query}"
  @emails = find_emails(query)
end

Then /^I should see (\d+) email\(s\) displayed in search results$/ do |num_emails|
  @emails.size.should == num_emails.to_i
end