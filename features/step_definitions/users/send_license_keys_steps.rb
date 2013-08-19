When /^I click Send Keys button$/ do
  @bus_site.admin_console_page.user_details_section.click_send_user_keys
end

Then /^I can see Send Keys button is disable$/ do
  @bus_site.admin_console_page.user_details_section.send_keys_button_disabled?.should be_true
end

Then /^I can find (\d+) (Unactivated|Activated) (Desktop|Server) license key\(s\) from the mail$/ do |number, status, type|
  step %{I can find #{number} elements by xpath "//div[@class='section_line']/table[preceding::div[1][span[text()='#{status}']]]/tbody/tr[td[text()='#{type}']]" from email content}
end

Then /^I cannot find any (Unactivated|Activated) license key\(s\) from the mail$/ do |status|
  step %{I can find 0 elements by xpath "//div[@class='section_line']/table[preceding::div[1][span[text()='#{status}']]]" from email content}
end

Then /^Unactivated keys should show above activated in the mail$/ do
  step %{I can find 1 elements by xpath "//div[@class='section_line'][div[preceding::div[1][span[text()='Unactivated']]][span[text()='Activated']]]" from email content}
end