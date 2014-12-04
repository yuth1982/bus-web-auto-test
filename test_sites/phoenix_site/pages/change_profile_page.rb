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
  element(:upgrade_continue_btn, xpath: "//div[@id='maincontent']//input[@name='submit']")
  element(:upgrade_last_continue_btn, xpath: "//div[@id='maincontent']//input[@type='submit']")

  # items in the Payment Details page during change current plan
  elements(:curplan_payment_details_tb, xpath: "//table[@class='subscription_summary']")
  element(:upgrade_submit_btn, xpath: "//input[@id='submit_button']")
  element(:prorated_cost_text, xpath: "//form[@id='update_finish_form']/p/b")

  # my plan page elements
  element(:curplan_summary_tb, xpath: "//div[@id='maincontent']/div/table//td[1]/table")
  element(:renewal_plan_summary_tb, xpath: "//div[@id='maincontent']/div/table//td[2]/table")
  element(:renewal_plan_same_as_div, xpath: "//div[@id='maincontent']//table//td[2]/table//tr[2]//div")

  # during change renewal plan the table of renwal plan summary
  element(:renewal_plan_subscription_tbl, xpath: "//form[@id='update_renewal_form']/table[1]")
  element(:renewal_plan_submit_btn, xpath: "//form[@id='update_renewal_form']//input[@type='submit']")

  # upgrade home free user to paid
  element(:free2paid_country_name, xpath: "//input[@id='user_name']")
  element(:free2paid_country_select, xpath: "//select[@name='user[country]']")
  element(:free2paid_continue_btn, xpath: "//input[@id='conti_button']")

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

  def click_my_plan_link
    find(:xpath, "//ul[@class='side-menu']//a[contains(@href,'plan')]").click if all(:xpath,"//ul[@class='side-menu']//a[contains(@href,'plan')]").size > 0

  end
  #--change plan section
  #--methods here are for changing plan specifics (GB, Adding Machines/Storage, Billing Cycle)
  # change plan - current
  def change_plan_current(partner, new_base_plan, new_additional_storage, new_additional_computers)
    click_my_plan_link
    find(:xpath, "//a[contains(@href,'/plan/edit')]").click
    if !new_base_plan.nil?
      change_plan_select.select("MozyHome #{new_base_plan}") unless new_base_plan.empty?
    end
    fill_addl_quota(new_additional_storage) unless new_additional_storage.nil?
    fill_addl_mach(new_additional_computers) unless new_additional_computers.nil?
    # current plan's billing cycle is fixed
    upgrade_continue_btn.click
    partner.curplan_payment_summary = curplan_payment_details_tb_rows
    upgrade_submit_btn.click
    payment_confirm.present?
    upgrade_last_continue_btn.click
  end

  # change plan - future
  def change_plan_future(new_base_plan, new_additional_storage, total_computers, new_subscription)
    click_my_plan_link
    find(:xpath, "//a[contains(@href,'/plan/edit_renewal')]").click
    if !new_base_plan.nil?
      change_plan_select.select("MozyHome #{new_base_plan}") unless new_base_plan.empty?
    end
    fill_addl_quota(new_additional_storage) unless new_additional_storage.nil?
    fill_addl_mach(total_computers) unless total_computers.nil?
    period_fill_out(new_subscription)
    #upgrade_submit_btn.click
  end

  # click 'Submit' button during renewal plan
  def submit_renewal_plan()
    # get base plan value
    base_plan_value = find(:xpath, "//select[@id='consumer_plan_id']").find('option[selected]').text
    gb_value = find(:xpath, "//select[@id='consumer_plan_id']").value.eql?('104')? '50':'125'
    base_plan = base_plan_value.gsub(/125|50/, gb_value)
    # get Computers value
    computers = find(:xpath, "//select[@id='machines']").value
    # get Subscription value
    subscription_value = find(:xpath, "//select[@id='period']").value
    subscription = find(:xpath, "//select[@id='period']/option[@value='#{subscription_value}']").text
    # get additional storage default value
    addl_storage = find(:xpath, "//input[@id='num_quota_buckets']").value
    array = renewal_plan_subscription_tbl.raw_text
    array[0][1] = base_plan
    array[1][1] = addl_storage + " " + array[1][1]
    array[3][1] = computers
    array[4][1] = subscription
    array.delete_at array.index(["",""]) unless array.index(["",""]).nil?
    renewal_plan_submit_btn.click
    array
  end

  def fill_addl_quota(additional_storage)
    change_quota_tb.clear_value
    if additional_storage.eql?("max")
      change_quota_tb.type_text("99")
    else
      change_quota_tb.type_text(additional_storage)
    end
    find(:xpath, "//td[@id='num_quota_total']").click
  end

  def fill_addl_mach(additional_computers)
    change_machines_select.select(additional_computers)
  end

  def period_fill_out(subscription_period)
    # for other language e.g. FR, the option text is not Monthly, Yearly,Biennial
    change_period_select.find("option[value='#{subscription_period}']").click
     # case subscription_period
      #    when "M"
      #      change_period_select.select("Monthly")
      #    when "Y"
      #      change_period_select.select("Yearly")
      #    when "2"
      #      change_period_select.select("Biennial")
      #  end
 end

  # the Payment Details information during change current plan
  def  curplan_payment_details_tb_rows
    wait_until{curplan_payment_details_tb[0].visible?}
    new_array = Array.new
    curplan_payment_details_tb.each do |table|
      array = table.raw_text
      array.delete_at 0
      new_array = new_array + array
    end
    new_array
  end

  # current plan information in my plan page
  def  curplan_summary_tb_rows
    click_my_plan_link
    wait_until{curplan_summary_tb.visible?}
    array = curplan_summary_tb.raw_text
    array.delete_at 0
    array
  end

  # renewal  plany information in my plan page
  def  renewal_plan_summary_tb_rows
    wait_until{renewal_plan_summary_tb.visible?}
    array = renewal_plan_summary_tb.raw_text
    array.delete_at 0
    array
  end

  def  renewal_plan_same_as_message
    wait_until{renewal_plan_same_as_div.visible?}
    renewal_plan_same_as_div.text
  end

  def get_prorated_cost
    prorated_cost_text.text
  end

  def select_country_free_paid(partner)
    free2paid_country_name.type_text(partner.admin_info.full_name)
    free2paid_country_select.select(partner.company_info.country)
    free2paid_continue_btn.click
  end

  end
end
