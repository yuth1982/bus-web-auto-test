And /^I (upgrade|change) my (partner|user|free) account to:$/ do |change_type,acct_type, upgrade_table|
  # There were two Home signups, (When I add ...)(When I sign up...) The string combines them
  #(partner | user) is keep all tests cases working from when Home and Pro where separate
  attributes = upgrade_table.hashes.first
  case change_type
    # for upgrading an account - ie .. going from free to paid
    when "upgrade"
     case acct_type
      when "free"
        # general info for upgrading user acct to diff values
        @partner.base_plan = attributes["base plan"] || ""
        @partner.has_stash = (attributes["has stash"] || "no").eql?("yes")
        @partner.additional_computers = attributes['addl computers'] unless attributes['addl computers'].nil?
        @partner.additional_storage = attributes['addl storage'] unless attributes['addl storage'].nil?
        # Partner info attributes
        @partner.partner_info.coupon_code = attributes["coupon"] unless attributes["coupon"].nil?

        # subscription period

        @partner.subscription_period = attributes["period"]
        case
          when attributes["period"].eql?("1")
            @partner.subscription_period = "M"
          when attributes["period"].eql?("12")
            @partner.subscription_period = "Y"
          when attributes["period"].eql?("24")
            @partner.subscription_period = "2"
        end

        # Billing info attributes
        @partner.use_company_info = attributes['billing country'].nil?
        unless @partner.use_company_info
          @partner.billing_info.country = attributes["billing country"] unless attributes['billing country'].nil?
          @partner.billing_info.state = attributes["billing state"] unless attributes['billing state'].nil?
          @partner.billing_info.state_abbrev = attributes['billing state abbrev'] unless attributes['billing state abbrev'].nil?
          @partner.billing_info.company_name = attributes["billing company name"] unless attributes['billing company name'].nil?
          @partner.billing_info.address = attributes['billing address'] unless attributes['billing address'].nil?
          @partner.billing_info.city = attributes['billing city'] unless attributes['billing city'].nil?
          @partner.billing_info.zip = attributes['billing zip'] unless attributes['billing zip'].nil?
          @partner.billing_info.phone = attributes['billing phone'] unless attributes['billing phone'].nil?
        end

        find(:xpath, "//a[contains(@href,'/account/upgrade_to_paid')]").click
        @phoenix_site.update_profile.select_country_free_paid(@partner)
        @phoenix_site.licensing_fill_out.licensing_billing_fillout(@partner)
        @phoenix_site.billing_fill_out.billing_info_fill_out(@partner)
        #@phoenix_site.reg_complete_pg.upgrade_success(@partner)
        #@phoenix_site.user_account.localized_click(@partner, 'my_account')
      when "partner"

        # general info for upgrading acct from home to pro

      when "user"
        #@partner.base_plan = attributes["base plan"] || ""
        #@partner.has_stash = (attributes["has stash"] || "no").eql?("yes")
        #@partner.additional_computers = attributes['addl computers'] unless attributes['addl computers'].nil?
        #@partner.additional_storage = attributes['addl storage'] unless attributes['addl storage'].nil?

        new_base_plan =  attributes["base plan"] || ""
        new_additional_computers = attributes['addl computers'] unless attributes['addl computers'].nil?
        new_additional_storage = attributes['addl storage'] unless attributes['addl storage'].nil?
        # general info relevant to upgrading a current home user acct
        # @phoenix_site.user_account.go_to_plan(@partner)
        #find(:xpath, "//a[@href='/plan/edit']").click
        #@phoenix_site.update_profile.change_plan_current(@partner)
        @phoenix_site.update_profile.change_plan_current(@partner, new_base_plan, new_additional_storage, new_additional_computers)
        #step %{I logout of my user account}
     # for changing the current account - ie .. going from monthly to biennial billing
    end
   when "change"
      case acct_type
        when "user"
          #@partner.base_plan = attributes["base plan"] || "" unless attributes['base plan'].nil?
          #@partner.additional_computers = attributes['addl computers'] unless attributes['addl computers'].nil?
          #@partner.additional_storage = attributes['addl storage'] unless attributes['addl storage'].nil?
          new_base_plan =  attributes["base plan"] || ""
          total_computers = attributes['computers'] unless attributes['computers'].nil?
          new_additional_storage = attributes['addl storage'] unless attributes['addl storage'].nil?
          new_subscription_period = attributes['period'] unless attributes['period'].nil?
          case
            when attributes["period"].eql?("1")
              new_subscription_period = "M"
            when attributes["period"].eql?("12")
              new_subscription_period = "Y"
            when attributes["period"].eql?("24")
              new_subscription_period = "2"
          end
          @phoenix_site.user_account.go_to_plan(@partner)
          #find(:xpath, "//a[contains(@href,'/plan/edit_renewal')]").click
          #@phoenix_site.update_profile.change_plan_future(@partner)
          @phoenix_site.update_profile.change_plan_future(new_base_plan, new_additional_storage, total_computers, new_subscription_period)
       end
   end
end

And /^I change my profile attributes to:$/ do |change_info_table|
  attributes = change_info_table.hashes.first

  # for changing PWD am going to pull a PWD value from the ENV file & use it
  # specific info that can be repopulated to the data_obj's

    @partner.credit_card.number = attributes["new_cc_num"]
    @partner.credit_card.type = attributes["new_cc_type"]
    @partner.credit_card.last_four_digits = attributes["last_four_digs"]
    @partner.admin_info.first_name = attributes["new_username_first"] unless attributes["new_username_first"].nil?
    @partner.admin_info.last_name = attributes["new_username_last"] unless attributes["new_username_last"].nil?
    @partner.admin_info.full_name = attributes["new_username_full"] unless attributes["new_username_full"].nil?

  # section: changing password, cc, username in my_profile
  # change password - changing to default bus_password - hard coded into method (temporarily)
  #   consideration: may be better to create a variable in the admin_info obj for password
  # change cc - default is Visa, setting to MasterCard
  # change user name - default is system generated, new one is tester created

  @phoenix_site.user_account.localized_click(@partner, 'profile_link')
  @phoenix_site.update_profile.change_password #(attributes["new_password"])
  @phoenix_site.user_account.localized_click(@partner, 'profile_link')
  @phoenix_site.update_profile.change_cc(@partner)
  @phoenix_site.user_account.localized_click(@partner, 'profile_link')
  @phoenix_site.update_profile.change_user_name(@partner)
end

And /^I logout of my (user|partner) account$/ do |account|
  case account
    when "user"
      @phoenix_site.user_account.logout(@partner)
    when "partner"
  end
end

# current plan summary check  or payment detials during change current plan
And /^the (current plan|payment details) summary looks like:$/ do |type, data_table|
  date_format = '%m/%d/%y'
  date_format = '%d/%m/%y' if @partner.company_info.country.include? 'France'
  expected = data_table.raw
  expected.each{|i|
    if i[1].start_with? '@'
      with_timezone(ARIA_ENV['timezone']) {i[1].replace(Chronic.parse(i[1].sub('@','')).strftime(date_format))}
      break
    end
  }
  if type == 'current plan'
    actual = @phoenix_site.update_profile.curplan_summary_tb_rows
  else
    actual = @partner.curplan_payment_summary
  end
  actual.should == expected
end

And /^the renewal plan summary looks like:$/ do |renewal_plan_table|
  expected = renewal_plan_table.raw
  actual = @phoenix_site.update_profile.renewal_plan_summary_tb_rows
  actual.should == expected
end

And /^the renewal plan summary is Same as current plan$/ do
  expected_text = "Same as current plan"
  if ["France", "Germany"].include?@partner.company_info.country
    expected_text = " #{LANG[@partner.company_info.country][@partner.partner_info.type]['same_as_current_plan']}"
  end
  @phoenix_site.update_profile.renewal_plan_same_as_message.should == expected_text.strip
end

And /^the renewal plan subscription looks like:$/ do |subscription_table|
  expected = subscription_table.raw
  actual = @phoenix_site.update_profile.submit_renewal_plan
  actual.should == expected
end

Then /^upgrade from free to paid will be successful$/ do
  @phoenix_site.reg_complete_pg.reg_comp_banner_present.should==true
  @phoenix_site.reg_complete_pg.upgrade_success(@partner)
end

And /^The prorated cost for these charge is (\S+)/ do |amount|
  #@phoenix_site.update_profile.get_prorated_cost.should == amount
end
