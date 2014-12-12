module Phoenix
  class UserAccount < SiteHelper::Page
    set_url("https://#{QA_ENV['phoenix_host']}/login")

    # section
    section(:account_detail_section, AccountDetailSection, css: 'div[id^=mainleftnav]/ul/li')

    # user account-based elements
    # login elements
    element(:username_tb, id: "username")
    element(:password_tb, id: "password")
    element(:submit_btn, css: "input.img-button")
    # user acct page elements
    element(:user_banner, id: "user-email")
    element(:main_section_head, css: "h2")
    element(:go_fwd_link, id: "Go to Account")
    element(:billing_hist_tbl, id: "credit_card_transactions") #cc transaction table
    element(:current_pln_tbl, css: "td.subscription_viewpane_top") #current plan table on plan page
    element(:chg_plan_header, css: "div.center-form-box > h2") # change plan page head
    element(:chg_plan_content_txt, css: "div.inner-center-form-box > p")  # text of paragraph for change plan
    # elements in Account Home page
    # Computers section, e.g. '0 of 250 GB used'
    element(:quota_account_span, xpath: "//div[@id='quota-box']/span")
    # Plan Details table
    element(:plan_details_account_tbl, xpath: "//table[@class='key_value_table fixed']")
    # change plan link: To chagne your plan, click here
    element(:change_plan_account_link, xpath: "//div[@id='maincontent']//a[@href='/plan']")

    # this method verifies that the acct logged into belongs to this specific user
    # the banner should match the users email address
    #   it also clicks on the main left nav items:
    #     (acct home,my plan - computer - profile, dl mozy, stash..)
    #   and verifies the header in the content pane reflects the correct location
    def login_verify(partner)
      user_banner.visible?.eql?(partner.admin_info.email)
        if partner.base_plan.eql?("free")
          free_user_verify(partner)
        else
          paid_user_verify(partner)
        end
    end

    # procedure to verify a paid user account
    def paid_user_verify(partner)
      go_to_plan(partner)  # my plan page
      go_to_devices(partner) # devices
      go_to_profile(partner) # profile page
      go_to_downloads(partner)
      go_to_stash(partner)
      go_to_acct(partner) # default is to load this page w/o a 'go to account' link
    end

    # procedure for verification of a free user account
    def free_user_verify(partner)
      go_to_referrals(partner) # referrals page, they have a free plan
      go_to_upgrade(partner) # this page takes them into phoenix
      go_to_devices(partner) # devices
      go_to_downloads(partner)
      go_to_stash(partner)
      go_to_acct(partner) # default is to load this page w/o a 'go to account' link
    end

    # go to acct section
    def go_to_acct(partner)
      localized_click(partner, 'acct_link')
      main_section_head.eql?("#{LANG[partner.company_info.country][partner.partner_info.type]['acct_link']}")
    end

    # go to my plan section
    def go_to_plan(partner)
      localized_click(partner, 'plan_link')
      main_section_head.eql?("#{LANG[partner.company_info.country][partner.partner_info.type]['plan_link']}")
    end

    # go to devices section
    def go_to_devices(partner)
      localized_click(partner, 'devices_link')
      main_section_head.eql?("#{LANG[partner.company_info.country][partner.partner_info.type]['devices_link']}")
    end

    # go to dl link
    def go_to_downloads(partner)
      localized_click(partner, 'dl_link')
      main_section_head.eql?("#{LANG[partner.company_info.country][partner.partner_info.type]['dl_link']}")
    end

    # go to profile
    def go_to_profile(partner)
      localized_click(partner, 'profile_link')
      main_section_head.eql?("#{LANG[partner.company_info.country][partner.partner_info.type]['profile_link']}")
    end

    # go to stash
    def go_to_stash(partner)
      # stash-beta is available for US/UK/IE only
      # GA for this feature is set for 09/2013
      case partner.company_info.country
        when "France"
          #skip stash
        when "Germany"
          #skip stash
        else
            localized_click(partner, 'stash_link')
            main_section_head.text.match("#{LANG[partner.company_info.country][partner.partner_info.type]['stash_link']}")
      end
    end

    # go to referrals
    def go_to_referrals(partner)
      localized_click(partner, 'refer_link')
      main_section_head.eql?("#{LANG[partner.company_info.country][partner.partner_info.type]['refer_link']}")
    end

    # go to change plan
    #def go_to_change_plan(partner) # goes out into phoenix, then back to acct
    #  localized_click(partner, 'change_plan')
    #  localized_click(partner, 'my_account')
    #end

    # go to upgrade
    def go_to_upgrade(partner)  # goes out into phoenix, then back to acct
      localized_click(partner, 'upgrade_link')
      localized_click(partner, 'my_account')
    end

	# supporting methods
	
    def navigate_to_link(link)
      find_link(link).click
    end

    def has_nav?(link)
      all(:xpath, "//a[text() = '#{link}']")
    end

    def localized_click(partner, loc_click)
      navigate_to_link("#{LANG[partner.company_info.country][partner.partner_info.type][loc_click]}")	;end
    def localized_select(loc_item, partner, loc_select)
      loc_item.select("#{LANG[partner.company_info.country][partner.partner_info.type][loc_select]}")	;end

    def user_login(partner)
      username = partner.admin_info.email
      password = CONFIGS['global']['test_pwd']
      phoenix_login(username,password)
    end

    def user_login_changed_pw(partner)
      username = partner.admin_info.email
      password = QA_ENV['bus_password']
      phoenix_login(username,password)
    end

    def phoenix_login(username,password)
      username_tb.type_text(username)
      password_tb.type_text(password)
      submit_btn.click
    end

    def logout(partner)
      localized_click(partner, 'logout_link')
    end

    def get_quota_account_page(partner)
      localized_click(partner, 'acct_link')
      quota_account_span.text
    end

    def get_plan_details_account_page
      wait_until{plan_details_account_tbl.visible?}
      plan_details_account_tbl.rows_text
    end

    def click_change_plan_account_page
      change_plan_account_link.click
    end
  end
end
