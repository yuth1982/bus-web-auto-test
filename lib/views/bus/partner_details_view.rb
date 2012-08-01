module Bus
  # This class provides actions for partner details view
  class PartnerDetailsView < PageObject

    # Constants
    #
    STATEMENTS_TABLE_LOC = "//div[@id='partner-show-%s-content']//table[@class='table-view']"

    # Private elements
    #
    element(:billing_info_link, {:link => "Billing Info"})
    element(:act_as_link, {:link => "act as"})
    element(:change_name_link, {:link => "Change Name"})
    element(:delete_partner_link, {:link => "Delete Partner"})
    element(:vat_number_input, {:id => "vat_info_vat_number"})
    element(:view_in_aria_link, {:link => "View in Aria"})
    element(:export_to_excel_link, {:link => "Export to Excel (CSV)"})

    # Delete partner hidden forms
    #
    element(:cancellation_submit_btn, {:xpath => "//div[starts-with(@id,'cancellation_reasons_')]//input[@value='Submit']"})
    element(:delete_password_tb, {:xpath => "//div[starts-with(@id,'partner-show-') and contains(@id, '-delete_form')]//input[@name='password']"})
    element(:delete_submit_btn, {:xpath => "//div[starts-with(@id,'partner-show-') and contains(@id, '-delete_form')]//input[@value='Submit']"})

    # Public: Click act as partner link
    #
    # Example
    #   @bus_admin_console_page.partner_details_view.act_as_partner
    #
    # Returns nothing
    def act_as_partner
      act_as_link.click
    end

    # Public: Delete the current partner
    #
    # Example
    #   @bus_admin_console_page.partner_details_view.delete_partner("test1234")
    #
    # Returns nothing
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