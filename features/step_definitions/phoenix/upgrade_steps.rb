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

        find(:xpath, "//a[contains(@href,'/registration/mozy_home')]").click
        @phoenix_site.licensing_fill_out.licensing_billing_fillout(@partner)
        @phoenix_site.billing_fill_out.billing_info_fill_out(@partner)
        @phoenix_site.reg_complete_pg.upgrade_success(@partner)
        @phoenix_site.user_account.localized_click(@partner, 'my_account')
      when "partner"

        # general info for upgrading acct from home to pro

      when "user"
        @partner.base_plan = attributes["base plan"] || ""
        @partner.has_stash = (attributes["has stash"] || "no").eql?("yes")
        @partner.additional_computers = attributes['addl computers'] unless attributes['addl computers'].nil?
        @partner.additional_storage = attributes['addl storage'] unless attributes['addl storage'].nil?

        # general info relevant to upgrading a current home user acct

        find(:xpath, "//a[contains(@href,'/plan')]").click
        @phoenix_site.update_profile.change_plan_current(@partner)
        step %{I logout of my user account}
    end
    # for changing the current account - ie .. going from monthly to biennial billing
    when "change"
      case acct_type
        when "user"
          @partner.base_plan = attributes["base plan"] || "" unless attributes['base plan'].nil?
          @partner.additional_computers = attributes['addl computers'] unless attributes['addl computers'].nil?
          @partner.additional_storage = attributes['addl storage'] unless attributes['addl storage'].nil?

          # general info relevant to upgrading a current home user acct
          case
            when attributes["period"].eql?("1")
              @partner.subscription_period = "M"
            when attributes["period"].eql?("12")
              @partner.subscription_period = "Y"
            when attributes["period"].eql?("24")
              @partner.subscription_period = "2"
          end

          find(:xpath, "//a[contains(@href,'/plan')]").click
          @phoenix_site.update_profile.change_plan_future(@partner)
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