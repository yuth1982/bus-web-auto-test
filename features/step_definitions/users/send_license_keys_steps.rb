When /^I click Send Keys button$/ do
  @bus_site.admin_console_page.user_details_section.click_send_user_keys
end

Then /^I can find (\d+) (Unactivated|Activated) (Desktop|Server) license key\(s\) from the mail$/ do |number, status, type|
	step %{I can find #{number} elements by xpath "//div[@class='section_line']/table[preceding::div[1][span[text()='#{status}']]]/tbody/tr[td[text()='#{type}']]" from email content}
end
