module Bus
  class AddNewPartnerView < PageObject

    US = "United States"
    element(:partner_new_form, {:id => "partner_new_form"})
    element(:next_btn, {:id => "next-button"})
    element(:create_partner_btn, {:xpath => "//div[@id='cc-details']//input[@id='submit_button']"})
    element(:partner_created_txt, {:xpath => "//div[@id='partner-new-errors']/ul[@class='flash successes']"})

    # Company Info
    #
    element(:new_partner_name_tb, {:id => "new_partner_name"})
    element(:contact_country_select, {:id => "contact_country"})
    element(:contact_state_tb, {:id => "contact_state"})
    element(:contact_state_us_select, {:id => "contact_state_us"})
    element(:contact_state_ca_select, {:id => "contact_state_ca"})
    element(:contact_city_tb, {:id => "contact_city"})
    element(:contact_address_tb, {:id => "contact_address"})
    element(:contact_zip_tb, {:id => "contact_zip"})
    element(:contact_phone_tb, {:id => "contact_phone"})
    element(:vat_number_tb, {:id => "vat_info_vat_number"})

    # Admin info
    #
    element(:new_admin_display_name_tb, {:id => "new_admin_display_name"})
    element(:new_admin_username_tb, {:id => "new_admin_username"})

    # Partner Info
    element(:parent_partner_select, {:id => "parent_partner_id"})
    element(:company_type_select, {:id => "extended_company_type"})
    element(:coupon_code_tb, {:id => "coupon_code"})

    # Billing Info
    element(:use_company_info_cb, {:id =>"use_company_info"})
    element(:cc_address_tb, {:id => "cc_address"})
    element(:cc_country_select, {:id => "cc_country"})
    element(:cc_state_tb, {:id => "cc_state"})
    element(:cc_state_us_select, {:id => "cc_state_us"})
    element(:cc_state_ca_select, {:id => "cc_state_ca"})
    element(:cc_city_tb, {:id => "cc_city"})
    element(:cc_email_tb, {:id => "cc_email"})
    element(:cc_phone_tb, {:id => "cc_phone"})
    element(:cc_zip_tb, {:id => "cc_zip"})

    element(:include_initial_purchase_cb, {:id =>"include_initial_purchase"})
    element(:server_plan_cb, {:id => "add_on_plan_check_box"})
    element(:mozyenterprise_base_plan_tb, {:id => "base_plan"})
    element(:base_plan_select, {:id => "base_plan_select"})
    #element(:reseller_add_on_quota_hidden, {:id =>"add_on_plan"})
    # Credit Card Info
    #
    element(:cc_name_tb, {:id => "cc_name"})
    element(:cc_no_tb, {:id => "cc_no"})
    element(:cvv_tb, {:id => "cvv"})
    element(:cc_exp_mm_select, {:id => "cc_exp_mm"})
    element(:cc_exp_yyyy_select, {:id => "cc_exp_yyyy"})
    element(:net_term_payment, {:id =>"formOfPaymentNT"})

    element(:back_btn, {:id =>"back_button"})

    # Order summary
    element(:order_summary_tb, {:xpath => "//div[@id='order-summary']/table"})

    def add_new_account(partner)
      partner_new_form.displayed?

      fill_company_info(partner)
      fill_admin_info(partner)
      fill_partner_info(partner)
      fill_billing_info(partner)

      if(partner.has_initial_purchase)
        fill_initial_purchase(partner)
        next_btn.click
        if(partner.net_term_payment)
          net_term_payment.click
        else
          fill_credit_card_info(partner)
        end
        create_partner_btn.click
      else
        include_initial_purchase_cb.uncheck
        next_btn.click
      end
    end

    private

    def fill_company_info(partner)
      new_partner_name_tb.type_text(partner.company_name)
      contact_country_select.select_by(:text,partner.country)

      if(partner.country.eql?(US)) then
        contact_state_us_select.select_by(:text,partner.state_abbrev)
      else
        contact_state_tb.type_text(partner.state)
        vat_number_tb.type_text(partner.vat_num)
      end
      contact_city_tb.type_text(partner.city)
      contact_address_tb.type_text(partner.street_address)
      contact_zip_tb.type_text(partner.zip)
      contact_phone_tb.type_text(partner.phone)
    end

    def fill_partner_info(partner)
      parent_partner_select.select_by(:text,partner.parent_partner)
      company_type_select.select_by(:text,partner.company_type)
      coupon_code_tb.type_text(partner.couple_code) unless partner.couple_code.nil?
      sleep 5
    end

    def fill_admin_info(partner)
      new_admin_display_name_tb.type_text(partner.name)
      new_admin_username_tb.type_text(partner.email)
    end

    def fill_billing_info(partner)
      if partner.use_company_info
        use_company_info_cb.check
      else
        cc_country_select.select_by(:text,partner.country)

        if(partner.country.eql?(US)) then
          cc_state_us_select.select_by(:text,partner.state_abbrev)
        else
          cc_state_tb.type_text(partner.state)
        end

        cc_city_tb.type_text(partner.city)
        cc_address_tb.type_text(partner.street_address)
        cc_email_tb.type_text(partner.email)
        cc_phone_tb.type_text(partner.phone)
        cc_zip_tb.type_text(partner.zip)
      end
    end

    def fill_initial_purchase(partner)
      case partner.company_type
        when Bus::COMPANY_TYPE[:mozypro]
          fill_mozypro_purchase(partner)
        when Bus::COMPANY_TYPE[:mozyenterprise]
          fill_mozyenterprise_purchase(partner)
        when Bus::COMPANY_TYPE[:reseller]
          fill_reseller_purchase(partner)
      end
    end

    def fill_mozypro_purchase(partner)
      driver.find_element(:id => "billing_period_#{partner.subscription_period}").click
      sleep 5 # Wait for loading supp plans
      driver.find_element(:id, "base_plan_select").select_by(:text, partner.supp_plan)
      server_plan_cb.check if partner.has_server_plan
    end

    def fill_mozyenterprise_purchase(partner)
      driver.find_element(:id, "billing_period_#{partner.subscription_period}").click
      sleep 5 # Wait for loading supp plans
      mozyenterprise_base_plan_tb.next_sibling.type_text(partner.num_enterprise_users)
      driver.find_element(:id, "add_on_plan_select").select_by(:text, partner.supp_plan)
    end

    def fill_reseller_purchase(partner)
      driver.find_element(:id, "billing_period_#{partner.subscription_period}").click
      sleep 5 # Wait for loading supp plans
      type_label = driver.find_element(:xpath, "//label[contains(text(), '#{partner.reseller_type}')]")
      # type radio button
      type_label.previous_sibling.previous_sibling.click
      # quota text box
      type_label.previous_sibling.type_text(partner.reseller_quota)
      sleep 5 # Wait for loading add-on
      server_plan_cb.check if partner.has_server_plan
      driver.find_element(:id, "add_on_plan").next_sibling.type_text(partner.reseller_add_on_quota) if partner.reseller_add_on_quota.to_i > 0
    end

    def fill_credit_card_info(partner)
      cc_name_tb.type_text(partner.credit_card_name)
      cc_no_tb.type_text(partner.credit_card_number)
      cvv_tb.type_text(partner.credit_card_cvv)
      cc_exp_mm_select.select_by(:text,partner.credit_card_exp_mm)
      cc_exp_yyyy_select.select_by(:text,partner.credit_card_exp_yyyy)
    end
  end
end

