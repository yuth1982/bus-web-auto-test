module Bus

  class MachineDetailsSection < SiteHelper::Section

    element(:dso_table, xpath: "//th[text()='Order ID']/../../../../table")
    element(:machine_info_dls, css: 'div[id^=machine-show-] dl')
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
  end

end
