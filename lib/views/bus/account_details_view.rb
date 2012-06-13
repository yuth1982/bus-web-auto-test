module Bus
  class AccountDetailsView < PageObject

  ACC_SETTINGS_DIV_ID = "setting-edit_account_settings-content"

  element :acc_settings_div, {:xpath => ACC_SETTINGS_DIV_ID}

  element :receive_newsletter_status_span, {:xpath => "//div[@id='#{ACC_SETTINGS_DIV_ID}']//dl/span[4]/dd/form/span[@class='view']"}
  element :change_receive_newsletter_link, {:xpath => "//div[@id='#{ACC_SETTINGS_DIV_ID}']//dl/span[4]/dd/form/span[@class='view']/a"}

  element :receive_email_status_span, {:xpath => "//div[@id='#{ACC_SETTINGS_DIV_ID}']//dl/span[5]/dd/form/span[@class='view']"}
  element :change_receive_email_link, {:xpath => "//div[@id='#{ACC_SETTINGS_DIV_ID}']//dl/span[5]/dd/form/span[@class='view']/a"}

  element :receive_statement_status_span, {:xpath => "//div[@id='#{ACC_SETTINGS_DIV_ID}']//dl/span[6]/dd/form/span[@class='view']"}
  element :change_receive_statement_link, {:xpath => "//div[@id='#{ACC_SETTINGS_DIV_ID}']//dl/span[6]/dd/form/span[@class='view']/a"}
  element :receives_statement_input, {:id => "receives_aria_stmt_via_email"}
  element :submit_receives_statement_btn, {:xpath => "//div[@id='#{ACC_SETTINGS_DIV_ID}']//dl/span[6]/dd/form/span[@class='edit']/input"}

  element :setting_saved_div, {:xpath => "//div[@id='setting-edit_account_settings-errors']/ul[@class='flash successes']"}
  elements :invoice_settings_dt, {:xpath => "//div[@id='#{ACC_SETTINGS_DIV_ID}']//dl/span/dt"}

  # @return [Array<String>]
  def invoice_settings_text
    SeleniumHelper.instance.get_elements_text invoice_settings_dt
  end

  # @return [String]
  def receive_newsletter_status
    receive_newsletter_status_span.text.match(/Yes|No/).to_s
  end

  # @return [String]
  def receive_email_status
    receive_email_status_span.text.match(/Yes|No/).to_s
  end

  # @return [String]
  def receive_statement_status
    receive_statement_status_span.text.match(/Yes|No/).to_s
  end

  def set_receive_statement_status status
    change_receive_statement_link.click
    receives_statement_input.select_by :text,status
    submit_receives_statement_btn.click
    setting_saved_div.displayed?
  end

  end
end