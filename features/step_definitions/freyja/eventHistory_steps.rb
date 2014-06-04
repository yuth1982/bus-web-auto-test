
#  check restore status in event history
Then /^this restore is (.+)/ do  |restore_status|
  case @restore.restore_type
    when 'instant'
      status = @freyja_site.event_history_page.get_download_restore_status
      status.should == restore_status
    else
      @restore.restore_id = RestoreHelper.get_restore_id(@restore.restore_name)
      status = @freyja_site.event_history_page.get_restore_status(@restore.restore_id)
      status.should == restore_status
    end
end

And /^I choose the latest event$/ do
  @freyja_site.event_history_page.restore_event_click
end

Then /^detail panel slide in$/ do
  @freyja_site.event_history_page.event_detail_slide_in.should be_true
end
