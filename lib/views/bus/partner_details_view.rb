module Bus
  class PartnerDetailsView < PageObject

  STATEMENTS_THEAD_LOC = "//div[@id='partner-show-%s-content']//table[@class='table-view']/thead/tr"
  STATEMENTS_TBODY_LOC = "//div[@id='partner-show-%s-content']//table[@class='table-view']/tbody/tr"
  LICENSE_TYPES_THEAD_LOC = "//div[@id='partner_license_types_%s']//table[@class='region view']/tbody/tr[1]"
  LICENSE_DESKTOP_LOC = "//div[@id='partner_license_types_%s']//table[@class='region view']/tbody/tr[2]"
  LICENSE_SERVER_LOC = "//div[@id='partner_license_types_%s']//table[@class='region view']/tbody/tr[3]"
  TOP_ONE_INVOICE_LOC = "//div[@id='partner-show-%s-content']//table[@class='table-view']/tbody/tr[1]/td[5]/a"
  ARIA_ID_LOC = "//div[@id='partner-show-%s-content']//dl[1]/dd[3]"
  
  element :billing_info_link, {:link => "Billing Info"}
  element :act_as_link, {:link => "act as"}
  element :bill_history_h3, {:xpath => "//h3[text()='Billing History']"}
  element :view_in_aria_link, {:link => "View in Aria"}
  element :export_to_excel_link, {:link => "Export to Excel (CSV)"}
  element :vat_number_input, {:id => "vat_info_vat_number"}

  def partner_id
    billing_info_link.attribute("href").match(/(billing\/)(\d+)$/)[2].to_s
  end

  def aria_id
    driver.find_element(:xpath, ARIA_ID_LOC%partner_id).text.match(/\d+$/).to_s
  end

  def billing_statements_table_head
    driver.find_elements_text(:xpath, STATEMENTS_THEAD_LOC%partner_id).first
  end

  def billing_statements
    driver.find_elements_text(:xpath, STATEMENTS_TBODY_LOC%partner_id)
  end

  def license_types_thead
    driver.find_elements_text(:xpath, LICENSE_TYPES_THEAD_LOC%partner_id)
  end

  def license_desktop
    driver.find_elements_text(:xpath, LICENSE_DESKTOP_LOC%partner_id)
  end

  def license_server
    driver.find_elements_text(:xpath, LICENSE_SERVER_LOC%partner_id)
  end

  def top_one_invoice_link
    driver.find_element(:xpath, TOP_ONE_INVOICE_LOC%partner_id)
  end

  end
end