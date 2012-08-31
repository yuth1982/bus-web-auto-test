Given /^I log in aria admin console as (.+)$/ do |admin|
  @aria_site = AriaSite.new
  @aria_site.login_page.load
  @aria_site.login_page.login(admin)
end

When /^I navigate aria admin console page$/ do
  #@aria_site.admin_tools_page = Aria::AdminToolsPage.new
end