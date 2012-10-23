module Bus
  # This class provides user details
  class UserDetailsSection < SiteHelper::Section
    # Private elements
    #
    element(:change_status_link, xpath: "//span[starts-with(@id,'user-display-status-')]//a")
    element(:status_selection, xpath: "//select[@id='status']")
    element(:submit_status_btn, xpath: "//span[starts-with(@id,'user-change-status-')]//input")
    element(:user_status, xpath: "//span[starts-with(@id,'user-display-status-')]")
    element(:the_user_id, xpath: "//div[@class='show-details']//dl[1]/dd[1]")

    def status_is
      user_status.text[0..-10]
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