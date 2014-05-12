module Freyja
  # This class provides actions for file
  class ActionsPanePage < SiteHelper::Page

    # Private elements
    element(:large_download_options_action, xpath: "//*[@title='Large Download Options...']")
    element(:exclude_deleted_files_action, xpath: "//*[@title='Exclude Deleted Files']")
    element(:include_deleted_files_action, xpath: "//*[@title='Include Deleted Files']")

    # Sync element
    element(:delete_action, xpath: "//*[@title='Delete...']")
    element(:delete_confirm, xpath: "//*[@id='confirm_delete_dialog']//*[text()='Yes']")
    element(:sync_file_checkbox, xpath: "//*[starts-with(@id,'4564:File:')][1]/td[1]/div/span")
    element(:sync_file_name, xpath: "//*[starts-with(@id,'4564:File:')][1]/td[2]/div/span[2]")

    # Public: Click Large Download Options from Actions pane
    #
    # Example
    #   @freyja_site.actions_pane_page.click_large_download_options
    #
    # Returns nothing
    def click_large_download_options
      large_download_options_action.click
    end

    # Public: Click Exclude Deleted Files from Actions pane
    #
    # Example
    #   @freyja_site.actions_pane_page.exclude_deleted_files
    #
    # Returns nothing
    def exclude_deleted_files
      exclude_deleted_files_action.click
    end

    # Public: Click Exclude Deleted Files from Actions pane
    #
    # Example
    #   @freyja_site.actions_pane_page.include_deleted_files
    #
    # Returns nothing
    def include_deleted_files
      include_deleted_files_action.click
    end

    # Public: Delete one file from Actions pane
    #
    # Example
    #   @freyja_site.actions_pane_page.delete_one_file
    #
    # Returns nothing
    def delete_one_file
      @file_name = sync_file_name.text.to_s
      sync_file_checkbox.click
      delete_action.click
      delete_confirm.click
    end

    # Public: Click Delete from Actions pane
    #
    # Example
    #   @freyja_site.actions_pane_page.delete_files
    #
    # Returns nothing
    def delete_files
      delete_action.click
      delete_confirm.click
    end

    # Public: Check file is deleted
    #
    # Example
    #   @freyja_site.actions_pane_page.check_file_deleted
    #
    # Returns nothing
    def check_file_deleted
      wait_until do
        sync_file_checkbox.visible?
      end
      @compare_file_name = sync_file_name.text.to_s
      @file_name.should_not == @compare_file_name
    end

  end
end
