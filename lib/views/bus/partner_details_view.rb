module Bus
  class PartnerDetailsView < PageObject

    STATEMENTS_TABLE_LOC = "//div[@id='partner-show-%s-content']//table[@class='table-view']"

    element(:billing_info_link, {:link => "Billing Info"})
    element(:act_as_link, {:link => "act as"})
    element(:change_name_link, {:link => "Change Name"})
    element(:delete_partner_link, {:link => "Delete Partner"})

    element(:vat_number_input, {:id => "vat_info_vat_number"})

    element(:view_in_aria_link, {:link => "View in Aria"})
    element(:export_to_excel_link, {:link => "Export to Excel (CSV)"})

    def partner_id
      billing_info_link.attribute("href").match(/(billing\/)(\d+)$/)[2].to_s
    end

    def aria_id
      driver.find_element(:xpath, "//dt[text()='Aria ID:']").next_sibling
    end

    def billing_history_table
      driver.find_element(:xpath, STATEMENTS_TBODY_LOC%partner_id)
    end

    # Delete partner hidden forms
    def cancellation_submit_btn
      driver.find_element(:xpath, "//div[@id='cancellation_reasons_#{partner_id}']//input[@value='Submit']")
    end

    def delete_password_tb
      driver.find_element(:xpath, "//div[@id='partner-show-#{partner_id}-delete_form']//input[@id='password']")
    end

    def delete_submit_btn
      driver.find_element(:xpath, "//div[@id='partner-show-#{partner_id}-delete_form']//input[@value='Submit']")
    end

    def delete_partner(password)
      delete_partner_link.click
      cancellation_submit_btn.click
      sleep 2 # wait for load delete password div
      delete_password_tb.type_text(password)
      delete_submit_btn.click
      sleep 5 # wait for delete partner
    end
  end
end