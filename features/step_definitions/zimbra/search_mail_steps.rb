When /^I should see (\d+) email\(s\) when I search keywords:$/ do |num_emails, keywords|
  query = keywords.hashes.first.map{|key, value| "#{key}:#{value}"}.join(" AND ")
  query = query.gsub(/@today/,Time.now.localtime("-06:00").strftime("%m/%d/%Y"))
  query = query.gsub(/@first_name/, @partner.credit_card.first_name)
  query = query.gsub(/@XXXX/, @partner.credit_card.number[12..-1])
  query = query.gsub(/@email/,@partner.admin_info.email)
  query = query.gsub(/@address/,@partner.company_info.address)
  query = query.gsub(/@admin_first_name/,@partner.admin_info.first_name)
  puts "query: #{query}"
  emails = find_emails(query)
  emails.size.should == num_emails.to_i
end