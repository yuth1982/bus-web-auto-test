module Bus
  # This class provides actions for user group details section
  class UserGroupDetailsSection < SiteHelper::Section

    # Private elements
    #
    element(:delete_user_group, xpath: "//a[text()='Delete User Group']")
    elements(:group_details_dls, xpath: "//div/dl")

    def group_details_hash
      has_delete_user_group?
      output = {}
      group_details_dls.map{ |dl| output = output.merge(dl.dl_hashes) }
      output.delete_if { |k, _| k.empty? }
    end
  end
end
