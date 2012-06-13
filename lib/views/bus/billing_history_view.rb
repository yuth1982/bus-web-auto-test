module Bus
  class BillingHistoryView < PageObject

    STATEMENTS_THEAD_LOC = "//div[@id='resource-all_charges-content']//table[@class='table-view']/thead/tr"
    STATEMENTS_TBODY_LOC = "//div[@id='resource-all_charges-content']//table[@class='table-view']/tbody/tr"

    element :export_to_excel_link, {:link => "Export to Excel (CSV)"}
    element :bill_history_h3, {:xpath => "//h3[text()='Billing History']"}
    element :top_one_invoice_link, {:xpath =>"//div[@id='resource-all_charges-content']//table[@class='table-view']/tbody/tr[1]/td[5]/a"}

    def billing_statements_table_head
      driver.find_elements_text(:xpath, STATEMENTS_THEAD_LOC).first
    end

    # return billing statements string array
    def billing_statements
      driver.find_elements_text(:xpath, STATEMENTS_TBODY_LOC)
    end

  end
end