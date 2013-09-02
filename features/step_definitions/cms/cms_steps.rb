
When (/^I verify download page contents$/) do
  @cms_site = CmsSite.new
  @cms_site.content_pages.download_check_verification
end
