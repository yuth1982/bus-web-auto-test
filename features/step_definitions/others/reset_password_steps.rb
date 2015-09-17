And /^I click forget your password link$/ do
  @bus_site.login_page.click_forget_password
end

And /^I input email (.+) in reset password panel to reset password$/ do |email|
  if !(email.match(/^@.+$/).nil?)
    email =  '<%=' + email + '%>'
    email.replace ERB.new(email).result(binding)
  end
  @bus_site.login_page.reset_password(email)
end

When /^I click reset password link from the email$/ do
  Log.debug("#{@found_emails.size} emails found, please update your search query") if @found_emails.size != 1
  @mail_content = find_email_content(@email_search_query)
  # the url is like # https://mozy.com/p/531724/1441692752/58674ae5dcf8939a9d206093eac25b69/pass
  match = @mail_content.match(/https?:\/\/mozy.com\/[\S]+\/pass/) || @mail_content.match(/https?:\/\/www.mozypro.com\/[\S]+\/pass\/\?pid=[\d]+/) ||@mail_content.match(/https?:\/\/resetpassword.mozypro.com\/[\S]+\/pass\/\?pid=[\d]+/)
  reset_url = match[0] unless match.nil?
  @bus_site.login_page.go_to_url(reset_url)
end

Then /^I reset password with (.+)$/ do |password|
  @bus_site.login_page.reset_password_enter(password)
end

And /^I will see reset password massage (.+)$/ do |msg|
  @bus_site.login_page.reset_password_msg.include?(msg).should == true
end
