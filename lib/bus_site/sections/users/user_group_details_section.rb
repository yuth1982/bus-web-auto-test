module Bus
  # This class provides actions for user group details section
  class UserGroupDetailsSection < SiteHelper::Section

    # Private elements
    #
    element(:available_keys_dd, xpath: "//dl[1]/dd[1]")
    element(:available_quota_dd, xpath: "//dl[1]/dd[2]")
    element(:default_quota_dd, xpath: "//dl[2]/dd[3]")

    def available_keys
      available_keys_dd.text
    end

    def available_quota
      available_quota_dd.text
    end

    def default_quota
      default_quota_dd.text.gsub("(change)","").strip
    end

  end
end
