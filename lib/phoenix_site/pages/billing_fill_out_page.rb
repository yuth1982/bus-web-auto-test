module Phoenix
  class NewPartnerBillingFillout < SiteHelper::Page

    set_url("#{PHX_ENV['phx_host']}")
  
    # Private elements
    #
    # Credit Card Info
    #
    element(:cc_type_select, id: "cc_type")
    element(:cc_no_tb, id: "cc_no")
    element(:cvv_tb, id: "cvv")
    element(:cc_exp_mm_select, id: "cc_exp_mm")
    element(:cc_exp_yyyy_select, id: "cc_exp_yyyy")
    element(:cc_first_name_tb, id: "cc_first_name")
    element(:cc_last_name_tb, id: "cc_last_name")
    element(:cc_company_tb, id: "cc_company")
    #
    # Billing Info
    #
    element(:same_as_company_info_link, id: "insert_partner_contact")
    element(:cc_address_tb, id: "cc_address")
    element(:cc_country_select, id: "cc_country")
    element(:cc_state_tb, id: "cc_state")
    element(:cc_state_us_select, id: "cc_state_us")
    element(:cc_state_ca_select, id: "cc_state_ca")
    element(:cc_city_tb, id: "cc_city")
    element(:cc_email_tb, id: "cc_email")
    element(:cc_phone_tb, id: "cc_phone")
    element(:cc_zip_tb, id: "cc_zip")
    element(:billing_summary_table , css: "table.order-summary")
    #
    # Various elements
    #
    element(:next_btn, id: "next-button")
    element(:continue_btn, css: "input.img-button")
    element(:back_btn, id: "back_button")
    element(:submit_btn, id: "submit_button")
    #
    # Public: Phoenix new partner billing summary table headers
    #
    # Example
    #   billing_fill_out.billing_summary_table_headers
    #   # => ["Description","Quantity","Price Each","Total Price"]
    #
    # Returns order summary table rows text
    def billing_summary_table_headers
      billing_summary_table.headers_text
    end

    # Public: Phoenix new partner billing summary table rows
    #
    # Example
    #   billing_fill_out.billing_summary_table_rows
    #   # => [["50 GB","1","$19.99","$19.99"],
    #         ["Discounts Applied","","","$-1.00"],
    #         ["Pre-tax Subtotal","","","$18.99"],
    #         ["Total Charges","","","$18.99"]]
    #
    # Returns order summary table rows text
    def billing_summary_table_rows
      billing_summary_table.rows_text
    end
  def billing_info_fill_out(partner)
    # card info
    cc_no_tb.type_text(partner.credit_card.number)
    cvv_tb.type_text(partner.credit_card.cvv)
    cc_exp_mm_select.select(partner.credit_card.expire_month)
    cc_exp_yyyy_select.select(partner.credit_card.expire_year)
    # payee info
    cc_first_name_tb.type_text(partner.credit_card.first_name)
    cc_last_name_tb.type_text(partner.credit_card.last_name)
    cc_company_tb.type_text(partner.company_info.name )
    # billing company info
    same_as_company_info_link.click
    # get billing summary info as a hash , for verifications later
    #     headers = 'css=th.' (desc, price, quantity, amount)
    #     rows = 'css=td.desc.' (base_product, add_on_product, sub_price, discount, total)
    billing_summary_table_headers
    billing_summary_table_rows
    # submission
    submit_btn.click
  end
  end
end