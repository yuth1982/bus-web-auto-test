module Bus
  # This class provides actions for add new partner page section
  class AddNewPartnerSection < SiteHelper::Section

    # Private elements
    #
    # Company Info
    #
    element(:new_partner_name_tb, id: "new_partner_name")
    element(:contact_country_select, id: "partner_new_contact_country")
    element(:contact_state_tb, id: "partner_new_contact_state")
    element(:contact_state_us_select, id: "partner_new_contact_state_us")
    element(:contact_state_ca_select, id: "partner_new_contact_state_ca")
    element(:contact_city_tb, id: "contact_city")
    element(:contact_address_tb, id: "contact_address")
    element(:contact_zip_tb, id: "contact_zip")
    element(:contact_phone_tb, id: "contact_phone")
    element(:vat_number_tb, id: "vat_info_vat_number")

    # Admin info
    #
    element(:new_admin_display_name_tb, id: "new_admin_display_name")
    element(:new_admin_username_tb, id: "new_admin_username")

    # Partner Info
    element(:parent_partner_select, id: "parent_partner_id")
    element(:company_type_select, id: "extended_company_type")
    element(:create_under_txt, id: "parent_partner_options")
    element(:coupon_code_tb, id: "coupon_code")

    # Billing Info
    element(:use_company_info_cb, id: "use_company_info")
    element(:cc_address_tb, id: "cc_address")
    element(:cc_country_select, id: "cc_country")
    element(:cc_state_tb, id: "cc_state")
    element(:cc_state_us_select, id: "cc_state_us")
    element(:cc_state_ca_select, id: "cc_state_ca")
    element(:cc_city_tb, id: "cc_city")
    element(:cc_email_tb, id: "cc_email")
    element(:cc_phone_tb, id: "cc_phone")
    element(:cc_zip_tb, id: "cc_zip")

    elements(:period_radios, xpath: "//div[@id='initial_purchase_options']/dt/input")
    elements(:period_labels, xpath: "//div[@id='initial_purchase_options']/dt/label")
    element(:initial_purchase_options, id: "initial_purchase_options")
    element(:include_initial_purchase_cb, id: "include_initial_purchase")
    element(:next_btn, id: "next-button")

    # Order summary
    element(:order_summary_table, xpath: "//div[@id='order-summary']/table")
    elements(:aria_message_div, xpath: "//div[@id='ariaErrors']//li")

    # Credit Card Info
    #
    element(:cc_name_tb, id: "cc_name")
    element(:cc_no_tb, id: "cc_no")
    element(:cvv_tb, id: "cvv")
    element(:cc_exp_mm_select, id: "cc_exp_mm")
    element(:cc_exp_yyyy_select, id: "cc_exp_yyyy")
    element(:net_term_payment, id: "formOfPaymentNT")

    element(:message_div, xpath: "//div[@id='partner-new-errors']/ul")
    element(:create_partner_btn, xpath: "//div[@id='cc-details']//input[@id='submit_button']")
    element(:back_btn, id: "back_button")

    # Public: Add a new partner account
    #
    # Example
    #   @bus_admin_console_page.add_new_partner_section.add_new_account(partner_object)
    #
    # Returns nothing
    def add_new_account(partner)
      fill_company_info(partner.company_info)
      fill_partner_info(partner.partner_info)
      fill_admin_info(partner.admin_info)
      fill_billing_info(partner)

      # define master plan subscription period
      fill_subscription_period(partner.subscription_period)

      if partner.has_initial_purchase
        fill_initial_purchase(partner)
        next_btn.click
        #sleep 10 # wait for fill credit card info
        if partner.net_term_payment
          net_term_payment.click
        else
          fill_credit_card_info(partner.credit_card)
        end
        create_partner_btn.click
      else
        include_initial_purchase_cb.uncheck
        next_btn.click
      end
      #sleep 20 # force wait for create the new partner
    end

    # Public: Messages for change account details actions
    #
    # Example
    #  @bus_admin_console_page.add_new_partner_section.messages
    #  # => "New partner created."
    #
    # Returns success or error message text
    def messages
      message_div.text
    end

    # Public: Add new partner order summary table rows text
    #
    # Example
    #   @bus_admin_console_page.add_new_partner_section.order_summary_table_headers
    #   # => ["Description","Quantity","Price Each","Total Price"]
    #
    # Returns order summary table rows text
    def order_summary_table_headers
      order_summary_table.headers_text
    end

    # Public: Add new partner order summary table rows text
    #
    # Example
    #   @bus_admin_console_page.add_new_partner_section.order_summary_table_rows
    #   # => [["50 GB","1","$19.99","$19.99"],
    #         ["Discounts Applied","","","$-1.00"],
    #         ["Pre-tax Subtotal","","","$18.99"],
    #         ["Total Charges","","","$18.99"]]
    #
    # Returns order summary table rows text
    def order_summary_table_rows
      order_summary_table.rows_text
    end

    # Public: Add new partner subscription period labels text
    #
    # Example
    #   @bus_admin_console_page.add_new_partner_section.available_periods("MozyPro")
    #   # => ["Monthly", "Yearly", "Biennially"]
    #
    # Returns period labels text
    def available_periods(type)
      company_type_select.select(type)
      sleep 10 # force wait to load plans
      period_labels.map{ |ele| ele.text}
    end

    private

    def fill_company_info(company_info)
      new_partner_name_tb.type_text(company_info.name)

      if company_info.country.eql?("United States")
        contact_state_us_select.select(company_info.state_abbrev)
      else
        contact_country_select.select(company_info.country)
        contact_state_tb.type_text(company_info.state)
        vat_number_tb.type_text(company_info.vat_num)
      end
      contact_address_tb.type_text(company_info.address)
      contact_city_tb.type_text(company_info.city)
      contact_zip_tb.type_text(company_info.zip)
      contact_phone_tb.type_text(company_info.phone)
    end

    def fill_partner_info(partner_info)
      company_type_select.select(partner_info.type)
      parent_partner_select.select(partner_info.parent)
      coupon_code_tb.type_text(partner_info.coupon_code) unless partner_info.coupon_code.nil?
      sleep 10 unless partner_info.type.eql?(COMPANY_TYPE[:mozypro]) # wait for load all supp plans
    end

    def fill_admin_info(admin_info)
      new_admin_display_name_tb.type_text(admin_info.full_name)
      new_admin_username_tb.type_text(admin_info.email)
    end

    def fill_billing_info(partner)
      if partner.use_company_info
        use_company_info_cb.check
      end
    end

    def fill_subscription_period(period)
      find_element(:id, "billing_period_#{period}").click
    end

    def fill_initial_purchase(partner)
      case partner.partner_info.type
        when Bus::COMPANY_TYPE[:mozypro]
          fill_mozypro_purchase(partner)
        when Bus::COMPANY_TYPE[:mozyenterprise]
          raise("MozyEnterprise parent partner error") unless create_under_txt.text.eql?("(Creating under MozyEnterprise)")
          fill_mozyenterprise_purchase(partner)
        when Bus::COMPANY_TYPE[:reseller]
          fill_reseller_purchase(partner)
      else
        raise "Unable to find partner type of #{partner.partner_info.type}"
      end
    end

    def fill_mozypro_purchase(partner)
      base_plan_select = find_element(:id, "#{partner.subscription_period}_base_plan_select")
      base_plan_select.select(partner.base_plan)
      base_plan_id = base_plan_select.value
      find_element(:id, "#{base_plan_id}_add_on_plan_check_box").check if partner.has_server_plan
    end

    def fill_mozyenterprise_purchase(partner)
      base_plan_id = find_element(:id, "#{partner.subscription_period}_base_plan", true).value
      # Base plan number of users
      num_user = find_element(:id, "#{partner.subscription_period}_base_plan_#{base_plan_id}")
      num_user.clear_value
      num_user.type_text(partner.num_enterprise_users, true)

      # Server Add ons drop down list
      find_element(:id, "#{base_plan_id}_add_on_plan_select").select(partner.server_plan)
      # Num of server add ons
      server_add_on_id = find_element(:id, "#{base_plan_id}_add_on_plan", true).value

      num_server = find_element(:id, "#{base_plan_id}_add_on_plan_#{server_add_on_id}")
      num_server.clear_value
      num_server.type_text(partner.num_server_add_on, true)
    end

    def fill_reseller_purchase(partner)
      inputs = find_elements(:xpath, "//div[@id='base_plan_section_#{partner.subscription_period}']/div/div/input")
      case partner.reseller_type
        when Bus::RESELLER_TYPE[:silver]
          inputs[0].click # Silver plan
          base_plan_id = inputs[0].value
          inputs[1].type_text(partner.reseller_quota, true) # Silver plan quota
        when Bus::RESELLER_TYPE[:gold]
          inputs[2].click # Gold plan
          base_plan_id = inputs[2].value
          inputs[3].type_text(partner.reseller_quota, true) # Gold plan quota
        when Bus::RESELLER_TYPE[:platinum]
          inputs[4].click # Platinum plan
          base_plan_id = inputs[4].value
          inputs[5].type_text(partner.reseller_quota, true) # Platinum plan quota
        else
          raise "Unable to find reseller type of #{partner.reseller_type}"
      end

      # Add ons server plan
      find_element(:id, "#{base_plan_id}_add_on_plan_check_box").check if partner.has_server_plan
      # Num of server add ons
      server_add_on_id = find_element(:id, "#{base_plan_id}_add_on_plan", true).value

      server_add_on = find_element(:id, "#{base_plan_id}_add_on_plan_#{server_add_on_id}")
      server_add_on.type_text(partner.reseller_add_on_quota, true) if partner.reseller_add_on_quota.to_i > 0
    end

    def fill_credit_card_info(credit_card)
      cc_name_tb.type_text("#{credit_card.first_name} #{credit_card.last_name}")
      cc_no_tb.type_text(credit_card.number)
      cvv_tb.type_text(credit_card.cvv)
      cc_exp_mm_select.select(credit_card.expire_month)
      cc_exp_yyyy_select.select(credit_card.expire_year)
    end
  end
end
