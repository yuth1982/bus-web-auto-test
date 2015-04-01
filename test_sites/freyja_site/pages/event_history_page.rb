module Freyja

  class EventHistoryPanel < SiteHelper::Page

    # restore status
    element(:restore_status_div, xpath: "//table[@id='dt_all_restores']/tbody/tr[1]/td[5]/div")
    element(:restore_status_div2, xpath: "//*[@id='dt_all_restores']/tbody/tr[2]/td[5]/div")
    element(:sort_by_type_column, xpath: "//div[@id='dt_all_restores_wrapper']/div[2]/div/div/div/div/table/thead/tr/th[3]/div")
    element(:archive_download,xpath: "//div[@id='restore_downloads']/div[3]/a")

    # Public: get restore status
    #
    # Example
    #   @freyja_site.event_history_page.get_restore_status(restore_id)
    #
    # Returns nothing
    def get_restore_status(restore_id)
      sleep 5
      puts  "//tr[@id='#{restore_id}']/td[5]/div"
      return find(:xpath, "//tr[@id='#{restore_id}']/td[5]/div").text.to_s
    end

    def get_download_restore_status
      sleep 5
      return restore_status_div.text.to_s
    end

    def restore_event_click
      restore_status_div.click
      sleep 5
    end

    def event_detail_slide_in
      page.has_content?("Status:")
    end

    def sort_by_type
      sort_by_type_column.click
      sleep 5
    end

    def download_latest_archive_result
      archive_download.click
    end

    def restore_second_event
      if restore_status_div2.text.to_s == "Ready for Download"
        restore_status_div2.click
        sleep 10
        archive_download.click
      end
    end

  end
end