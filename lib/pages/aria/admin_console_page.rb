module Aria
  # This class provides actions for aria admin console page
  class AdminConsolePage < PageObject
    section(:accounts_page, AccountsPage)

    element(:main_frame, {:xpath => "//frame[@id='mainFrame']"})
    element(:main_body, {:class => "DvMainBody"})

    def navigate_to_link(link_name)
      driver.find_element(:xpath, "//a[@title='#{link_name}']").click
    end

    def switch_to_work_frame
      driver.switch_to.default_content
      driver.switch_to.frame "outerFrame"
      driver.switch_to.frame main_frame
      driver.switch_to.frame "work_frm"
    end

    def switch_to_inner_work_frame
      switch_to_work_frame
      driver.switch_to.frame "inner_work_frm"
    end
  end
end