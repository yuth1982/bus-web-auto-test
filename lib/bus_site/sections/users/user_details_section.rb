module Bus
  # This class provides user details
  class UserDetailsSection < SiteHelper::Section
    # Private elements
    #
    element(:change_status_link, xpath: "//span[starts-with(@id,'user-display-status-')]//a")
    element(:status_selection, xpath: "//select[@id='status']")
    element(:submit_status_btn, xpath: "//span[starts-with(@id,'user-change-status-')]//input")

    element(:the_user_id, xpath: "//div[@class='show-details']//dl[1]/dd[1]")

    element(:delete_user_link, xpath: "//a[text()='Delete User']")
    elements(:user_details_dls, xpath: "//div[starts-with(@id,'user-show-')]//dl")

    def user_details_hash
      has_delete_user_link? # Wait until user details section loaded
      output = user_details_dls.map{ |dl| dl.dt_dd_elements_text }.delete_if { |k| k.empty? }
      Hash[*output]
    end

    def user_id
      the_user_id.text
    end

    def active_user
      change_status_link.click
      status_selection.select('Active')
      submit_status_btn.click
    end

  end
end