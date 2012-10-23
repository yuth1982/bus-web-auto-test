Given /^I log in aria admin console as administrator$/ do
  @aria_site = AriaSite.new
  @aria_site.login_page.load
  @aria_site.login_page.login(ARIA_ENV['username'],ARIA_ENV['password'])
end