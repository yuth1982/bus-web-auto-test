Then /^I should see download link for (.+)$/ do |string|
  @bus_site.admin_console_page.download_client_section.download_link_present?(string).should be_true
end

And /^I view (Details|Other Releases) for client (.+)$/ do |link, client|
  @bus_site.admin_console_page.download_client_section.open_view(link, client)
end

When /^I visit BUS download link for (.+)$/ do |client|
  @client_download_name = client
  page.visit("#{QA_ENV['bus_host']}/downloads/#{client}")
end

When /^I click download link for (.+)$/ do |string|
  @client_download_name = @bus_site.admin_console_page.download_client_section.click_link(string)
end

Then /^client started downloading successfully$/ do
  @bus_site.admin_console_page.download_client_section.start_downloading?(@client_download_name).should be_true
end

When /^I wait for client fully downloaded$/ do
  file_name =  "#{default_download_path}/#{@client_download_name}"
  60.times do
    break unless File.exists?(file_name+'.part')
    sleep(1)
  end
  File.exists?(file_name).should be_true
end

And /^the downloaded client should be same as the uploaded file (.+)$/ do |file|
  uploaded_file_path = File.dirname(Pathname.new(File.dirname(__FILE__)).parent.parent) + "/test_data/#{file}"
  uploaded_file_path.gsub!('/', '\\') if OS.windows?
  uploaded_hash = Digest::MD5.hexdigest(File.read(uploaded_file_path))
  downloaded_file_path = File.dirname(Pathname.new(File.dirname(__FILE__)).parent.parent) + "/downloads/#{@client_download_name}"
  downloaded_file_path.gsub!('/', '\\') if OS.windows?
  downloaded_hash = Digest::MD5.hexdigest(File.read(downloaded_file_path))
  downloaded_hash.should == uploaded_hash
end

Then /^I can find client download info of platform (Windows|Mac|Linux) in (Backup Clients|Sync Clients) part:$/ do |platform, client_type, table|
  actual = @bus_site.admin_console_page.download_client_section.client_download_info_hash(client_type)
  expected = table.raw
  expected.each{ |key| actual[platform].include?(key[0]).should be_true }
end

Then /^I should not see (Linux|Sync Clients) download info$/ do |type|
  if type == 'Linux'
    @bus_site.admin_console_page.download_client_section.client_download_info_hash('Backup Clients').has_key?('Linux').should_not be_true
  else
    @bus_site.admin_console_page.download_client_section.client_download_info_hash('Sync Clients').empty?.should be_true
  end
end