Given /^I log in aria admin console as (.+)$/ do |admin|
  @aria_site = AriaSite.new
  @aria_site.login_page.load
  @aria_site.login_page.login(admin)
end