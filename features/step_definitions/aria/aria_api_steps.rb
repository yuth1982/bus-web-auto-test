
When /^API\* I get Aria account details by (.+)$/ do |aria_id|
  @aria_acc_details = AriaApi.get_acct_details_all({:acct_no=> aria_id})
end

Then /^API\* Aria account billing info should be:$/ do |info_table|
  expected = info_table.hashes.first
  expected.keys.each do |header|
    case header
      when 'contact name'
        "#{@aria_acc_details['billing_first_name']} #{@aria_acc_details['billing_last_name']}".should == expected[header]
      when 'company name'
        @aria_acc_details['billing_company_name'].should == expected[header]
      when 'address'
        @aria_acc_details['billing_address1'].should == expected[header]
      when 'city'
        @aria_acc_details['billing_city'].should == expected[header]
      when 'country'
        @aria_acc_details['billing_country'].should == expected[header]
      when 'state'
        @aria_acc_details['billing_state'].should == expected[header]
      when 'zip'
        @aria_acc_details['billing_zip'].should == expected[header]
      when 'phone'
        @aria_acc_details['billing_intl_phone'].should == expected[header]
      when 'email'
        @aria_acc_details['billing_email'].should == expected[header]
      else
        raise 'Unknown billing information'
    end
  end
end

Then /^API\* Aria account credit card info should be:$/ do |info_table|
  expected = info_table.hashes.first
  expected.keys.each do |header|
    case header
      when 'payment type'
        @aria_acc_details['pay_method_name'].should == expected[header]
      when 'last four digits'
        @aria_acc_details['cc_suffix'].should == expected[header]
      when 'expire month'
        @aria_acc_details['cc_expire_mm'].should == expected[header]
      when 'expire year'
        @aria_acc_details['cc_expire_yyyy'].should == expected[header]
      else
        raise 'Unknown credit card information'
    end
  end
end

#This is a universal Aria API Checker
Then /API\* Aria account should be:/ do |info_table|
  step "API* I get Aria account details by newly created partner aria id"
  expected = info_table.hashes.first
  expected.keys.each do |header|
    #Log.debug("Aria API Check, Key = #{header}: Expected = \"#{expected[header]}\", Aria = \"#{ @aria_acc_details[header]}\"")
    if @aria_acc_details.has_key?(header)
      expected[header] = nil if expected[header] == "" || expected[header] == "nil"
      @aria_acc_details[header].should == expected[header]
    else
      raise "Unknown Aria Key: \"#{header}\""
    end
  end

  #List of Aria API Keys - So you can check anything
  # "first_name", "mi", "last_name", "userid", "birthdate", "job_title", "salutation",
  # "senior_acct_no", "client_acct_id", "resp_level_cd", "is_test_acct", "alt_email",
  # "address1", "address2", "city", "state_prov", "locality", "postal_code", "country",
  # "company_name", "cell_phone_npa", "cell_phone_nxx", "cell_phone_suffix", "fax_phone",
  # "intl_cell_phone", "intl_phone", "phone_extension", "phone_npa", "phone_nxx", "phone_suffix",
  # "work_phone", "work_phone_extension", "work_phone_npa", "work_phone_nxx", "work_phone_suffix",
  # "bill_day", "created", "date_to_expire", "date_to_suspend", "last_arrears_bill_thru_date",
  # "last_bill_date", "last_bill_thru_date", "next_bill_date", "plan_date", "status_date",
  # "status_degrade_date", "status_cd", "status_label", "plan_no", "plan_name", "plan_units",
  # "notify_method", "notify_method_name", "PASSWORD", "pin", "secret_question",
  # "secret_question_answer", "pay_method", "pay_method_name", "currency_cd", "tax_id",
  # "billing_email", "billing_first_name", "billing_middle_initial", "billing_last_name",
  # "billing_address1", "billing_address2", "billing_city", "billing_state", "billing_locality",
  # "billing_zip", "billing_country", "cc_suffix", "cc_expire_mm", "cc_expire_yyyy", "cc_id",
  # "bank_acct_suffix", "bank_routing_no", "billing_cell_phone", "billing_cell_phone_npa",
  # "billing_cell_phone_nxx", "billing_cell_phone_suffix", "billing_company_name",
  # "billing_intl_phone", "billing_phone_extension", "billing_phone_npa", "billing_phone_nxx",
  # "billing_phone_suffix", "billing_work_phone", "billing_work_phone_extension",
  # "billing_work_phone_npa", "billing_work_phone_nxx", "billing_work_phone_suffix", "balance",
  # "acct_create_client_receipt_id", "plan_client_receipt_id", "status_client_receipt_id",
  # "taxpayer_id", "promo_cd", "error_code", "alt_msg_template_no", "address3", "billing_address3",
  # "seq_func_group_no", "address_verification_code", "address_match_score",
  # "billing_address_verification_code", "billing_address_match_score", "error_msg",
end



