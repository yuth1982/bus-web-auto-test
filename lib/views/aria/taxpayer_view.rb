module Aria
  class TaxpayerView < PageObject
    element(:taxpayer_id_dd, {:xpath => "//form/fieldset/dl/dd[1]"})
    element(:tax_exempt_status_dd, {:xpath => "//form/fieldset/dl/dd[2]"})
    element(:edit_tax_exempt_btn, {:xpath =>"//input[@value='Edit Fields']"})
    element(:save_tax_exempt_btn, {:xpath =>"//input[@value='Save Changes']"})

    element(:federal_tax_exempt_cb, {:xpath =>"//input[@name='inFederalTaxExempt']"})
    element(:state_tax_exempt_cb, {:xpath =>"//input[@name='inStateProvTaxExempt']"})

    def set_federal_exempt_taxes(status)
      edit_tax_exempt_btn.click
      federal_tax_exempt_cb.uncheck unless status
      save_tax_exempt_btn.click
    end

    def set_state_exempt_taxes(status)
      edit_tax_exempt_btn.click
      state_tax_exempt_cb.uncheck unless status
      save_tax_exempt_btn.click
    end
  end
end

