When /^I select the (devices|synced) tab$/ do |device_choice|
  case device_choice
    when "devices"
      @freyja_site.mainUI.chooseBackupDevice
    when "synced"
      @freyja_site.mainUI.chooseSyncDevice
  end
end

And /^I choose my machine$/ do
  @freyja_site.mainUI.chooseMachine

end