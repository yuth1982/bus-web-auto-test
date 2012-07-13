When /^I search email to match all keywords:$/ do |keywords|
  sleep 10 # before search email, wait aria to send email
  keywords_query = keywords.hashes.first.map{|key, value| "#{key}:#{value}"}.join(" AND ").gsub(/Today/,Time.now.localtime("-06:00").strftime("%m/%d/%Y")).gsub(/First_Name/, @partner.first_name).gsub(/XXXX/, @partner.credit_card_number[12..-1]).gsub(/New partner's email/,@partner.email).gsub(/New partner's company address/,@partner.street_address)
  puts "query: #{keywords_query}"
  @mail_main_page.search_mails(keywords_query)
end

Then /^I should see (\d+) email\(s\) displayed in search results$/ do |num_emails|
  @mail_main_page.search_results.body_rows.length.should == num_emails.to_i
end