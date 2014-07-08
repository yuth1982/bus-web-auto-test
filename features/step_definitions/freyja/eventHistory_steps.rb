
#  check restore status in event history
Then /^this restore is (.+)/ do  |restore_status|
  case @restore.restore_type
    when 'instant'
      status = @freyja_site.event_history_page.get_download_restore_status
      if status != 'Ready for Download'
        status.should == restore_status
      end
    else
      case QA_ENV['environment']
        when "staging"
          status = @freyja_site.event_history_page.get_download_restore_status
          if status != 'Ready for Download'
            status.should == restore_status
          end
        else
          @restore.restore_id = RestoreHelper.get_restore_id(@restore.restore_name)
          status = @freyja_site.event_history_page.get_restore_status(@restore.restore_id)
          if status != 'Ready for Download'
            status.should == restore_status
          end
      end
  end
end

And /^I choose the latest event$/ do
  @freyja_site.event_history_page.restore_event_click
end

Then /^detail panel slide in$/ do
  @freyja_site.event_history_page.event_detail_slide_in.should be_true
end

And /^I download the previous archive result$/ do
  @freyja_site.event_history_page.restore_second_event
end
