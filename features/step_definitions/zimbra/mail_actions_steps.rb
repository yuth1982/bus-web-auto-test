When /^I download report from email attachment$/ do
  @mail_main_page.open_first_mail
  @mail_main_page.download_attachment
end