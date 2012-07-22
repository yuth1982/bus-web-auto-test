module Aria
  class AdminConsolePage < PageObject
    section(:accounts_page, AccountsPage)

    # Top level navigation links
    element(:dashboard_link, {:xpath => "//a[@title='Dashboard']"})
    element(:accounts_link, {:xpath => "//a[@title='Accounts']"})
    element(:products_link, {:xpath => "//a[@title='Products']"})
    element(:marketing_link, {:xpath => "//a[@title='Marketing']"})
    element(:reporting_link, {:xpath => "/a[@title='Reporting']"})
    element(:control_panel_link, {:xpath => "//a[@title='Control Panel']"})

    element(:main_frame, {:xpath => "//frame[@id='mainFrame']"})
    element(:main_body, {:class => "DvMainBody"})

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