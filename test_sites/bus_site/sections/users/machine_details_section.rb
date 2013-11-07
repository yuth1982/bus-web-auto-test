module Bus

  class MachineDetailsSection < SiteHelper::Section

    element(:dso_table, xpath: "//div[starts-with(@id, 'machine-show-')]/div[2]/div[4]/table")

    def dso_hashes
      wait_until_bus_section_load
      dso_table.hashes
    end
  end

end
