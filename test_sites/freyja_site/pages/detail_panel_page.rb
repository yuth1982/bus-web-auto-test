module Freyja

  class DetailPanelPage < SiteHelper::Page

    element(:backup_download_btn, xpath: "//*[@id='backup-layout']/div/table/tbody/tr/td/table/tbody/tr/td[2]/div/div[2]/div[1]/div/a[1]/span")
    section(:restore_all_files_section, RestoreOptionsSection, xpath: "//*[@id='backup_tab']//a[@title='Restore All Files...']")

    def open_restore_all_files_wizard(section_id, use_quick_link = false)
      # Looking for link in navigation menu
      find(:xpath, section_id)
      # calling all method does not require to wait
      sections = all(:xpath, section_id)
      el = use_quick_link ? sections.first : sections.last
      if sections.first.element_parent[:class].match(/active/).nil? && sections.last.element_parent[:class].match(/active/).nil?
        el.click
      end
    end

    def click_download
      backup_download_btn.click
      sleep 2
    end

  end
end