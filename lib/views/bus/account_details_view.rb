module Bus
  class AccountDetailsView < PageObject

  ACC_SETTINGS_DIV_ID = "setting-edit_account_settings-content"

  elements(:acc_setting_links_dd, {:xpath => "//div[@id='#{ACC_SETTINGS_DIV_ID}']/div/dl/span/dd//a"})
  element(:receives_statement_input, {:id => "receives_aria_stmt_via_email"})
  element(:submit_receives_statement_btn, {:xpath => "//div[@id='#{ACC_SETTINGS_DIV_ID}']//dl/span[6]/dd/form/span[@class='edit']/input"})
  element(:setting_saved_div, {:xpath => "//div[@id='setting-edit_account_settings-errors']/ul[@class='flash successes']"})

  def acc_details_desc_column_text
    driver.find_elements(:xpath, "//div[@id='#{ACC_SETTINGS_DIV_ID}']/div/dl/span/dt").map{ |span| span.text}
  end

  def acc_details_value_column_text
    driver.find_elements(:xpath, "//div[@id='#{ACC_SETTINGS_DIV_ID}']/div/dl/span/dd/form/span[@class='view']").map{ |span| span.text}
  end

  def change_receive_newsletter_link
    acc_setting_links_dd[6]
  end

  def change_receive_email_link
    acc_setting_links_dd[8]
  end

  def change_receive_statement_link
    acc_setting_links_dd[10]
  end

  def set_receive_statement_status(status)
    change_receive_statement_link.click
    receives_statement_input.select_by(:text,status)
    submit_receives_statement_btn.click
  end

  end
end