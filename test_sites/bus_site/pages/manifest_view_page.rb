module Bus

  class ManifestViewPage < SiteHelper::Page
    # Private elements
    #
    element(:show_del_file_lnk, xpath: "//a[text()='show deleted files']")

    def view_manifest_window_visible (device_name)
      page.driver.browser.switch_to().window(page.driver.browser.window_handles.last)
      wait_until{ show_del_file_lnk.visible? }
      size = page.driver.find_window("Mozy, Inc. - Manifest for #{device_name}").size
      page.execute_script "window.close();"
      page.driver.browser.switch_to().window(page.driver.browser.window_handles.last)
      size
    end

  end
end
