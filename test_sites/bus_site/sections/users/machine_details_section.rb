module Bus

  class MachineDetailsSection < SiteHelper::Section

    element(:dso_table, xpath: "//div[starts-with(@id, 'machine-show-')]/div/div/table")

    def dso_hashes
      dso_table.hashes
    end
  end

end
