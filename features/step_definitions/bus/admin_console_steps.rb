When /^I navigate to (.+) view from bus admin console page$/ do |link_name|
  @bus_admin_console_page.navigate_to_link(link_name)
end

Then /^Corporate Invoices link should not exist in Internal Tools menu$/ do
  @bus_admin_console_page.link_exist?("Corporate Invoices").should == false
end



