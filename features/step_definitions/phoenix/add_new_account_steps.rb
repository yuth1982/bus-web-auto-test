#
# This will add a phoenix account, either home or pro.
#
#



When /^I (.+) a phoenix (Home|Pro|Direct) (partner|user):$/ do |string,type, partner_or_user ,partner_table|
    # There were two Home signups, (When I add ...)(When I sign up...) The string combines them
    #(partner | user) is keep all tests cases working from when Home and Pro where separate
    attributes = partner_table.hashes.first
    @partner = Bus::DataObj::MozyPro.new
    
    @partner.partner_info.type = ((type == "Pro" || type == "Direct") ? "MozyPro" : "MozyHome")
    @partner.base_plan = attributes["base plan"] || ""
    @partner.has_server_plan = (attributes["server plan"] || "no").eql?("yes")
    
    # Company info attributes
    @partner.company_info.name = attributes['company name'] unless attributes['company name'].nil?
    @partner.company_info.address = attributes['address'] unless attributes['address'].nil?
    @partner.company_info.city = attributes['city'] unless attributes['city'].nil?
    @partner.company_info.state = attributes['state'] unless attributes['state'].nil?
    @partner.company_info.state_abbrev = attributes['state abbrev'] unless attributes['state abbrev'].nil?
    @partner.company_info.country = attributes["country"] unless attributes['country'].nil?
    @partner.company_info.zip = attributes['zip'] unless attributes['zip'].nil?
    @partner.company_info.phone = attributes['phone'] unless attributes['phone'].nil?
    @partner.company_info.vat_num = attributes["vat number"] unless attributes["vat number"].nil?
    
    # Partner info attributes
    @partner.partner_info.coupon_code = attributes["coupon"] unless attributes["coupon"].nil?
    @partner.partner_info.parent = attributes["create under"] || CONFIGS['bus']['mozy_root_partner']['mozypro']

    # Admin existing email check
    attributes['admin email'] = @existing_user_email if attributes['admin email'] == '@existing_user_email'
    attributes['admin email'] = @existing_admin_email if attributes['admin email'] == '@existing_admin_email'


    # Admin info attributes
    @partner.admin_info.full_name = attributes["admin name"] unless attributes["admin name"].nil?
    @partner.admin_info.email = attributes["admin email"] unless attributes["admin email"].nil?

    # Billing info attributes
    # Not implemented, always use company info
    
    # Credit card info attributes
    @partner.credit_card.first_name = attributes["cc first name"] unless attributes["cc first name"].nil?
    @partner.credit_card.last_name = attributes["cc last name"] unless attributes["cc last name"].nil?
    @partner.credit_card.number = attributes["cc number"] unless attributes["cc number"].nil?
    @partner.credit_card.expire_month = attributes["expire month"] unless attributes["expire month"].nil?
    @partner.credit_card.expire_year = attributes["expire year"] unless attributes["expire year"].nil?
    @partner.credit_card.cvv = attributes["cvv"] unless attributes["cvv"].nil?
    
    # Common attributes
    @partner.subscription_period = attributes["period"]
    
    #Maybe change the
    if type == "Home"
        case
            when attributes["period"].eql?("1")
            @partner.subscription_period = "M"
            when attributes["period"].eql?("12")
            @partner.subscription_period = "Y"
            when attributes["period"].eql?("24")
            @partner.subscription_period = "2"
        end
    end
    
    
    if type == "Direct"
        @phoenix_site.phoenix_partner_into_fill_out.got_to_pro_direct_page
        @phoenix_site.select_dom.select_country(@partner)
        @phoenix_site.phoenix_partner_into_fill_out.direct_fill_out(@partner)
        else
        @phoenix_site.select_dom.select_country(@partner)
        @phoenix_site.phoenix_partner_into_fill_out.admin_info_fill_out(@partner)
    end

    #If catches an error of already used email
    if @phoenix_site.phoenix_partner_into_fill_out.rp_error_messages.eql?(nil)
      @phoenix_site.licensing_fill_out.licensing_billing_fillout(@partner)
      @phoenix_site.billing_fill_out.billing_info_fill_out(@partner)
    end
    
end

Then /^the (order|billing) summary looks like:$/ do |type, billing_table|
    attributes = billing_table.hashes.first
    @phoenix_site.billing_fill_out.billing_summary_table_headers.should == billing_table.headers
#For some reason this is broken in home. I would love some feedback. I haven't changed it.
    @phoenix_site.billing_fill_out.billing_summary_table_rows.should == billing_table.rows unless @partner.partner_info.type == "MozyHome"
end


## Pro Specific
And /^the partner is successfully added.$/ do
    @phoenix_site.reg_complete_pg.reg_complete(@partner)
end

Then /^the default country is (.+) in the pro billing page$/ do |country|
    @phoenix_site.billing_fill_out.pro_billing_country.should == country
end

And /^they have logged in and verified their account.$/ do
    @bus_site = BusSite.new
    @bus_site.login_page.load
    @bus_site.login_page.partner_login(@partner)
    @phoenix_site.reg_complete_pg.new_partner_verify(@partner)
    @phoenix_site.reg_complete_pg.logout(@partner)
end

## Home Specific
Then /^the user is successfully added\.$/ do
    @phoenix_site.reg_complete_pg.home_success(@partner)
end

Then /^the default country is (.+) in the home billing page$/ do |country|
    Log.debug @phoenix_site.billing_fill_out.home_billing_country
    @phoenix_site.billing_fill_out.home_billing_country.should == country
end

When /^I change credit card info to:$/ do |contact_table|
    # table is a | Name: | Street Address: | City: | State/Province: | Zip/Postal Code: | Country: |
    company_info = contact_table.hashes.first
    company_info.keys.each do |header|
        case header
            when 'Name:'
            @partner.company_info.name = company_info['Name:']
            when 'Street Address:'
            @partner.company_info.address = company_info['Street Address:']
            when 'City:'
            @partner.company_info.city = company_info['City:']
            when 'State/Province:'
            @partner.company_info.state_abbrev = company_info['State/Province:']
            when 'Zip/Postal Code:'
            @partner.company_info.zip = company_info['Zip/Postal Code:']
            when 'Country:'
            @partner.company_info.country = company_info['Country:']
            else
            raise "Unexpected #{header}"
        end
    end
    # for info review
    # puts @partner.to_s
    puts @partner
    @phoenix_site.licensing_fill_out.licensing_billing_fillout(@partner)
    @phoenix_site.billing_fill_out.billing_info_fill_out(@partner)
end


When /^verify email address link should show success message$/ do
    @phoenix_site.verify_email_address.visit(@verify_email_query)
    @phoenix_site.verify_email_address.form_title_txt.should == "Email Address Verified"
    @phoenix_site.verify_email_address.form_message_txt.should == " Email Address has been verified"
end

Then /^sign up page error message should be:$/ do |message|
    @phoenix_site.phoenix_partner_into_fill_out.rp_error_messages.should eq(message)
end

Then /^sign up page error message to (.+) should be displayed$/ do |username|
    @phoenix_site.phoenix_partner_into_fill_out.rp_error_messages.should eq(" An account with email address \"#{username}\" already exists")
end