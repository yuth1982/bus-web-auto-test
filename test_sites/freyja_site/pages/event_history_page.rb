module Freyja

  class EventHistoryPanel < SiteHelper::Page

    # restore status
    element(:restore_status_div, xpath: "//*[@id='dt_all_restores']/tbody/tr[1]/td[5]/div")

    # Public: get restore status
    #
    # Example
    #   @freyja_site.event_history_page.get_restore_status(restore_id)
    #
    # Returns nothing
    def get_restore_status(restore_id)
      return find(:xpath, "//tr[@id='#{restore_id}']/td[5]/div").text.to_s
    end

    def get_download_restore_status
      return restore_status_div.text.to_s
    end

    def restore_event_click
      restore_status_div.click
      sleep 5
    end

    def event_detail_slide_in
      page.has_content?("Status:")
    end

  end
end