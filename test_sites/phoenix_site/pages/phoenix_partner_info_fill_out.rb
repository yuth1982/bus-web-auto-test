module Phoenix
    # This class provides actions for phoenix registration page
    class PhoenixCreation < SiteHelper::Page
        
        set_url("#{PHX_ENV['phx_host']}/registration")
                
        ##Normal creation: mozy.com/registration create
        
        #Landing Page
        element(:new_admin_display_name_tb, id: "person_display_name")
        element(:new_admin_username_tb, id: "person_username")
        element(:new_admin_zip_tb, id: "person_zip")
        element(:new_admin_country_select, id: "person_country")
        element(:password_tb, id: "person_password")
        element(:reenter_password_tb, id: "person_password_confirmation")
        element(:mozypro_radio, id: "product_mozypro")
        element(:mozyhome_radio, id: "product_mozyhome")
        
        element(:next_btn, id: "next-button")
        element(:continue_btn, css: "input.img-button")
        element(:back_btn, id: "back_button")
        element(:submit_btn, id: "submit_button")
        element(:error_message, css: "p.error")
        #Verification of Labeled Elements
        element(:su_form_lbl, css: "div.center-form-box.vertical-align > h2")
        element(:name_lbl, css: "dt.input_label")
        element(:email_lbl, xpath: "//div[@id='main']/div/div/div/div/div[2]/div/div/form/dl/dt[2]")
        element(:password_lbl, xpath: "//div[@id='main']/div/div/div/div/div[2]/div/div/form/dl/dt[3]")
        element(:password_info_lbl, css: "span.field-info")
        element(:password_again_lbl, xpath: "//div[@id='main']/div/div/div/div/div[2]/div/div/form/dl/dt[4]")
        element(:country_lbl, xpath: "//div[@id='main']/div/div/div/div/div[2]/div/div/form/dl/dt[5]")
        element(:zip_post_code_lbl, xpath: "//div[@id='main']/div/div/div/div/div[2]/div/div/form/dl/dt[6]")
        element(:plan_note_lbl, css: "div.inner-center-form-box > form > p")
        element(:plan_choice_lbl, css: "dl.clear > dt")
        element(:home_supports_lbl, xpath: "//div[@id='main']/div/div/div/div/div[2]/p[2]")
        element(:pro_supports_lbl, xpath: "//div[@id='main']/div/div/div/div/div[2]/p[3]")
        
        def verify_registration_page_elements
            su_form_lbl.visible?
            name_lbl.visible?
            new_admin_display_name_tb.visible?
            email_lbl.visible?
            new_admin_username_tb.visible?
            password_lbl.visible?
            password_tb.visible?
            password_info_lbl.visible?
            password_again_lbl.visible?
            reenter_password_tb.visible?
            country_lbl.visible?
            new_admin_country_select.visible?
            zip_post_code_lbl.visible?
            new_admin_zip_tb.visible?
            plan_choice_lbl.visible?
            mozypro_radio.visible?
            mozyhome_radio.visible?
            plan_note_lbl.visible?
            home_supports_lbl.visible?
            pro_supports_lbl.visible?
            continue_btn.visible?
        end
        
        def admin_info_fill_out(partner)
            verify_registration_page_elements
            # admin info fill out
            acct_admin_info_fill_out(partner)
            # pro/home selection
            partner.partner_info.type.eql?("MozyHome") ? mozyhome_radio.click : mozypro_radio.click
            continue_btn.click
            
            fill_in_pro_elements(partner) if partner.partner_info.type.eql?("MozyPro")
        end
        
        def acct_admin_info_fill_out(partner)
            new_admin_display_name_tb.type_text(partner.admin_info.full_name)
            new_admin_username_tb.type_text(partner.admin_info.email)
            password_tb.type_text(CONFIGS['global']['test_pwd'])
            reenter_password_tb.type_text(CONFIGS['global']['test_pwd'])
            new_admin_country_select.select(partner.company_info.country)
            new_admin_zip_tb.type_text(partner.company_info.zip)
        end
        
        def rp_error_messages
            error_message.text
        end
        
        #Continuing MozyPro Steps
        element(:new_partner_name_tb, id: "partner_name")
        element(:contact_address_tb, id: "contact_address")
        element(:contact_city_tb, id: "contact_city")
        element(:contact_country_select, id: "contact_country")
        element(:contact_state_tb, id: "contact_state")
        element(:contact_state_us_select, id: "contact_state_us")
        element(:contact_zip_tb, id: "contact_zip")
        element(:contact_phone_tb, id: "contact_phone")
        element(:contact_partner_industry_select, id: "partner_industry")
        element(:contact_number_employees_select, id: "partner_num_employees")
        element(:contact_response_select, id: "responses")
        element(:reseller_link, id: "Sign up here.")
        
        #To fill out survey info
        def localized_select(loc_item, partner, loc_select)
            loc_item.select("#{LANG[partner.company_info.country][partner.partner_info.type][loc_select]}"); end
        def localized_click(partner, loc_click)
            navigate_to_link("#{LANG[partner.company_info.country][partner.partner_info.type][loc_click]}"); end
        def survey_industry(partner)
            localized_select(contact_partner_industry_select, partner, 'survey_industry') ;end
        def survey_employees(partner)
            localized_select(contact_number_employees_select, partner, 'survey_num_employees') ;end
        def survey_contact_response(partner)
            localized_select(contact_response_select, partner, 'survey_contact_res') ;end
        
        def fill_in_pro_elements(partner)
            new_partner_name_tb.type_text(partner.company_info.name)
            contact_address_tb.type_text(partner.company_info.address)
            contact_city_tb.type_text(partner.company_info.city)
            if partner.company_info.country.eql?("United States")
                contact_state_us_select.select(partner.company_info.state_abbrev)
                else
                contact_state_tb.type_text(partner.company_info.state)
            end
            contact_country_select.select(partner.company_info.country)
            contact_zip_tb.type_text(partner.company_info.zip)
            contact_phone_tb.type_text(partner.company_info.phone)
            #questionaire info
            #case statement keying on country, based on that selecting specific values from the survey drop down
            survey_industry(partner)
            survey_employees(partner)
            survey_contact_response(partner)
            
            continue_btn.click
        end
        
        ##Direct Pro creation: mozy.com/registration/business
        element(:direct_admin_display_name, id: "admin_display_name")
        element(:direct_admin_username, id: "admin_username")
        element(:direct_password, id: "admin_password")
        element(:direct_reenter_password, id: "admin_password_confirmation")
        #The rest are the same as the Pro above
        
        def got_to_pro_direct_page
            find(:xpath, "//a[text()='Products']").click
            find(:xpath, "//a[contains(@href,'/registration/business')]").click
        end
        
        def direct_fill_out(partner)
            direct_admin_display_name.type_text(partner.admin_info.full_name)
            direct_admin_username.type_text(partner.admin_info.email)
            direct_password.type_text(CONFIGS['global']['test_pwd'])
            direct_reenter_password.type_text(CONFIGS['global']['test_pwd'])
            fill_in_pro_elements(partner)
        end
        
        
        #We might want to add a Free option for mozy.com/registration/free
        
    end
end
