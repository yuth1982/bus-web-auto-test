module Bus
  class AccountDetailsView < PageObject

  ACC_SETTINGS_DIV_ID = "setting-edit_account_settings-content"

  element(:receives_statement_input, {:id => "receives_aria_stmt_via_email"})
  element(:submit_receives_statement_btn, {:xpath => "//div[@id='#{ACC_SETTINGS_DIV_ID}']//dl/span[6]/dd/form/span[@class='edit']/input"})
  element(:setting_saved_div, {:xpath => "//div[@id='setting-edit_account_settings-errors']/ul[@class='flash successes']"})

  elements(:acc_setting_descriptions_dt, {:xpath => "//div[@id='#{ACC_SETTINGS_DIV_ID}']/div/dl/span/dt"})
  elements(:acc_setting_contents_dd, {:xpath => "//div[@id='#{ACC_SETTINGS_DIV_ID}']/div/dl/span/dd"})
  elements(:acc_setting_links_dd, {:xpath => "//div[@id='#{ACC_SETTINGS_DIV_ID}']/div/dl/span/dd//a"})

  # @return [Array<String>]
  def invoice_settings_text
    acc_setting_descriptions_dt[3..-1].map { |row| row.text }
  end

  # @return [String]
  def receive_newsletter_status
    acc_setting_contents_dd[3].text.match(/Yes|No/).to_s
  end

  # @return [String]
  def receive_email_status
    acc_setting_contents_dd[4].text.match(/Yes|No/).to_s
  end

  # @return [String]
  def receive_statement_status
    acc_setting_contents_dd[5].text.match(/Yes|No/).to_s
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