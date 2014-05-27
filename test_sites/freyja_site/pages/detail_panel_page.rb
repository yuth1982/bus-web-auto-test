module Freyja

  class DetailPanelPage < SiteHelper::Page


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

  end
end