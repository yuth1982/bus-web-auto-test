module Aria
  class CreateAccountView < PageObject
    # Contact name
    element :first_name_tb, {:id => "in_fname"}
    element :last_name_tb, {:id => "in_lname"}

    # Contact address
    element :street_address_tb, {:id => "in_address1"}
    element :suite_tb, {:id => "in_address2"}
    element :city_tb, {:id => "in_city"}
    element :country_select, {:id => "inCountry2"}
    element :state_select, {:id => "inState2"}
    element :post_code_tb, {:id => "in_zip"}
    element :phone_tb, {:id => "in_phone"}
    element :email_tb, {:id => "email"}
    element :confirm_email_tb, {:id => "email2"}
    element :bill_address_cb, {:id => "sameAddress"}

    # user account info
    element :user_name_tb, {:id => "username1"}
    element :confirm_user_name_tb, {:id => "username2"}
    element :password_tb, {:id => "password1"}
    element :confirm_password_tb, {:id => "password2"}
    element :secret_question_select, {:id => "secretQuestion"}
    element :secret_answer_tb, {:id => "secretAnswer"}

    # Plan info
    element :promo_code_tb, {:id => "newPromoCode"}
    element :plan_select, {:id => "newPlan"}

    # Credit card info
    element :payment_rb, {:id => "formOfPayment_CreditCard"}
    element :credit_card_num_tb, {:id => "cc_number"}
    element :expire_month_select, {:id => "cc_expire_mm"}
    element :expire_year_select, {:id => "cc_expire_yyyy"}
    element :credit_card_cvv_tb, {:id => "cc_CVV"}

    element :submit_btn, {:xpath => "//a[@onclick='formSubmit1();']"}

    def add_new_account(account)
      # Contact name
      first_name_tb.type_text(account.first_name)
      last_name_tb.type_text(account.last_name)

      # Contact address
      fill_contact_address(account)
      bill_address_cb.check if account.same_billing_address

      # user account info
      fill_user_account_info(account)

      # Master plan info
      promo_code_tb.type_text(account.promo_code)
      plan_select.select_by(:value,account.plan_mapping.master_plan_id)

      submit_btn.click

      # Supplemental plans info
      fill_supp_plan(account)

      # Continued
      # Credit card info
      fill_credit_card_info(account)

      submit_btn.click

      sleep 10
    end

    private

    def fill_contact_address(account)
      street_address_tb.type_text(account.street_address)
      suite_tb.type_text(account.suite)
      city_tb.type_text(account.city)
      country_select.select_by(:text, account.country) unless account.country.empty?
      state_select.select_by(:value,account.state_abbrev)
      post_code_tb.type_text(account.zip)
      phone_tb.type_text(account.phone)
      email_tb.type_text(account.email)
      confirm_email_tb.type_text(account.email)
    end

    def fill_user_account_info(account)
      user_name_tb.type_text(account.user_name)
      confirm_user_name_tb.type_text(account.user_name)
      password_tb.type_text(account.password)
      confirm_password_tb.type_text(account.password)
      secret_question_select.select_by(:value,account.secret_question)
      secret_answer_tb.type_text(account.secret_answer)
    end

    def fill_supp_plan(account)
      supp_plan_desk_lic_cb = CheckBox.new(driver.find_element(:xpath, "//input[@value='#{account.plan_mapping.desk_licence_id}']"))
      supp_plan_desk_lic_cb.check
      supp_plan_desk_lic_tb = TextField.new(driver.find_element(:id, supp_plan_desk_lic_cb.id.gsub("suppPlan","suppPlanUnits")))
      supp_plan_desk_lic_tb.type_text account.desktop_lic_num

      supp_plan_server_lic_cb = CheckBox.new(driver.find_element(:xpath, "//input[@value='#{account.plan_mapping.server_licence_id}']"))
      supp_plan_server_lic_cb.check
      supp_plan_server_lic_tb = TextField.new(driver.find_element(:id, supp_plan_server_lic_cb.id.gsub("suppPlan","suppPlanUnits")))
      supp_plan_server_lic_tb.type_text account.server_lic_num

      supp_plan_desk_quota_cb = CheckBox.new(driver.find_element(:xpath, "//input[@value='#{account.plan_mapping.desk_quota_id}']"))
      supp_plan_desk_quota_cb.check
      supp_plan_desk_quota_tb = TextField.new(driver.find_element(:id, supp_plan_desk_quota_cb.id.gsub("suppPlan","suppPlanUnits")))
      supp_plan_desk_quota_tb.type_text account.desktop_quota_num

      supp_plan_server_quota_cb = CheckBox.new(driver.find_element(:xpath, "//input[@value='#{account.plan_mapping.server_quota_id}']"))
      supp_plan_server_quota_cb.check
      supp_plan_server_quota_tb = TextField.new(driver.find_element(:id, supp_plan_server_quota_cb.id.gsub("suppPlan","suppPlanUnits")))
      supp_plan_server_quota_tb.type_text account.server_quota_num
    end

    def fill_credit_card_info(account)
      payment_rb.click
      credit_card_num_tb.type_text(account.credit_card_number)
      expire_month_select.select_by(:value,account.credit_card_exp_mm)
      expire_year_select.select_by(:value,account.credit_card_exp_yyyy)
      credit_card_cvv_tb.type_text(account.cvv)
    end
  end
end