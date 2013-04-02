
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
