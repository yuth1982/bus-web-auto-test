module Bus
  # This class provides actions for partner invoice page
  class PartnerInvoicePage < SiteHelper::Page

    element(:billing_detail_table, xpath: "//div[@id='content']/table[4]")
    element(:partner_details_td, xpath: "//div[@id='content']/table[3]/tbody/tr/td[1]")

    def partner_info
      partner_details_td.text
    end

    def billing_detail_table_rows
      billing_detail_table.rows_text
    end

  end
end