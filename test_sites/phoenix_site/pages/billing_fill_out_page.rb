module Phoenix
  class NewPartnerBillingFillout < SiteHelper::Page

    set_url("https://#{QA_ENV['phoenix_host']}")

    # Private elements
    #
    # Credit Card Info
    # pro flow
    element(:cc_type_select, id: "cc_type")
    element(:cc_no_tb, id: "cc_no")
    element(:cvv_tb, id: "cvv")
    element(:cc_exp_mm_select, id: "cc_exp_mm")
    element(:cc_exp_yyyy_select, id: "cc_exp_yyyy")
    element(:cc_first_name_tb, id: "cc_first_name")
    element(:cc_last_name_tb, id: "cc_last_name")
    element(:cc_company_tb, id: "cc_company")
    # home flow
    element(:home_cc_type_select, id: "card_type")
    element(:home_cc_acct_num_tb, id: "card_number")
    element(:home_cc_cvv_tb, id: "card_cvn")
    element(:home_cc_exp_mm_select, id: "card_expiry_month")
    element(:home_cc_exp_yy_select, id: "card_expiry_year")
    #
    # Billing Info
    # pro flow
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
    element(:billing_summary_table, css: "table.order-summary")
    element(:use_company_info_label, id: 'insert_partner_contact')
    # home flow
    element(:home_country_select, id: "bill_to_address_country")
    element(:home_bill_fname_tb, id: "bill_to_forename")
    element(:home_bill_lname_tb, id: "bill_to_surname")
    element(:home_bill_company_tb, id: "bill_to_company_name")
    element(:home_bill_addr1_tb, id: "bill_to_address_line1")
    element(:home_bill_city_tb, id: "bill_to_address_city")
    element(:home_bill_state_tb, id: "bill_to_address_state")
    element(:home_bill_state_select, id: "bill_to_address_state_us")
    element(:home_bill_post_tb, id: "bill_to_address_postal_code")
    element(:home_bill_phone_tb, id: "bill_to_phone")
    element(:home_bill_email_tb, id: "bill_to_email_display")
    #
    # Various elements
    #
    element(:captcha, id: "captcha")
    element(:next_btn, id: "next-button")
    element(:continue_btn, css: "input.img-button")
    element(:back_btn, id: "back_button")
    element(:submit_btn, id: "submit_button")

    # Public elements & methods
    #

    # calls method that checks for existence of billing summary table
    #   and then get data from the table
    #
    #   get billing summary info as a hash , for verifications later
    #     headers = 'css=th.' (desc, price, quantity, amount)
    #     rows = 'css=td.desc.' (base_product, add_on_product, sub_price, discount, total)
    def billing_summary_info_get(partner)
      wait_until {billing_summary_table.visible?}
      partner.order_summary = billing_summary_table.rows_text.map{ |row| Hash[billing_summary_table.headers_text.zip(row)] }
    end

    #   pro: filling in cc payment fields + click 'same as' link
    #     clicking link populates company data for payee
    #
    def pro_fill_out(partner)
      # for pro, mainly the cc info - then click 'same as' link
      # card info
      cc_no_tb.type_text(partner.credit_card.number)
      cvv_tb.type_text(partner.credit_card.cvv)
      cc_exp_mm_select.select(partner.credit_card.expire_month)
      cc_exp_yyyy_select.select(partner.credit_card.expire_year)
      # payee info
      cc_first_name_tb.type_text(partner.credit_card.first_name)
      cc_last_name_tb.type_text(partner.credit_card.last_name)
      if partner.use_company_info
        cc_company_tb.type_text(partner.company_info.name)
        use_company_info_label.check
      else
        cc_company_tb.type_text(partner.billing_info.company_name)
        cc_country_select.select(partner.billing_info.country)
        cc_address_tb.type_text(partner.billing_info.address)
        cc_city_tb.type_text(partner.billing_info.city)
        if partner.billing_info.country.eql?("United States")
          cc_state_us_select.select(partner.billing_info.state_abbrev)
        elsif partner.billing_info.country.eql?('Canada')
          cc_state_ca_select.select(partner.billing_info.state_abbrev)
        else
          cc_state_tb.type_text(partner.billing_info.state)
        end
        cc_zip_tb.type_text(partner.billing_info.zip)
        cc_phone_tb.type_text(partner.billing_info.phone)
      end
      cc_email_tb.eql?(partner.admin_info.email)
      #captch
      captcha.type_text(CONFIGS['phoenix']['captcha'])
      # billing company info
      same_as_company_info_link.click
    end

    #   home : filling all available fields
    #     if country not = US, fill in state / prov field, else select US state
    #
    def home_fill_out(partner)
      # for mozy home, we have to fill the entire form out
      home_cc_acct_num_tb.type_text(partner.credit_card.number)
      home_cc_cvv_tb.type_text(partner.credit_card.cvv)
      home_cc_exp_mm_select.select(partner.credit_card.expire_month)
      home_cc_exp_yy_select.select(partner.credit_card.expire_year)
      home_bill_fname_tb.type_text(partner.credit_card.first_name)
      home_bill_lname_tb.type_text(partner.credit_card.last_name)
      if partner.use_company_info
        home_bill_company_tb.type_text(partner.company_info.name)
        home_country_select.select(partner.company_info.country)
        home_bill_addr1_tb.type_text(partner.company_info.address)
        home_bill_city_tb.type_text(partner.company_info.city)
        if partner.company_info.country.eql?("United States")
          home_bill_state_select.select(partner.company_info.state_abbrev)
        else
          home_bill_state_tb.type_text(partner.company_info.state)
        end
        home_bill_post_tb.type_text(partner.company_info.zip)
        home_bill_phone_tb.type_text(partner.company_info.phone)
      else
        home_bill_company_tb.type_text(partner.billing_info.company_name)
        home_country_select.select(partner.billing_info.country)
        home_bill_addr1_tb.type_text(partner.billing_info.address)
        home_bill_city_tb.type_text(partner.billing_info.city)
        if partner.billing_info.country.eql?("United States")
          home_bill_state_select.select(partner.billing_info.state_abbrev)
        else
          home_bill_state_tb.type_text(partner.billing_info.state)
        end
        home_bill_post_tb.type_text(partner.billing_info.zip)
        home_bill_phone_tb.type_text(partner.billing_info.phone)
      end
      home_bill_email_tb.eql?(partner.admin_info.email)
      #captch
      captcha.type_text(CONFIGS['phoenix']['captcha'])
    end

    def localized_country(loc_select, partner)
      # jason: we may just be able to render the old case statement like this,
      # ((partner.company_info.country == "Germany") ? loc_select.select("Deutschland") : loc_select.select(partner.company_info.country))
      case partner.company_info.country
        when 'Germany'
          loc_select.select("Deutschland")
        else
          loc_select.select(partner.company_info.country)
      end
    end

    # code for the billing / payment page
    #
    def billing_info_fill_out(partner)
      billing_summary_info_get(partner)
      # code for filling in billing / cc payment info
      #   based on home or pro type of acct
      #
      if partner.partner_info.type.eql?("MozyPro")
        pro_fill_out(partner)
      else
        home_fill_out(partner)
      end
      # submission
      submit_btn.click
    end

    def pro_billing_country
      cc_country_select.value
    end

    def home_billing_country
      home_country_select.value
    end
  end
end
