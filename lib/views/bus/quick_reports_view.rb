module Bus
  class QuickReportsView < PageObject
    element(:link_desc_table, {:xpath => "//div[@id='jobs-quick_reports-content']/div/table"})
  end
end