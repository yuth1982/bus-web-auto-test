module Aria
  class AccountOverviewView < PageObject

    # Navigation links


    # View links
    element :master_plan_link, {:link => "Master Plan"}
    element :change_master_plan_link, {:link => "Change Master Service Plan"}

    element :supplemental_plans_link, {:link => "Supplemental Plans"}
    element :save_plan_btn, {:id => "submit-button"}
    element :plan_saved_msg_div, {:class => "error-box"}

    element :replace_plan_links, {:link => "REPLACE"}

    element :save_supp_plan_btn, {:xpath => "//input[@value='Save Changes']"}

    element :assign_option_select, {:id => "inAssignOptionsIgnore"}


    element :taxpayer_id_dd, {:xpath => "//form/fieldset/dl/dd[1]"}
    element :tax_exempt_status_dd, {:xpath => "//form/fieldset/dl/dd[2]"}
    element :edit_tax_exempt_btn, {:xpath =>"//input[@value='Edit Fields']"}
    element :save_tax_exempt_btn, {:xpath =>"//input[@value='Save Changes']"}

    element :federal_tax_exempt_cb, {:xpath =>"//input[@name='inFederalTaxExempt']"}
    element :state_tax_exempt_cb, {:xpath =>"//input[@name='inStateProvTaxExempt']"}



    def set_federal_exempt_taxes status
      edit_tax_exempt_btn.click
      federal_tax_exempt_cb.uncheck unless status
      save_tax_exempt_btn.click
    end

    def set_state_exempt_taxes status
      edit_tax_exempt_btn.click
      state_tax_exempt_cb.uncheck unless status
      save_tax_exempt_btn.click
    end

    def change_master_plan plan_mapping
      master_plan_link.click
      change_master_plan_link.click

      # plan id in each forms
      plan_ids = driver.find_elements(:xpath, "//form/div/dl/input")
      plan_ids.each_with_index do |pid,index|
        if pid.attribute("value") == plan_mapping.master_plan_id
          # assignment options
          assign_immediate_rb =  driver.find_element(:xpath, "//form[#{index+1}]/div/dl/dd[6]/input[2]")
          assign_immediate_rb.click
          # select plan btn
          driver.find_element(:xpath, "//form[#{index+1}]//input[@value='Select Plan']").click
          save_plan_btn.click
          plan_saved_msg_div.displayed?
        end
      end
    end

    def change_supplemental_plans plan_mapping
      switch_to_inner_work_frame
      supplemental_plans_link.click

      for link in replace_plan_links
        before_href = link.href        after_href = "#{link.href.gsub("inPlanNo", "inOldPlanNo")}&inNewPlanNo=#{plan_mapping.desk_licence_id}"
        after_href = "#{link.href.gsub("inPlanNo", "inOldPlanNo")}&inNewPlanNo=#{plan_mapping.server_licence_id}"
        after_href = "#{link.href.gsub("inPlanNo", "inOldPlanNo")}&inNewPlanNo=#{plan_mapping.desk_quota_id}"
        after_href = "#{link.href.gsub("inPlanNo", "inOldPlanNo")}&inNewPlanNo=#{plan_mapping.server_quota_id}"

      end
      #dashboard_plan.supp_plan_replace_2?inOldPlanNo=10293261&inNewPlanNo=10293237
      #dashboard_plan.supp_plan_replace_1?inPlanNo=10293261

      assign_option_select.select_by(:text,"Assign Immediately")

      save_plan_btn.click

      save_supp_plan_btn.click

      plan_saved_msg_div.displayed?
    end
  end
end
