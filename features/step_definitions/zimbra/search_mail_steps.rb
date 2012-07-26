When /^I search email to match all keywords:$/ do |keywords|
  keywords_query = keywords.hashes.first.map{|key, value| "#{key}:#{value}"}.join(" AND ").gsub(/@today/,Time.now.localtime("-06:00").strftime("%m/%d/%Y")).gsub(/@first_name/, @partner.credit_card.first_name).gsub(/@XXXX/, @partner.credit_card.number[12..-1]).gsub(/@email/,@partner.admin_info.email).gsub(/@address/,@partner.company_info.address)
  puts "query: #{keywords_query}"
  @mail_main_page.search_mails(keywords_query)
end

Then /^I should see (\d+) email\(s\) displayed in search results$/ do |num_emails|
  rows = @mail_main_page.search_results.body_rows
  rows_length = rows.nil? ? 0 : rows.length
  rows_length.should == num_emails.to_i
end