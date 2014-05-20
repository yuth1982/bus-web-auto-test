module Phoenix
  class ChangeProfilePage < SiteHelper::Page

  # editing profile section
  # items relating to editing a user's profile
  element(:message_text, css: "p.notice")
  element(:message_profile, css: "p.flash")
  # change user name
  element(:user_name_tb, id: "user_name")
  # change password section
  element(:old_pw, id: "old_password")
  element(:new_pw, id: "new_password")
  element(:new_pw2, id: "new_password2")
  element(:change_btn, css: "input.ui-button")
  # change cc info
  element(:change_cc_type_select, id: "card_cardType")
  element(:change_cc_number_tb, id: "card_accountNumber")
  element(:change_card_cvv_tb, id: "card_cvNumber")
  element(:change_exp_mm_select, id: "card_expirationMonth")
  element(:change_exp_yy_select, id: "card_expirationYear")
  # cc addressing info
  element(:change_billing_country_select, id: "billTo_country")
  element(:change_bill_fname_tb, id: "billTo_firstName")
  element(:change_bill_lname_tb, id: "billTo_lastName")
  element(:change_bill_co_tb, id: "billTo_company")
  element(:change_bill_addr1_tb, id: "billTo_street1")
  element(:change_bill_addr2_tb, id: "billTo_street2")
  element(:change_bill_city_tb, id: "billTo_city")
  element(:change_bill_state_tb, id: "billTo_state")
  element(:change_bill_state_select, id: "billTo_state_us")
  element(:change_bill_zip_tb, id: "billTo_postalCode")
  element(:change_submit_btn, id: "submit_button")
  element(:captcha, id: "captcha")

  # items relating to changing the account
  element(:change_plan_select, id: "consumer_plan_id")
  element(:change_quota_tb, id: "num_quota_buckets")
  element(:change_machines_select, id: "machines")
  element(:change_period_select, id: "period")
  element(:payment_confirm, css: "div.inner-center-form-box > p")
  element(:upgrade_continue_btn, css: "input.ui-button[Value=Continue]")
  element(:upgrade_submit_btn, css: "input.ui-button[Value=Submit]")

  #--change credit card information section--
  # calls the whole process
  def change_cc(partner)
    change_cc_link
    change_cc_entry(partner)
  end

  # change cc link click
  def change_cc_link
    find(:xpath, "//a[contains(@href,'/account/change_credit_card')]").click
  end

  # change cc info script
  def change_cc_entry(partner)
    # card info entry
    change_cc_type_select.select(partner.credit_card.type)
    change_cc_number_tb.type_text(partner.credit_card.number)
    change_card_cvv_tb.type_text(partner.credit_card.cvv)
    change_exp_mm_select.select(partner.credit_card.expire_month)
    change_exp_yy_select.select(partner.credit_card.expire_year)

    # biller info entry
    change_billing_country_select.select(partner.company_info.country)
    change_bill_fname_tb.type_text(partner.admin_info.first_name)
    change_bill_lname_tb.type_text(partner.admin_info.last_name)
    change_bill_addr1_tb.type_text(partner.company_info.address)
    change_bill_city_tb.type_text(partner.company_info.city)
    state_entry(partner)
    change_bill_zip_tb.type_text(partner.company_info.zip)

    # submission
    captcha.type_text(CONFIGS['phoenix']['captcha'])
    change_submit_btn.click
    message_text.eql?("Your card has been successfully filed. All future payments will be charged to your #{partner.credit_card.type} ending in #{partner.credit_card.last_four_digits}.")
  end

  def state_entry(partner)
    if partner.company_info.country == "United States"
      change_bill_state_select.type_text(partner.company_info.state_abbrev)
    else
      change_bill_state_tb.type_text(partner.company_info.state)
    end
  end



  #--change password section--
  # calls the whole process
  def change_password
    change_pw_link
    change_pw_entry
  end

  # change password link click
  def change_pw_link
    find(:xpath, "//a[contains(@href,'/account/password')]").click
  end

  # change password script
  def change_pw_entry
    old_pw.type_text(CONFIGS['global']['test_pwd'])
    new_pw.type_text(QA_ENV['bus_password'])
    new_pw2.type_text(QA_ENV['bus_password'])
    change_btn.click
    message_text.eql?("Your password was changed.")
  end

  # changing user profile addressing data
  def change_user_name(partner)
    user_name_tb.type_text(partner.admin_info.full_name)
    change_btn.click
    message_profile.eql?("Profile saved")
  end

  #--change plan section
  #--methods here are for changing plan specifics (GB, Adding Machines/Storage, Billing Cycle)
  # change plan - current
  def change_plan_current(partner)
    find(:xpath, "//a[contains(@href,'/plan/edit')]").click
    change_plan_select.select("MozyHome #{partner.base_plan}")
    fill_addl_quota(partner)
    fill_addl_mach(partner)
    # current plan's billing cycle is fixed
    upgrade_continue_btn.click
    upgrade_submit_btn.click
    payment_confirm.present?
    upgrade_continue_btn.click
  end

  # change plan - future
  def change_plan_future(partner)
    find(:xpath, "//a[contains(@href,'/plan/edit_renewal')]").click
    change_plan_select.select("MozyHome #{partner.base_plan}")
    fill_addl_quota(partner)
    fill_addl_mach(partner)
    period_fill_out(partner)
    upgrade_submit_btn.click
  end

  def fill_addl_quota(partner)
    if partner.additional_storage.eql?("max")
      change_quota_tb.type_text("99")
    else
      change_quota_tb.type_text(partner.additional_storage)
    end
  end

  def fill_addl_mach(partner)
    change_machines_select.select(partner.additional_computers)
  end

  def period_fill_out(partner)
    case partner.subscription_period
      when "M"
        change_period_select.select("Monthly")
      when "Y"
        change_period_select.select("Yearly")
      when "2"
        change_period_select.select("Biennial")
    end
  end

  end
end
