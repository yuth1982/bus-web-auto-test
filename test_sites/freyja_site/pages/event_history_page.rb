module Freyja

  class EventHistoryPanel < SiteHelper::Page

    # restore status
    element(:restore_status_div, xpath: "//*[@id='dt_all_restores']/tbody/tr[1]/td[5]/div")

    def get_download_restore_status
      return restore_status_div.text.to_s
    end

    def get_restore_status(restore_id)
      return find(:xpath, "//tr[@id='#{restore_id}']/td[5]/div").text.to_s
    end

  end
end