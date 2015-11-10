module Bus

  class MachineDetailsSection < SiteHelper::Section

    element(:dso_table, xpath: "//th[text()='Order ID']/../../../../table")
    element(:machine_info_dls, css: 'div[id^=machine-show-] dl')

    #Manifest section
    element(:manifest_view_lnk, xpath: "//div[contains(@id,'machine-show')]//a[text()='View']")
    element(:manifest_raw_lnk, xpath: "//div[contains(@id,'machine-show')]//a[text()='Raw']")

    element(:replace_machine_lnk, xpath: "//a[text()='Replace Machine']")
    element(:delete_machine_lnk, xpath: "//a[text()='Delete Machine']")
    element(:undelete_machine_lnk, xpath: "//a[text()='Undelete Machine']")

    # Public: General information hash
    #
    # @param [none]
    #
    # Example:
    #   partner_details_section.general_info_hash
    #   # => {"ID:"=>"7741927", "External ID:"=>"(change)", "Owner:"=>"zoezjn+machine1@gmail.com", "Space Used:"=>"120.7MB", "Last Update:"=>"5 hours ago", "Encryption:"=>"Default", "Data Center:"=>"qa6"}
    #
    # @return [Hash]
    def machine_info_hash
      wait_until_bus_section_load
      output = machine_info_dls.dt_dd_elements_text
      Hash[*output.flatten]
    end

    def dso_hashes
      wait_until_bus_section_load
      dso_table.hashes
    end

    def click_view_manifest
      manifest_view_lnk.click
    end

    def click_raw_manifest
      manifest_raw_lnk.click
    end

    def wait_until_manifest_file_downloaded (file_name)
      wait_until { file_exists?(file_name) }
    end

    def delete_manifest_file (file_name)
      file = File.join(default_download_path, file_name)
      File.delete(file) if File.file?(file)
    end

    def click_replace_machine
      replace_machine_lnk.click
    end

    def delete_undelete_machine(action)
      if action == 'delete'
        delete_machine_lnk.click
      else
        undelete_machine_lnk.click
      end
      alert_accept
    end

    def data_shuttle_table_visible?
      !(locate(:xpath, "//th[text()='Order ID']/../../../../table").nil?)
     end

    def undelete_machine_link_exist
       !(locate(:xpath, "//a[text()='Undelete Machine']").nil?)
    end
  end
end
