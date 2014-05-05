When /^I navigate to (.+) login page$/ do |partnertype|
  @freyja_site = FreyjaSite.new
  @freyja_site.login_page(partnertype).load
end

When /^I log into (.+) freyja with username (.+) and password (.+)$/ do |partnertype, username, password|
  @freyja_site.login_page(partnertype).login(username, password)
end

Then /^I login freyja successfully$/ do
  @freyja_site.login_page.logged_in.should be_true
end

Given /^I log in freyja as (MozyHome|MozyPro|MozyEnterprise|OEM) user$/ do |partnertype|
  @freyja_site = FreyjaSite.new
  @freyja_site.login_page(partnertype).load
  case partnertype
    when 'MozyHome'
      @freyja_site.login_page(partnertype).login(QA_ENV['home_username'], QA_ENV['home_password'])
    when 'MozyPro'
      @freyja_site.login_page(partnertype).login(QA_ENV['pro_username'], QA_ENV['pro_password'])
    when 'MozyEnterprise'
      @freyja_site.login_page(partnertype).login(QA_ENV['ent_username'], QA_ENV['ent_password'])
    when 'OEM'
      @freyja_site.login_page(partnertype).login(QA_ENV['oem_username'], QA_ENV['oem_password'])
  end
end
