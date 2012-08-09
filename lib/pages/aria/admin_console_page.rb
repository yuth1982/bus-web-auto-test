module Aria
  # This class provides actions for aria admin console page
  class AdminConsolePage < PageObject

    section(:accounts_page, AccountsPage)

    # Private elements
    #
    element(:main_frame, {:xpath => "//frame[@id='mainFrame']"})
    element(:main_body, {:class => "DvMainBody"})

    # Public: Click link on aria admin console page
    #
    # Example
    #   @bus_admin_console_page.navigate_to_link("Add New Partner")
    #
    # Returns nothing
    def navigate_to_link(link_name)
      driver.switch_to.default_content
      driver.find_element(:xpath, "//a[@title='#{link_name}']").click
    end

    # Public: Switch to iframe id work_frm
    #
    # Returns nothing
    def switch_to_work_frame
      driver.switch_to.default_content
      driver.switch_to.frame "outerFrame"
      driver.switch_to.frame main_frame
      driver.switch_to.frame "work_frm"
    end

    # Public: Switch to iframe id inner_work_frm
    #
    # Returns nothing
    def switch_to_inner_work_frame
      switch_to_work_frame
      driver.switch_to.frame "inner_work_frm"
    end
  end
end