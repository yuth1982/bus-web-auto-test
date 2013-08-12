#
# This will add a phoenix account, either home or pro.
#
#
# encoding: utf-8


When /^I (.+) a phoenix (Home|Pro|Direct|Free) (partner|user):$/ do |string,type, partner_or_user ,partner_table|
    # There were two Home signups, (When I add ...)(When I sign up...) The string combines them
    #(partner | user) is keep all tests cases working from when Home and Pro where separate
    attributes = partner_table.hashes.first

	# initial object instantiation
    @partner = ((type == "Pro" || type == "Direct") ? Bus::DataObj::MozyPro.new : Bus::DataObj::MozyHome.new )

	# account type and relevant items
    @partner.partner_info.type = ((type == "Pro" || type == "Direct") ? "MozyPro" : "MozyHome")
    @partner.base_plan = attributes["base plan"] || ""
    @partner.has_server_plan = (attributes["server plan"] || "no").eql?("yes")
	
	if (type == "Home" || type == "Free")
		@partner.has_stash = (attributes["has stash"] || "no").eql?("yes")
		@partner.additional_computers = attributes['addl computers'] unless attributes['addl computers'].nil?
		@partner.additional_storage = attributes['addl storage'] unless attributes['addl storage'].nil?
	end
   
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
    if (type == "Home" || type == "Free")
        case
        when attributes["period"].eql?("1")
				  @partner.subscription_period = "M"
        when attributes["period"].eql?("12")
				  @partner.subscription_period = "Y"
        when attributes["period"].eql?("24")
				  @partner.subscription_period = "2"
        end
    end

    Log.debug(@partner)

    case type
		when "Direct"
			@phoenix_site.phoenix_acct_fill_out.go_to_pro_direct_page
			@phoenix_site.select_dom.select_country(@partner)
			@phoenix_site.phoenix_acct_fill_out.direct_fill_out(@partner)
		when "Free"
			@phoenix_site.phoenix_acct_fill_out.go_to_home_free
			@phoenix_site.select_dom.select_country(@partner)
			@phoenix_site.phoenix_acct_fill_out.free_user_info_input(@partner)
		when "Pro"
			@phoenix_site.select_dom.select_country(@partner)
			@phoenix_site.phoenix_acct_fill_out.admin_info_fill_out(@partner)
		when "Home"
			@phoenix_site.select_dom.select_country(@partner)
			@phoenix_site.phoenix_acct_fill_out.admin_info_fill_out(@partner)
    end

    #If catches an error of already used email
    unless @phoenix_site.phoenix_acct_fill_out.stuck_on_sign_up? || type == "Free"
      @phoenix_site.licensing_fill_out.licensing_billing_fillout(@partner)
      @phoenix_site.billing_fill_out.billing_info_fill_out(@partner)
    end
    
end

#AMMENDED: For some reason this works intermittently.  Original is unchange, commented out '# unless portion'.
Then /^the (order|billing) summary looks like:$/ do |type, billing_table|
    actual = @partner.billing_summary
    expected = billing_table.hashes
    expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

## Changed to more useful or the different account types
And /^the (partner|user) is successfully added(.|)$/ do  |_,_|
	if @partner.partner_info.type == "MozyPro"
		@phoenix_site.reg_complete_pg.reg_complete(@partner)
  else
    # if not a pro acct - its a home acct, but need to determine type still
    if @partner.base_plan == "free" #reg_complete_pg.check_url == "Home"
        # free acct url end with: registration/free_finish
        @phoenix_site.reg_complete_pg.free_home_success(@partner)
        sleep 2 # time for systems to catch up, this may be a symptom of a race condition w/ the mail systems
      else
        # paid accts url ends with: registration/mozy_home_finish
        @phoenix_site.reg_complete_pg.home_success(@partner)
        sleep 2 # time for systems to catch up, this may be a symptom of a race condition w/ the mail systems
      end
  end
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

# changed to add in locale and different verbage for home
When /^verify email address link should show success message$/ do
  @phoenix_site.verify_email_address.visit(@verify_email_query)
  if @partner.base_plan.eql?("free")
    @phoenix_site.reg_complete_pg.free_home_verified(@partner)
    # free users are taken to acct created screen, not mail verification page
  else
    @phoenix_site.verify_email_address.form_title_txt.should == "#{LANG[@partner.company_info.country][@partner.partner_info.type]['verify_mail_banner']}"
    @phoenix_site.verify_email_address.form_message_txt.should == " #{LANG[@partner.company_info.country][@partner.partner_info.type]['verify_mail_success']}"
  end
end

Then /^sign up page error message should be:$/ do |message|
    @phoenix_site.phoenix_partner_into_fill_out.rp_error_messages.should eq(message)
end

Then /^sign up page error message to (.+) should be displayed$/ do |username|
    @phoenix_site.phoenix_partner_into_fill_out.rp_error_messages.should eq(" An account with email address \"#{username}\" already exists")
end

# this piece may be combinable with the bus admin login step
When /^I login as the user on the account.$/ do
  @phoenix_site = PhoenixSite.new
  @phoenix_site.user_account.load
  @phoenix_site.user_account.user_login(@partner)
end

# this piece may be combinable with the verification of account step
When /^I verify the user account.$/ do
  @phoenix_site.user_account.login_verify(@partner)
end

# this relates to admin console account details
When /^(.+) account information should be:$/ do  |home_user_table|
  # table is a Cucumber::Ast::Table
  account_data = home_user_table.hashes.first

  @phoenix_site.user_account.account_detail_section.load_acct_home_section(@partner)
  @phoenix_site.user_account.account_detail_section.plan_details_headers.should == account_data.headers
  @phoenix_site.user_account.account_detail_section.plan_details_rows.should == account_data.rows
end

# added "( |partner)" for future flexibility
Then /^the (user|partner) has activated their account$/ do |_|
  # modified to search on subject first, then on user based on subset returned
  if @partner.base_plan.eql?("free")
    step %{I search emails by keywords:}, table(%{
      | subject |
      | #{LANG[@partner.company_info.country][@partner.partner_info.type]["free_mail_subject"]} |
      })
  else
    step %{I search emails by keywords:}, table(%{
      | subject |
      | #{LANG[@partner.company_info.country][@partner.partner_info.type]["verify_mail_subject"]} |
      })
  end
  if @partner.base_plan.eql?("free")
      step %{I retrieve email content by keywords:}, table(%{
      | to |
      | @new_admin_email |
      })
    else
      step %{I retrieve email content by keywords:}, table(%{
      | to |
      | @new_admin_email |
      })
  end
  step %{I get verify email address from email content}
  step %{verify email address link should show success message}
end