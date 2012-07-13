module Bus
  class AddNewPartnerView < PageObject

    US = "United States"
    element(:next_btn, {:id => "next-button"})
    element(:create_partner_btn, {:xpath => "//div[@id='cc-details']//input[@id='submit_button']"})
    element(:partner_created_txt, {:xpath => "//div[@id='partner-new-errors']/ul[@class='flash successes']"})

    # Company Info
    #
    element(:new_partner_name_tb, {:id => "new_partner_name"})
    element(:contact_country_select, {:id => "partner_new_contact_country"})
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
    element(:order_summary_table, {:xpath => "//div[@id='order-summary']/table"})

    elements(:aria_errors_li, {:xpath => "//div[@id='ariaErrors']//li"})

    def add_new_account(partner)
      #puts partner.to_s if Bus::DEBUG
      fill_company_info(partner)
      fill_admin_info(partner)
      fill_partner_info(partner)
      fill_billing_info(partner)

      # define master plan subscription period
      fill_subscription_period(partner.subscription_period)

      if partner.has_initial_purchase
        fill_initial_purchase(partner)
        next_btn.click
        sleep 5
        if partner.net_term_payment
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

    def partner_created_msg
      begin
        partner_created_txt.text
      rescue
        err_msg = aria_errors_li.map { |cell| cell.text }
        create_partner_rescue(err_msg, 1)
        begin
          partner_created_txt.text
        rescue
          aria_errors_li.map { |cell| cell.text }
        end
      end
    end

    private

    def fill_company_info(partner)
      new_partner_name_tb.type_text(partner.company_name)
      contact_country_select.select_by(:text,partner.country)

      if partner.country.eql?(US)
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
      sleep 10 # wait for load all supp plans
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

        if partner.country.eql?(US)
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

    def fill_subscription_period(period)
      driver.find_element(:id => "billing_period_#{period}").click
    end

    def fill_initial_purchase(partner)
      case partner.company_type
        when Bus::COMPANY_TYPE[:mozypro]
          fill_mozypro_purchase(partner)
        when Bus::COMPANY_TYPE[:mozyenterprise]
          fill_mozyenterprise_purchase(partner)
        when Bus::COMPANY_TYPE[:reseller]
          fill_reseller_purchase(partner)
      else
        raise "Unable to find partner type of #{partner.company_type}"
      end
    end

    def fill_mozypro_purchase(partner)
      base_plan_select = driver.find_element(:id => "#{partner.subscription_period}_base_plan_select")
      base_plan_select.select_by(:text, partner.supp_plan)
      base_plan_id = base_plan_select.first_selected_option.value
      driver.find_element(:id => "#{base_plan_id}_add_on_plan_check_box").check if partner.has_server_plan
    end

    def fill_mozyenterprise_purchase(partner)
      base_plan_locator = driver.find_element(:id, "#{partner.subscription_period}_base_plan")
      base_plan_id = base_plan_locator.value
      # Base plan number of users
      driver.find_element(:id, "#{partner.subscription_period}_base_plan_#{base_plan_id}").type_text(partner.num_enterprise_users)
      # Add ons drop down list
      driver.find_element(:id, "#{base_plan_id}_add_on_plan_select").select_by(:text, partner.supp_plan)
      # Num of server add ons
      server_add_on_locator = driver.find_element(:id, "#{base_plan_id}_add_on_plan")
      server_add_on_id = server_add_on_locator.value
      driver.find_element(:id, "#{base_plan_id}_add_on_plan_#{server_add_on_id}").type_text(partner.num_server_add_on)
    end

    def fill_reseller_purchase(partner)
      inputs = driver.find_elements(:xpath, "//div[@id='base_plan_section_#{partner.subscription_period}']/div/div/input")
      base_plan_id = ""
      case partner.reseller_type
        when Bus::RESELLER_TYPE[:silver]
          inputs[0].click # Silver plan
          base_plan_id = inputs[0].value
          inputs[1].type_text(partner.reseller_quota) # Silver plan quota
        when Bus::RESELLER_TYPE[:gold]
          inputs[2].click # Gold plan
          base_plan_id = inputs[2].value
          inputs[3].type_text(partner.reseller_quota) # Gold plan quota
        when Bus::RESELLER_TYPE[:platinum]
          inputs[4].click # Platinum plan
          base_plan_id = inputs[4].value
          inputs[5].type_text(partner.reseller_quota) # Platinum plan quota
        else
          raise "Unable to find reseller type of #{partner.reseller_type}"
      end

      # Add ons server plan
      driver.find_element(:id, "#{base_plan_id}_add_on_plan_check_box").check if partner.has_server_plan
      # Num of server add ons
      server_add_on_locator = driver.find_element(:id, "#{base_plan_id}_add_on_plan")
      server_add_on_id = server_add_on_locator.value
      driver.find_element(:id, "#{base_plan_id}_add_on_plan_#{server_add_on_id}").type_text(partner.reseller_add_on_quota) if partner.reseller_add_on_quota.to_i > 0
    end

    def fill_credit_card_info(partner)
      cc_name_tb.type_text(partner.credit_card_name)
      cc_no_tb.type_text(partner.credit_card_number)
      cvv_tb.type_text(partner.credit_card_cvv)
      cc_exp_mm_select.select_by(:text,partner.credit_card_exp_mm)
      cc_exp_yyyy_select.select_by(:text,partner.credit_card_exp_yyyy)
    end

    def create_partner_rescue(err_msg, times)
      while times > 0
        if err_msg.include?("Could not validate payment information.")
          puts "Known error occurred, try create partner rescue #{times}"
          create_partner_btn.click
          sleep 5
        end
        times -= 1
      end
    end
  end
end

