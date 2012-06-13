module Bus
  class ReturnResourcesView < PageObject
  element :licenses_server, {:id => "licenses_Server"}
  element :quota_server, {:id => "quota_Server"}
  element :licenses_desktop, {:id => "licenses_Desktop"}
  element :quota_desktop, {:id => "quota_Desktop"}
  element :continue, {:xpath => "//div[@id='resource-unpurchase_resources-content']//input[@value='Continue']"}
  element :resource_returned, {:xpath => "//div[@id='resource-unpurchase_resources-errors']/ul[@class='flash successes']"}

  RESOURCE_RETURNED_MSG = "Resources returned"

  def return server_lic_num,server_quota,desktop_lic_num,desktop_quota
    licenses_server.type_text server_lic_num.to_s
    quota_server.type_text server_quota.to_s
    licenses_desktop.type_text desktop_lic_num.to_s
    quota_desktop.type_text desktop_quota.to_s

    continue.click

    raise "Error on returning resources" unless resource_returned.text.include? RESOURCE_RETURNED_MSG
  end

end
end