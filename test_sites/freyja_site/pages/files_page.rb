module Freyja
  # This class provides actions for file
  class FilesPage < SiteHelper::Page

    # Private elements
    # backup elements
    element(:device_name, xpath: "//*[@id='backup_tab']//span[@class='name']")
    element(:drive_name, xpath: "//span[text()='C:']")
    element(:users_name, xpath: "//span[text()='Users']")
    element(:user_name, xpath: "//span[text()='jeffw.ART']")
    element(:desktop_name, xpath: "//span[text()='Desktop']")
    element(:backup_file_checkbox, xpath: "//*[starts-with(@id,'4565:File:')][1]/td[1]/div/span")
    element(:backup_folder_checkbox, xpath: "//*[starts-with(@id,'4565:Folder:')][2]/td[1]/div/span")

    #Sync elements
    element(:sync_file_checkbox, xpath: "//*[starts-with(@id,'4564:File:')][1]/td[1]/div/span")

    # Public: Choose one backup file
    #
    # Example
    #   @freyja_site.files_page.choose_one_backup_file
    #
    # Returns nothing
    def choose_one_backup_file
      device_name.click
      drive_name.click
      users_name.click
      user_name.click
      desktop_name.click
      backup_file_checkbox.click
    end

    # Public: Choose one sync file
    #
    # Example
    #   @freyja_site.files_page.choose_one_sync_file
    #
    # Returns nothing
    def choose_one_sync_file
      sync_file_checkbox.click
    end

    # Public: Choose one backup folder
    #
    # Example
    #   @freyja_site.files_page.choose_one_backup_folder
    #
    # Returns nothing
    def choose_one_backup_folder
      device_name.click
      drive_name.click
      users_name.click
      user_name.click
      backup_folder_checkbox.click
    end
  end
end
