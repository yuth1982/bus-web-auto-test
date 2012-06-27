module Bus
  class BillingHistoryView < PageObject
    element(:export_to_excel_link, {:link => "Export to Excel (CSV)"})
    element(:bill_history_h3, {:xpath => "//h3[text()='Billing History']"})
    element(:billing_history_table, {:xpath => "//div[@id='resource-all_charges-content']//table[@class='table-view']"})
  end
end